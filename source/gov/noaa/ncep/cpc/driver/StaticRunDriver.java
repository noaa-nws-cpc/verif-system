package gov.noaa.ncep.cpc.driver;

import gov.noaa.ncep.cpc.display.PlotChart;
import gov.noaa.ncep.cpc.format.FormatLibrary;
import gov.noaa.ncep.cpc.format.WriteLibrary;
import gov.noaa.ncep.cpc.format.XMLReader;
import gov.noaa.ncep.cpc.qc.Log;
import gov.noaa.ncep.cpc.qc.Requirements;
import gov.noaa.ncep.cpc.services.Results;
import gov.noaa.ncep.cpc.settings.Settings;

import java.awt.Image;
import java.io.File;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.OptionBuilder;
import org.apache.commons.cli.ParseException;
import org.apache.commons.cli.PosixParser;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.ini4j.Wini;

/**
Initiates the verification driver and displays and saves graphics of plots. Accepts a
file name with the initiation of this program that contains the XML formatted data
file with settings information to process the verification for.
<p>
Command line initiation example :
<p>
> java gov/noaa/ncep/cpc/driver/StaticRunDriver.java -f /path/to/settingsXMLFile/fileName.xml -l /path/to/log/config/file
<p>
where -f is the flag representing a following file name, and the path and file name to
a settings XML formatted data file with all the settings to process the run for, and
-l is the flat representing a following file name, an dpath and file name to a log
configuration file for Log4J logging.
*/
public class StaticRunDriver {

