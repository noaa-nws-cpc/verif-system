package gov.noaa.ncep.cpc.driver;

// Import all packages needed
import gov.noaa.ncep.cpc.data.Data;
import gov.noaa.ncep.cpc.exception.InvalidSettingException;
import gov.noaa.ncep.cpc.format.Format;
import gov.noaa.ncep.cpc.format.XMLReader;
import gov.noaa.ncep.cpc.qc.Log;
import gov.noaa.ncep.cpc.services.Results;
import gov.noaa.ncep.cpc.settings.Settings;
import gov.noaa.ncep.cpc.stats.Stats;
import gov.noaa.ncep.cpc.resources.Resources;

import gov.noaa.ncep.cpc.utils.Date;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Arrays;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.OptionBuilder;
import org.apache.commons.cli.ParseException;
import org.apache.commons.cli.PosixParser;
import org.apache.log4j.Logger;
import org.ini4j.Wini;

/**
CPC Verification system driver that is the main engine for both creating the pre-processed graphics and dynamic web application. Uses paramaters to obtain data and calculate a statistics score and format the output. Data is obtained from the database based on the settings and then statistics are calculated on the data and formatted for the passed variables 'scoreType' and 'outputType'. The method, runDriver(...), that does these functions does not return anything, but the driver contains a get method to access an XML string of formatted score values calculated by the runDriver(...) method.
<p>
This driver performs the following functions that leads to creating output score data :
<ul>
<li> Creates a settings object from the options in the form on the web tool via Javascript  tool
<li> Finds the data in a MySQL database that is required to perform the user's selections
<li> Calculates statistics based on user options and input data from a database
<li> Formats output from the calculated scores into XMl
</ul>
*/
public class VerificationDriver {

	static String outputFmtString = null;
	Settings settingsObj = null;
	Results resultsObj = null;
	Format formatObj = null;
	static String homeDir = null;

	//static String summaryArray [][] = null;

	// Initialize all variables
	Connection dbConnection = null;
	// set flag for dbConnectionStatus to 0 by default.
	// This variable will be set to '1' if the setDbConnection was passed by ie. the JApplet program.
	int dbConnectionStatus = 0;
	static protected Logger logger; // Initialize logger