	// Initialize all variables
	static Logger logger;
	static String homeDir = null;
	static PlotChart chart;
	VerificationDriver driverObj;
	Settings settingsObj = null;
  	Results resultsObj = null;
	static String settingsXMLFile;
	static String logConfigFile;
	Connection dbConnection = null;
	static String errorMsg = "<html><center><H2>Applet could not be" +
			" loaded!</H2></CENTER><p>" +
			"The necessary classes to load the applet could not be found.<P>" +
			"Some troubleshooting notes:<UL>" +
			"<LI>In JDK 1.2 or later, the appletviewer does not honor your CLASSPATH." +
			"<LI> Some browsers do not support Java 2.  For others you will need to " +
			"install the Java Plug-in." +
			"</UL>";
	// element tag that specifies a new set of settings
	static String settingsSeparator = "settings";
	String outputType = null;
	/**
	Initiates the main verificationdriver, VerificationDriver. Performs the following
	functions :
	<p>
	<li>Makes a connection to the database
	<li>Reads in an XML file with settings data
	<li>Runs the verification driver to get stats
	<li>Creates a chart of the stats data
	<li>Closes the connection to the database
	*/
	public StaticRunDriver() throws Exception {
		boolean webFlag = false; // Sets flag specifying that run-time is not initiated by web services.
		String fileName = null;
		// Load MySQL settings from a configuration file (this file resides on the
		// actual filesystem, since this is being run on the command line
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
		// Load the MySQL driver
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (Exception e) {
			logger.error("Threw an expcetion : ", e);
		}
		// Create a connection to MySQL
		String connectionURL = "jdbc:mysql://"+dbHost+"/?user="+dbUser+"&password="+dbPassword+"&characterEncoding=utf8";
		logger.info("Connecting to MySQL: jdbc:mysql://"+dbHost+"/?user="+dbUser);
		try {
			// Create connection
			dbConnection = DriverManager.getConnection(connectionURL);
			logger.debug("Trying to make connection to the database");
		} catch (SQLException e) {
			logger.fatal("SQLException: " + e.getMessage());
			logger.fatal("SQLState: " + e.getSQLState());
			logger.fatal("VendorError: " + e.getErrorCode());
			Log.fatal("Database connection failure","#errorPanelText");
			throw e;
		}
		logger.info("Successfully made connection to database : " + dbConnection);
		logger.debug("If there is an out of bounds array exception, it might be because a setting variable is missing from the 'orderedEleArray' in format/XMLReader.java. There is a hard-wired list of settings variables that needs to match up with the settings in the settings object.");
		logger.debug("Settings file to read is : " + settingsXMLFile + " Settings separator is : " + settingsSeparator);
		// Read settings parameters from an XML file
		String[][] settingsArray = XMLReader.readXMLFile(settingsXMLFile,settingsSeparator);
		// Get dimensions of settngsArray
		int r = settingsArray.length;
		int c = settingsArray[0].length;
		logger.debug("Dimensions of returned settingsArray is : # Rows : " + r + " # cols : " + c );
		for (int i=0; i<r; i++) {
			logger.debug("New set of settings. Set # : " + i);
			for (int j=0; j<c; j++) {
				logger.trace("settings string returned from XMLReader.class is : " + settingsArray[i][j]);
			}
		}
		//-------------------------------------------------
		// Set properties of the driver object
		//-------------------------------------------------
		// Create a new driver object
		driverObj = new VerificationDriver();
		// Set the DB connection
		driverObj.setDbConnection(dbConnection);
		logger.debug("Set the database connection in driverObj to " + dbConnection);
		// Set Verification System homeDir in the driver object
		// In VerificationDriver.class, when runDriver() is executed
		// it will set this 'homeDir' value in the settings object.
		// This is the root path of the software.
		driverObj.setHomeDir(homeDir);

		// Loop over all runs
		for (String[] settings : settingsArray) {
			logger.info("Settings Array : " + Arrays.toString(settings));




			try {
				driverObj.runDriver(settings,webFlag);
			} catch (Exception e) {
				logger.fatal("Can not run the driver for settings: " + Arrays.toString(settings));
				Log.fatal("Can not run the driver","#errorPanelText");
				System.exit(0);
			}
			// Get necessary objects from the driver object
				// Get the settings object
				settingsObj = driverObj.getSettingsObj();
				// Get the data object
				resultsObj = driverObj.getResultsObj();
				if (resultsObj == null) {
					logger.fatal("resultsObj is null");
					System.exit(0);
				}
				else {
					logger.trace("dataobj not null");
				}
			// Get the output type
			outputType = driverObj.getSettingsObj().getOutputType();
			// If this is an ASCII file run...

			if (outputType.equals("ascii")) {
				// To Do : Make file name an option
				// Try to get the Ascii file name
				try {
					fileName = FormatLibrary.getAsciiFileName(driverObj.getSettingsObj(),driverObj.getResultsObj());
				} catch (Exception e) {
					logger.fatal("Could not get the ascii file name or write to the file");
					Log.fatal("Could not get the ascii file name or write to the file","#errorPanelText");
					throw e;
				}
				// Write data to Ascii text file
				try {
					WriteLibrary.writeToAscii(resultsObj,settingsObj,fileName);
				} catch (Exception e) {
					logger.fatal("Could not write data to ASCII file");
					Log.fatal("Could not write data to ASCII file","#errorPanelText");
					throw e;
				}
			}
			// If this is a CHART (timeseries or reliability diagram) run...
			else if (outputType.equals("chart")) {
				try {
				    // Create a PlotChart object
				    chart = new PlotChart();
				    chart.setSettingsObj(settingsObj);
				    chart.setResultsObj(resultsObj);
				    // Set the Applet size so JClass can set a size for the image
				    chart.setChartSize(660,500);
				} catch (Exception e) {
					logger.fatal("Could not create plotchart and/or set chart objects properly: " + e);
					System.exit(0);
				}
			    // Get the XML string of stats formatted for display from the driver
			    String xmlString = driverObj.getXMLString();
				// Create the chart and also saves as file
				try {
					chart.makeStaticChart(xmlString);
				} catch (Exception e) {
					logger.fatal("Could not make a JClass chart: " + e);
					System.exit(0);
				}
				logger.debug("Created chart with xmlString of data");
			}
			else {
				logger.fatal("Could not make output because invalid output type : " + outputType);
			}
		logger.debug("Ran obj for " + driverObj.getClass());
		}

		// Close connection
		logger.info("Attempting to close the database connection...\n");
		try {
			// Close and null the connection
			dbConnection.close();
			dbConnection = null;
		} catch (SQLException e) {
			// handle any errors
			logger.error("SQLException: " + e.getMessage());
			logger.error("SQLState: " + e.getSQLState());
			logger.error("VendorError: " + e.getErrorCode());
		}
		logger.info("Successfully closed the database connection");
	} // End constructor

/**
Accepts command line arguments and initializes a PlotChart chart object. Accepts a
flag and path and name of an XML formatted file that lists the settings.
<p>To run the static driver from the command line :
<p> > java gov/noaa/ncep/cpc/driver/StaticRunDriver -f /path/to/settingsXML/file.xml -l /path/to/loggerConfigFile.txt
<p> where -f is the flag notifying the program that a file following the flag
is specified, and /path/to/settingsXML/file.xml is the full path and file name of
the settings XML file,
and -l is the flag notifying the program that a file following the flag is specified for
the logger configuration file for log4j Apache software.
<p>
@see Image
*/
	public static void main(String[] args) {
//		try {
//			Thread.sleep(10000);
//		} catch(Exception e) {
//		}
		//-------------------------------------------------
		// Check for the VERIF_HOME environment variable
		//-------------------------------------------------
		// Get the environment variable hash array.
		Map<String, String> env = System.getenv();
		// See if VERIF_HOME is set
		if (!env.containsKey("VERIF_HOME")) {
			String error = " [error] VERIF_HOME environment variable not found.\n" +
			"Please set this variable to the root of the Verification System installation.";
			logger.fatal(error);
			System.exit(0);
		} else {
			homeDir = env.get("VERIF_HOME");
		}
		// See if VERIF_HOME is an existing path
		if (Requirements.pathExists(homeDir) == false) {
			logger.debug("Home dir is " + homeDir);
			logger.fatal("$VERIF_HOME directory " + homeDir + " does not exist!");
			System.exit(0);
		}

		//-------------------------------------------------
		// Set up command line arg processing
		//-------------------------------------------------
		// Initialize variables
		CommandLine cmd = null;
		// Create an Options object
		org.apache.commons.cli.Options options = new org.apache.commons.cli.Options();
		// Add all possible command-line options
		options.addOption( OptionBuilder.withLongOpt("settingsXMLfile")
										.withDescription("File containing runtime settings")
										.isRequired()
										.hasArg()
										.create("f") );
		options.addOption( OptionBuilder.withLongOpt("logConfigFile")
										.withDescription("File containing logging configuration")
										.isRequired()
										.hasArg()
										.create("l") );
		// Create a CommandLineParser object
		CommandLineParser parser = new PosixParser();
		try {
			cmd = parser.parse(options, args);
		} catch(ParseException e) {
			// Automatically generate a help message
			HelpFormatter formatter = new HelpFormatter();
			formatter.printHelp("java StaticRunDriver [OPTIONS]",options);
			System.exit(0);
		}


		//-------------------------------------------------
		// Set up logging
		//-------------------------------------------------
		// Get the log config file
		logConfigFile = cmd.getOptionValue("l");
        System.out.println(" ----------------- " + logConfigFile);
		if (Requirements.pathExists(logConfigFile) == false) {
			logger.fatal("Log config file \"" + logConfigFile + "\" does not exist!");
			System.exit(0);
		}
		// Convert this to a URL
		URL url = null;
		try {
			url = (new File(logConfigFile)).toURL();
		} catch (Exception e) {
			logger.error("Error getting URL from provided log config file: " + e.getMessage());
		}
		// Initialize logger
		logger = Logger.getLogger(StaticRunDriver.class.getName());
		// Set the log file path
		System.setProperty("logDir", homeDir + "/logs");
		// Configure the logger
		PropertyConfigurator.configure(url);

		//-------------------------------------------------
		// Check for required paths under home directory
		//-------------------------------------------------
		if (Requirements.checkForRequiredPaths(homeDir) == false) {
			logger.fatal("Not all required paths were found, please check " + homeDir);
			System.exit(0);
		}
		// Get the settings file
		settingsXMLFile = cmd.getOptionValue("f");
		if (Requirements.pathExists(settingsXMLFile) == false) {
			logger.fatal("Settings XML file \"" + settingsXMLFile + "\" does not exist!");
			System.exit(0);
		}
		logger.info("Starting StaticRunDriver");
		logger.info("Use logger config file: " + logConfigFile);
		logger.info("Use settings XML file: " + settingsXMLFile);
		logger.debug("Create PlotChart object");
		logger.trace("Run static driver");
		try {
			StaticRunDriver p = new StaticRunDriver();
		}
		catch (Exception e) {
			logger.fatal("Main method in StaticRunDriver failed.");
			System.exit(0);
		}
		logger.info("Sucessfully completed running StaticRunDriver");
	} // End main() method
} // End JApplet