	// Constructor
	public VerificationDriver() {
		logger = Logger.getLogger(VerificationDriver.class.getName());
		logger.info("Starting verification driver");
		logger.info("Got logger for driver");
	}

/**
Main engine of driver. Accepts settings parameters, and performs major back-end work of the verification software. Functions included in this method are :
<ul>
<li> Creates a Settings object by loading the parameter settings into the object. This allows the settings object to be accessed with get and set methods to contain values of the parameters.
<li> Creates a Data object. Uses parameter settings to access appropriate data from a database and loads the data into the Data object which can be used to access the loaded data.
<li> Creates a Stats object. Uses the Data and Settings object to perform statistical calculation(s). This Stats object can then be accessed to get the calculated score data.
<li> Creates a Format object. Uses the calculated score(s) and Settings object information to format the output statistics data appropriately for the scoreType and outputType.
</ul>
<p>
@param settingsArray an array of String values of settings parameters. See settings object for details.
@param webFlag Boolean value of 'true' if web services is initating the run-time, 'false' if web services is not initiating run-time.
<p>
Notes:<p>
- The String representing the Java SimpleDateFormat of the dates of the date issued of forecast data in the database is set in runDriver() to 'yyyy-MM-dd'. This assumes that all the dates in the database utilize this format. This is typically true because MySQL requires this format.
*/
	public void runDriver(String[] settingsArray, boolean webFlag) throws Exception {

		// Initialize variables
		String scoreValues [][];

		logger.trace("Starting runDriver() ...");

		// Create a new Settings object
		logger.info("Creating a new Settings object...");
		// Create a new Settings object with the settingsArray
		settingsObj = new Settings(settingsArray);
		// Set web flag
		settingsObj.setWebFlag(webFlag); 
		// Set the home directory in the settings object. This is the root path
		// obtained by a global environment variable.
		// By default the home variable is set to null.
		// ONLY the STATIC COMMAND LINE version of running this method
		// sets a home value. This is executed in StaticRunDriver.class.
		// An applet application will ignore this.
		settingsObj.setHomeDir(homeDir);
		// Call Settings.setECType(), which will set the value of ECType in the Settings Object. This
		// needs to be called explicitly because the user might have set ECType to "default", which
		// means ECType needs to be set automatically based on the lead/scoreType by setECType()
		settingsObj.setECType(settingsObj.getECType());
// 		logger.debug("Settings object memory size = " + MemoryUtil.deepMemoryUsageOf(settingsObj));

		// Check for invalid options in settings (regions are not checked because for states and climate divisions
		// there are too many to check)
		try {
			settingsObj.validateSettings();
		} catch (InvalidSettingException e) {
//			logger.fatal(e);
			throw e;
		}

		// Load MySQL settings from a configuration file
		Wini ini = null;
		try {
			ini = new Wini(Resources.getURL("verif.conf"));
		} catch (Exception e) {
			logger.fatal("Cannot open configuration file verif.conf in gov/noaa/ncep/cpc/resources: " + e);
			throw e;
		}
		// Get database names
		String fcstDBName = ini.get("mysql","db_fcst");
		String obsDBName  = ini.get("mysql","db_obs");
		String climDBName = ini.get("mysql","db_clim");
		String refDBName  = ini.get("mysql","db_ref");
		String VWTDBName  = ini.get("mysql","db_VWT");
		// Set these database names in the stats object
		settingsObj.setDBNames(fcstDBName, obsDBName, climDBName, refDBName, VWTDBName);
		logger.info("Obtained settings :" + Arrays.toString(settingsArray));

		//-------------------------------------------------
		// Get the data
		//-------------------------------------------------

    	// call the Results driver which will read from the database and create the results object
		logger.info("Getting the results...");
		resultsObj = getResults(dbConnection, settingsObj);
		// If the Results failed, then resultsObj.getResultType() will == Results.RESULT_TYPE_ERROR. If this is the case,
		// then (now that we're back on the clientside) we should throw a new Exception who's message contains the error
		// message in the Results object.
		if (resultsObj.getResultType() == Results.RESULT_TYPE_ERROR) {
			logger.error("Failed to get results from the servlet, here's the error message: "+resultsObj.getErrorMessage());
			// Take the error message and use it to throw an Exception
			throw new Exception(resultsObj.getErrorMessage());
		}

		// Print out stats
		String[][][] statsArray= null;
		try {
			statsArray = resultsObj.getStats().getScoreCatStringArray();
		} catch (Exception e) {
			throw e;
		}
		// Fcst source
		for (int j=0; j<statsArray.length;j++) {
			// For each category (total,B,N,A)
			for (int k=0;k<statsArray[0].length; k++) {
				// For each of the reference values
				for (int i=0;i<statsArray[0][0].length;i++) {
					logger.trace("For fcst source : " + j + " For category : " + k + " score is " + statsArray[j][k][i]);
				}
			}
		}

		//-------------------------------------------------
		// Generate the output
		//-------------------------------------------------
// 		logger.debug("Format object memory size = " + MemoryUtil.deepMemoryUsageOf(settingsObj));
		// Get the formatted data from the format object.
		logger.info("Generating the output...");
 		outputFmtString = Format.getFormattedData(resultsObj, settingsObj);
		logger.info("Finished running runDriver()");
	} // End runDriver()
	//-----------------------------------------------------
	// End makeDisplay method
	//-----------------------------------------------------

	/**
	Returns a Settings object.

	@return Settings object
	*/
	public Settings getSettingsObj() {
		return settingsObj;
	}

	/**
	Returns a Stats object.

	@return Stats object
	*/
	public Stats getStatsObj() {
		logger = Logger.getLogger(VerificationDriver.class.getName());
		if (resultsObj != null)
		{
		  return resultsObj.getStats();
		}

		return null;
	}

	/**
	Returns a Results object.

	@return Results object
	*/
	public Results getResultsObj() {
		logger = Logger.getLogger(VerificationDriver.class.getName());
		if (resultsObj == null) {
			logger.warn("resultsObj is null");
		}
		else {
			logger.trace("resultsObj not null");
		}
		return resultsObj;
	}

	/**
	Sets the database connection.
	*/
	public void setDbConnection(Connection conn) {
		dbConnectionStatus  = 1;
		dbConnection = conn;
	}
	/**
	Gets the database connection status value, which is an integer. This returns 0 or
	null if there is no connection, returns 1 if there is a connection.

	@return integer value of the database connection status
	*/
	public int getDbConnectionStatus() {
		return dbConnectionStatus;
	}
	/**
	 * Sets the Verification System home directory
	 *
	 * @param str  The Verification System home directory
	 */
	public void setHomeDir(String str) {
		homeDir = str;
	}



	/**
	Returns a String of XML formatted data.

	 @return String of formatted XML score data
	*/
	public static String getXMLString() {
		return outputFmtString;
	}


  private Results getResults(Connection dbConnection, Settings settingsObj)
  {
    Results results = new Results();

    java.util.Date date = new java.util.Date();
    results.setTimestamp(date.getTime());


    Data dataObj = new Data();
    dataObj.setDbConnection(dbConnection);
    dataObj.setSdfSourceFormat("yyyy-MM-dd");

    try {
      // load data
      dataObj.loadData(settingsObj);

      // Create a new Stats object
      Stats statsObj = new Stats();
      try {
        statsObj.calcStats(dataObj, settingsObj);

        // Populate results
        results.setResultType(Results.RESULT_TYPE_SUCCESS);
        results.setErrorMessage("No Error");
        results.setStats(statsObj);
        results.setFormattedReferenceDatesArray(dataObj.getFormattedReferenceDatesArray());
        results.setLocationLatArray(dataObj.getLocationLatArray());
        results.setLocationLonArray(dataObj.getLocationLonArray());
        results.setLocationNameArray(dataObj.getLocationNameArray());
        results.setReferenceArray(dataObj.getReferenceArray());
        results.setFcstDateValidBounds(dataObj.getFcstDateValidBounds());
        results.setNumUniqueFcstDates(dataObj.getNumUniqueFcstDates());
      }
      catch (Exception e) {
        logger.error("Problem calling calcStats on the stats object: " + e);
        results.setResultType(Results.RESULT_TYPE_ERROR);
        results.setErrorMessage(e.getMessage());
      }
    } catch (Exception e) {
      logger.error("There was a problem loading the data: " + e);
      results.setResultType(Results.RESULT_TYPE_ERROR);
      results.setErrorMessage(e.getMessage());
    }

    return results;
  }

	/**
	Runs the VerificationDriver with settings obtained from an XML file. This XML file path and file name is specified during the initiation of the code. There is no graphics of charts or maps produced from this run. There is nothing returned, it only sets the database connection and runs runDriver(). To run the job completely to get plots, use StaticRunDriver.class in the driver package.
	*/
	public static void main(String[] args) {
	// element tag that specifies a new set of settings
		String settingsSeparator = "settings";
		Connection dbConnection = null;
		boolean webFlag = false; // Set web flag to false if this class is ran, then not web services.

		// Load MySQL settings from a configuration file
		Wini ini = null;
		try {
			ini = new Wini(new File(homeDir+"/input/verif_direct_access.conf"));
		} catch (Exception e) {
			logger.fatal("Cannot open configuration file "+homeDir+"/input/verif_direct_access.conf: " + e);
			System.exit(0);
		}
		String dbHost = ini.get("mysql","host");
		String dbUser = ini.get("mysql","user");
		String dbPassword = ini.get("mysql","password");

		// Create a connection to MySQL
		logger.info("Connecting to MySQL...\n");
		try {
			// Create connection
			dbConnection = DriverManager.getConnection("jdbc:mysql://"+dbHost+"/?user="+dbUser+"&password="+dbPassword);
		} catch (SQLException e) {
			// handle any errors
			logger.fatal("SQLException: " + e.getMessage());
			logger.fatal("SQLState: " + e.getSQLState());
			logger.fatal("VendorError: " + e.getErrorCode());
		}
		logger.info("Connection: " + dbConnection);
		// Initialize variables
		CommandLine cmd = null;
		// Create an Options object
		org.apache.commons.cli.Options options = new org.apache.commons.cli.Options();
		// Add all possible command-line options
		// ** TO DO - Add option for log4j configuration file (See staticRunDriver.class)
		options.addOption( OptionBuilder.withLongOpt("settingsXMLfile")
										.withDescription("File containing runtime settings")
										.isRequired()
										.hasArg()
										.create("f") );
		// Create a CommandLineParser object
		CommandLineParser parser = new PosixParser();
		try {
			cmd = parser.parse(options, args);
		} catch( ParseException e) {
			logger.error("Parsing failed: " + e.getMessage());
			// Automatically generate a help message
			HelpFormatter formatter = new HelpFormatter();
			formatter.printHelp("java StaticRunDriver [OPTIONS]",options);
			System.exit(0);
		}
		// Get the settings file
		String settingsXMLFile = cmd.getOptionValue("settingsXMLfile");
		logger.debug("Settings XML file: " + settingsXMLFile);
		String settingsArray[][] = XMLReader.readXMLFile(settingsXMLFile,settingsSeparator);
		logger.debug("Settings string returned from XMLReader.class is : " + settingsArray);
		VerificationDriver driverObj = new VerificationDriver();
		logger.info("Setting database connection...");
		driverObj.setDbConnection(dbConnection);
		logger.info("Completed making database connection");
		try {
			driverObj.runDriver(settingsArray[0],webFlag);
		} catch (Exception e) {
			logger.fatal("Driver run failed: " + e);
			Log.fatal("Driver run failed","#errorPanelText");
			System.exit(0);
		}
		logger.info("Note that the verification driver does not create output, but formats data (if needed, ascii is written directly so no formatting is done by this driver.). It is the job of the initiation code calling this driver to create ouptut.");
	} // End main

} // End class VerificationDriver.java
