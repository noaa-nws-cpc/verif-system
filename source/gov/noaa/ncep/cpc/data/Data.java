package gov.noaa.ncep.cpc.data;

//-------------------------------------------------------------------
// Import all packages needed
//-------------------------------------------------------------------
import gov.noaa.ncep.cpc.format.FormatLibrary;
import gov.noaa.ncep.cpc.qc.Log;
import gov.noaa.ncep.cpc.settings.Settings;
import gov.noaa.ncep.cpc.settings.SettingsHashLibrary;
import gov.noaa.ncep.cpc.stats.MathLibrary;
import gov.noaa.ncep.cpc.stats.Stats;
import gov.noaa.ncep.cpc.utils.Date;
import java.util.Calendar;

import java.sql.Connection;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;


/**
  Mini driver for the data package. Deals with all logic for loading
  and manipulating the data, in preparation for calculating the score.
 */
public class Data {
	//---------------------------------------------------------------
	// Initialize constants
	//---------------------------------------------------------------
	private static final int MAX_NUM_ROWS = 150000;		// Max num rows allowed in a fcst or obs ResultSet before halting VWT
														// This number is arbitrary. It correlates to just over a year for 1 single model
	//---------------------------------------------------------------
	// Initialize variables
	//---------------------------------------------------------------
	private float fcstCat[][][];    // Forecast category
	private float fcstProb[][][][]; // Forecast probability levels
	private float obsCat[][];       // Observed data
	private float percentDry[][];      // Observed climo data (percent dry aveWindows)
	private int   numFcstDates = 0; // Number of unique dates in the loaded forecast data
	private int numFcstLocations = 0; // Number of unique location IDs in the loaded forecast data
	private int numObsDates = 0; // Number of observation dates to verify over
	private int numObsLocations = 0;     // Number of locations to verify over
	private int numClimDates = 0; // Number of climatology dates to verify over
	private int numClimLocations = 0;     // Number of locations to verify over
	private String[] formattedRefDatesArray = null; // String array of formatted reference (dates valid) dates, available to entire class to allow this to be set and accessed by a get method.
	private String[] formattedIssuedDatesArray = null; // String array of formatted fcst issued dates, available to entire class to allow this to be set and accessed by a get method.
	private int numWeekdays;        // Number of weekdays in the reference dates (for number of expected ERF forecasts)
	private String[] locationIdArray = null; // String array of the IDs of locations
	private String[] locationNameArray = null;   // String array of the names of locations verified
	private String[] locationLonLatArray = null; // String array of the lon,lat position of locations verified
	private String[] locationLatArray = null; // String array of the lat position of locations verified
	private String[] locationLonArray = null; // String array of the lon position of locations verified
	private String[] referenceArray = null; // String array of reference data, depends on output dimension
	private String firstFcstValidDate = null; // First available date of loaded fcst data in terms of date valid
	private String lastFcstValidDate = null; // Last available date of loaded fcst data in terms of date valid
	private ResultSet obsResultSet = null; // Observation ResultSet
	private ResultSet fcstResultSet = null; // Observation ResultSet
	private ResultSet climResultSet = null; // Observation ResultSet
	private String locationListCol = null;
	String sdfSourceFormat = null; // String of how date issued values are formatted in the database
	// Initialize empty database connection
	Connection dbConnection = null; // MySQL connection
	// Set up logger
	static Logger logger = Logger.getLogger(gov.noaa.ncep.cpc.data.Data.class);

	/**
	  Sole constructor. Nothing needs to be passed to the constructor
	  because the settings are all retrieved using get methods from
	  the {@link Settings Settings class}.
	 */
	public Data() {

	}

	/**
	  Uses logic to determine what data needs to be loaded. This is a generic
	  loading method that calls other necessary methods to load data. Note that forecast data is loaded prior to observation data in this method because the bounding dates (first and last available forecast dates) are used to bound
	  the observation data loaded. This prevents incorrectly paired data from being
	  loaded and processed.
	  See the individual loadFcst(), loadObs(), and loadClim() API documentation for details.
	  <br> The following methods (in this class) and functions are called in this loadData() method:
	  <br>1) loadFcstData() - loads the forecast data.
	  <br>2) loadObsData() - loads the observation data.
	  <br>3) loadClimData() - loads the climatology data, if applicable.
	  <br>4) Based on the output dimension type, reference information is loaded into the reference array, which can be accessed by method in this class getReferenceArray(). If dates are the reference array
	  (output dimension is time), for lead time "m", the format is MM/YYYY. For all other lead times, the format is MM/dd/YYYY. A reference array of unique dates are always available if loadData() is succesfully
	  processed. This can be accessed by get method getFormattedReferenceDatesArray().
	  <br>
	  @param settingsObj  Settings object from which to retrieve the settings
	 */
	public void loadData(Settings settingsObj) throws Exception {
		// Get some variables from the Settings object
		String regionType  = settingsObj.getRegionType();
		String regions     = settingsObj.getRegions();
		String spatialType = settingsObj.getSpatialType();
		String datesValid = settingsObj.getDatesValid();
		String outputDimension = settingsObj.getOutputDimension();
		boolean dryLocationCorrection = settingsObj.getDryLocationCorrection();
		String[] refDatesArray = null;
		String[] issuedDatesArray = null;
		SimpleDateFormat sdfSource;

		// TRY TO LOAD DATA
		// Note if you need other data besides fcst and obs data, need to put an if statement here
		// to call another method to load this data.

		// Need to load fcst data first because it :
		// - Allocates array space to forecast and obs data arrays
		// Try to load forecast data
		try {
			logger.info("Loading forecast data...");
			loadFcstData(settingsObj);
		} catch (Exception e) {
			logger.fatal("Could not load forecast data for forecast sources: " + settingsObj.getFcstSources() + " : " + e.getMessage());
			throw e;
		}

		// This saves significant processing time by not calling database methods again
		// These reference dates are formatted as how they occur in the observation database
		refDatesArray = getFormattedReferenceDatesArray();
		logger.trace("Reference dates array (date valid based on loaded forecast data) is : " + Arrays.toString(refDatesArray));
		// Get issued dates of forecast in formatted format
		issuedDatesArray = getFormattedIssuedDatesArray();

		// In the case of the extended range forecast, get the number of weekdays in the retrieved dataset
		// This is so that a number can be retrieved for expected # forecasts, and extended range forecasts are only issued on the weekends
		if (settingsObj.getFcstType().equals("extendedRange")) {
			numWeekdays = gov.noaa.ncep.cpc.utils.Date.numWeekdays(issuedDatesArray);
		}
		// Try to load observation data
		// - loads the dateReferenceArray (needed for first and last dates in the array)
		// - and reference array if time the output dimension type
		try {
			logger.info("Loading observation data...");
			loadObsData(settingsObj);
		} catch (Exception e) {
			logger.fatal("Could not load observation data for forecast sources : " + settingsObj.getFcstSources() + " : " + e);
			throw e;
		}

		// Get a String array of the ID of the points of the locations being verified
		try {
			locationIdArray = Database.getIdArray(settingsObj, dbConnection);
		} catch (Exception e) {
			logger.fatal("Error getting the location ID array: " + e);
			throw e;
		}

		// Try to load climatology data if dryLocationCorrection is true (set by settings class and
		// depends on other settings).
		// - loads the dateReferenceArray (needed for first and last dates in the array)
		// - and reference array if time the output dimension type
		if (dryLocationCorrection) {
			try {
				logger.info("Loading climatology data...");
				loadClimData(settingsObj);
			} catch (Exception e) {
				logger.fatal("Could not load climatology data for forecast sources : " + settingsObj.getFcstSources() + " : " + e);
				throw e;
			}
		}

		////////////////////////////////////
		// REFERENCE ARRAY SETTING
		////////////////////////////////////
		// Depending on the dimension the output should be in, set the reference
		// array to a reference array. Also retrieve any other reference arrays that would need to be obtained
		if (outputDimension.compareToIgnoreCase("time") == 0) {
			// Get reference date array. This should be created by loadObs() if the outputDimension is set to time.
			// Convert format of dates into desired format
			referenceArray = refDatesArray;
		}
		else if (outputDimension.compareToIgnoreCase("space") == 0) {
			// Get a String array of the ID of the points of the locations being verified
			try {
				locationIdArray = Database.getIdArray(settingsObj, dbConnection);
			} catch (Exception e) {
				logger.fatal("Error getting the location ID array: " + e);
				throw e;
			}
			// Get a String array of the names of the locations being verified
			try {
				locationNameArray = Database.getLocationNameArray(settingsObj, dbConnection);
			} catch (Exception e) {
				logger.fatal("Error getting the location name array: " + e);
				throw e;
			}
			// Get a String array of the lon,lat points of the locations being verified
			try {
				locationLonLatArray = Database.getLocationLonLatArray(settingsObj, dbConnection);
			} catch (Exception e) {
				logger.fatal("Error getting the location lonlat array: " + e);
				throw e;
			}
			// Get a String array of the lat points of the locations being verified
			try {
				locationLatArray = Database.getLocationLatArray(settingsObj, dbConnection);
			} catch (Exception e) {
				logger.fatal("Error getting the location lat array: " + e);
				throw e;
			}
			// Get a String array of the lon points of the locations being verified
			try {
				locationLonArray = Database.getLocationLonArray(settingsObj, dbConnection);
			} catch (Exception e) {
				logger.fatal("Error getting the location lon array: " + e);
				throw e;
			}
			// Set reference array to location name. This would be used for ASCII writing
			// 			referenceArray = locationIdArray;
			referenceArray = locationNameArray;
		}
		else if (outputDimension.compareToIgnoreCase("probability") == 0) {
			if (settingsObj.getFcstType().equals("extendedRange")) {
				referenceArray = Stats.getProbabilityBinLabelsExtRange();
			}
			else if (settingsObj.getFcstType().equals("longRange")) {
				referenceArray = Stats.getProbabilityBinLabelsLongRange();
			}
		}
		else {
			logger.warn("There is no referenceArray specified for the outputDimension selected : " + outputDimension + " does not exist in Data.loadData().");
			Log.error("Report error of no reference array specified for the outputDimension selected : " + outputDimension,"#errorPanelText");
		}
		// END REFERENCE ARRAY SETTING


	} // End loadData()




	/**
	  Loads all the forecast data into the data object. This method is called by
	  {@link #loadData} when the forecast data is needed. This method needs to be
	  called prior to the loadObsData() method because the beginning and end dates
	  of the loaded forecast data are used to bound the loaded observation data to
	  ensure properly paired forecasts and observations.<br>
	  <b>The following steps are done in this method:</b><br>
	  1) Retrieve the date piece of the syntax.
	  For each forecast source:
	  2) Build sql query syntax. Various methods are called to build the final query including retrieving the date piece of the syntax. <br>
	  3) The query is executed and the results set is retrieved. The database is only queried once for forecast data. The result set is used to retrieve information rather than multiple database queries to make processing more efficient.<br>
	  4) The first and last values of the results are retrieved from the result set<br>
	  and set to be accessed by a get method getFcstDateValidBounds(). These dates are used later
	  by the loadObs() method to restrict the beginning and end of dates of loaded observations.
	  This ensures matched pairs of forecasts and observations.<br>
	  5) Retrieve the reference dates, which is an array of unique occurrences of dates
	  of the forecasts in terms of dates valid. These dates are then set to be
	  accsesed by a get method getFormattedReferenceDatesArray().<br>
	  6) Retrieve the number of unique forecast dates from the result set. This is used
	  along with the number of unique locations (step 4) to allocate array space for
	  the forecast and observation data.
	  If there are no forecast dates returned, process is killed.<br>
	  7) Retrieve the number of unique location IDs from the result set. This is used
	  along with the number of unique forecast dates (step 5) to allocate array space
	  for the forecast and observation data.
	  If there are no forecast locations returned, process is killed.<br>
	  8) Array space is allocated according to the number of forecast sources,
	  unique number of forecast dates, unique locations,and number of forecast categories
	  for the forecast probabilities, and forecast categories.<br>
	  9) Retrieve the forecast data from the result set and load into arrays accessible by get methods.<br>
	  10) Some rearranging of array dimensions are done for various types of loaded forecast data.<br>
	  @param settingsObj  Settings object defining all necessary variables
	 */
	public void loadFcstData(Settings settingsObj) throws Exception {
		//-----------------------------------------------------------
		// Get settings from the Settings object
		//-----------------------------------------------------------
		String variable             = settingsObj.getVariable();
		String[] fcstSourceArray    = settingsObj.getFcstSourceArray();
		String leadTime             = settingsObj.getLeadTime();
		String leadTimeNumberFormat = settingsObj.getLeadTimeNumberFormat();
		String aveWindow            = settingsObj.getAveWindow();
		String datesValidType       = settingsObj.getDatesValidType();
		String datesValid           = settingsObj.getDatesValid();
		String regionType           = settingsObj.getRegionType();
		String regions              = settingsObj.getRegions();
		String spatialType          = settingsObj.getSpatialType();
		String scoreType            = settingsObj.getScoreType();
		String outputDimension      = settingsObj.getOutputDimension();
		String fcstType             = settingsObj.getFcstType();
		String leadTimeUnit         = settingsObj.getLeadTimeUnit();
		boolean webFlag		    = settingsObj.getWebFlag();
		// Get the names of the databases
		String fcstDBName = settingsObj.getFcstDBName();
		String obsDBName  = settingsObj.getObsDBName();
		String climDBName = settingsObj.getClimDBName();
		String refDBName  = settingsObj.getRefDBName();
		String VWTDBName  = settingsObj.getVWTDBName();

		//-----------------------------------------------------------
		// Initialize variables
		//-----------------------------------------------------------
		String columns     = null;
		String dbJoinsCols = ""; // String of column labels to use in case a DB joins is used
		String dataTableName   = null;
		String refTableName = null;
		String dateFilter  = null;
		String baseSqlQuery = null;
		String sqlQuery    = null;
		String regionList  = null;
		String dateName    = null;
		String leadTimeValue = null;
		String sqlTimeUnit = null;
		int numFcstSources = fcstSourceArray.length;
		String[] colsArray = null;
		String[] firstLastArray = null;
		String[] firstLastArrayFirstFcst = null;
		String[] validDates = null; // This contains the actual date values from the DB without formatting
		String[] issuedDates = null;
		String refSignalTable = null;
		String signalType = null;
		String signalValue = null;
		String signalConditionStr = null;
		String whereClauseStr = null;
		String sdfSourceStr = getSdfSourceFormat();
		String monthYearSql = null;
		String fcstSource;
		int firstFcstNumLocations = 0; // Reference # locations from first fcst source to compare to subsequent ones
		int firstFcstNumDates = 0; // Reference # dates from first fcst source to compare to subsequent ones

		//-----------------------------------------------------------
		// Determine $columns
		//-----------------------------------------------------------
		if (scoreType.equals("heidke")) {
			columns = "prob_below, prob_normal, prob_above";
		} else if (scoreType.equals("rpss")) {
			columns = "prob_below, prob_normal, prob_above";
		} else if (scoreType.equals("brier")) {
			columns = "prob_below, prob_normal, prob_above";
		} else if (scoreType.equals("reliability")) {
			columns = "prob_below, prob_normal, prob_above";
		}

		//-----------------------------------------------------------
		// Determine $regionList
		//
		// Convert the regions to a comma-separated list of strings,
		// each surrounded by single quotes (eg. 'TX','LA','MS')
		//-----------------------------------------------------------
		regionList = Sql.regionsToRegex(regions, regionType);
		// If spatialType is 'climateDivision' and regionType is 'climateDivision',
		// then use the 'id' column from locationList. Otherwise use the regionType column itself.
		if (regionType.compareToIgnoreCase("climateDivision") == 0 && spatialType.compareToIgnoreCase("climateDivision") == 0)
		{
			locationListCol = "id";
		}
		else
		{
			locationListCol = regionType;
		}

		//-----------------------------------------------------------
		// Determine $dateName
		//-----------------------------------------------------------
		// Column name of date issued in database
		dateName = "date_issued";
		ResultSet rs = null;

		//-----------------------------------------------------------
		// Loop over all fcst sources
		//-----------------------------------------------------------
		for (int f=0; f<numFcstSources; f++) {
			fcstSource = fcstSourceArray[f];
			logger.trace("Fcst source " + (f+1) + ": " + fcstSource);
			//-----------------------------------------------------------
			// Determine $table
			//-----------------------------------------------------------
			// Data table name
			dataTableName = "`" + Sql.getDataTableName(variable, fcstSource, leadTime, aveWindow, spatialType) + "`";
			// Reference table name
			refTableName = Sql.getRefTableName(spatialType);

			//-----------------------------------------------------------
			// Determine $dateFilter
			//-----------------------------------------------------------
			// If the datesValidType is 'selectSeasonalSignal' set this to empty
			if ((datesValidType.compareToIgnoreCase("selectSeasonalSignal") == 0) || (datesValidType.compareToIgnoreCase("selectMonthlySignal") == 0)) {
				dateFilter = "";
			}
			// Else retrive the date filter syntax
			else {
				dateFilter = Sql.getFcstDateFilter(datesValidType,datesValid,leadTimeNumberFormat,dateName);
				logger.debug("Date filter syntax is  :: " + dateFilter + " for lead time " + leadTime);
			}
			// Get 0-padded lead time numeric value
			leadTimeValue = leadTimeNumberFormat.substring(0,leadTimeNumberFormat.length()-1);
			// Get sql syntax term for unit of lead time ie. "MONTH" or "DAY"
			sqlTimeUnit = SettingsHashLibrary.getSqlTimeUnit(leadTimeNumberFormat.substring(leadTimeNumberFormat.length()-1));
			// Add a few extra columns
			columns = "data.id, data." + dateName + ", DATE_ADD(" + dateName + ", INTERVAL " + leadTimeValue + " " + sqlTimeUnit + ") AS fcstDateValid, " + columns;

			//-----------------------------------------------------------
			// Build the INNER JOIN part of the query
			//
			// We'll always at least JOIN the reference location list with the forecast table
			String innerJoinStr = fcstDBName + "." + dataTableName + " AS data INNER JOIN " + refDBName + "." + refTableName + " AS locationList";
			// If datesValidType = "selectSeasonalSignal" then add the climate phenomena table to the INNER JOIN
			if (datesValidType.compareToIgnoreCase("selectSeasonalSignal") == 0) {
				// Get the name of the climate phenomena table
				refSignalTable = SettingsHashLibrary.getSignalTableName("selectSeasonalSignal");
				// Add to the INNER JOIN
				innerJoinStr = innerJoinStr + " INNER JOIN " + refDBName + "." + refSignalTable + " AS signal";
			}
			// If datesValidType = "selectMonthlySignal" then add the climate phenomena table to the INNER JOIN
			if (datesValidType.compareToIgnoreCase("selectMonthlySignal") == 0) {
				// Get the name of the climate phenomena table
				refSignalTable = SettingsHashLibrary.getSignalTableName("selectMonthlySignal");
				// Add to the INNER JOIN
				innerJoinStr = innerJoinStr + " INNER JOIN " + refDBName + "." + refSignalTable + " AS signal";
			}

			//-----------------------------------------------------------
			// Build the JOIN condition ("ON") of the query
			//
			// We'll always at least have the condition matching the IDs
			// of the location list and the forecast table
			String innerJoinConditionStr = "data.id=locationList.id";
			// If datesValidType = "selectSeasonalSignal" then add the condition
			// where the date_valid of the climate phenomena must match the date_valid
			// of the forecast
			if ((datesValidType.compareToIgnoreCase("selectSeasonalSignal") == 0) || (datesValidType.compareToIgnoreCase("selectMonthlySignal") == 0)) {
				innerJoinConditionStr = innerJoinConditionStr + " AND DATE_ADD(" + dateName + ", INTERVAL " + leadTimeValue + " " + sqlTimeUnit + ")=signal.date_valid";
			}

			//-----------------------------------------------------------
			// Build the WHERE clause
			//

			// If datesValidType = "selectSeasonalSignal", then build appropriate WHERE clause
			if (datesValidType.compareToIgnoreCase("selectSeasonalSignal") == 0) {
				// Get parsed signal type and signal value from the datesValid
				String[] signalInfo = FormatLibrary.toStringArray(datesValid,";");
				signalType = signalInfo[0]; // Get signal type
				signalValue = signalInfo[1]; // Get signal value
			        // If signal is either positive or negative then assign query string
				// ToDo: Can make variable seasonal signal thresholds, and make 3 cats instead of 2
			        // If 'positive'
			        if (signalValue.compareToIgnoreCase("positive") == 0) {
			               signalConditionStr = signalType + " >=0";
				}
				// If signal is 'negative'
			        else if (signalValue.compareToIgnoreCase("negative") == 0) {
			               signalConditionStr = signalType + " <0";
				}
				// else set signal equal to value of var (no additional syntax needed)
				else {
					signalConditionStr = signalType + "='" + signalValue;
				}
				whereClauseStr = signalConditionStr + "' AND locationList." + locationListCol + " RLIKE '(" + regionList + ")'";
			} // End if selectSeasonalSignal
			// If datesValidType = "selectSeasonalSignal", then build appropriate WHERE clause
			else if (datesValidType.compareToIgnoreCase("selectMonthlySignal") == 0) {
				// Get parsed signal type and signal value from the datesValid
				String[] signalInfo = FormatLibrary.toStringArray(datesValid,";");
				signalType = signalInfo[0]; // Get signal type
				signalValue = signalInfo[1]; // Get signal value
			        // If signal is either positive or negative then assign query string
			        // If 'positive'
			        if (signalValue.compareToIgnoreCase("positive") == 0) {
			               signalConditionStr = signalType + " >=0";
				}
				// If signal is 'negative'
			        else if (signalValue.compareToIgnoreCase("negative") == 0) {
			               signalConditionStr = signalType + " <0";
				}
				// else set signal equal to value of var (no additional syntax needed)
				else {
					signalConditionStr = signalType + "='" + signalValue;
				}
				whereClauseStr = signalConditionStr + " AND locationList." + locationListCol + " RLIKE '(" + regionList + ")'";
				logger.debug("signalConditionStr is " + signalConditionStr + " whereClauseStr is " + whereClauseStr + " datesValidType is " + datesValidType);
			} // End if selectSeasonalSignal
			// If datesValidType is not "selectSeasonalSignal", then we just
			// need the WHERE clause to include the date and id filters
			else {
				whereClauseStr = dateFilter + " AND locationList." + locationListCol + " RLIKE '(" + regionList + ")'";
			}

			//-----------------------------------------------------------
			// Build the ORDER BY organization clauses
			//
			// By default, ORDER BY date, id
			String organizationClauseStr = "ORDER BY data." + dateName + ", data.id";

			//-----------------------------------------------------------
			// Create SQL query
			//
			// Build base Sql query using user selections
			sqlQuery = "SELECT " + columns + " FROM " + innerJoinStr + " ON " + innerJoinConditionStr + " WHERE " + whereClauseStr + " " + organizationClauseStr;
			logger.debug("Forecast sqlQuery : " + sqlQuery);

			// Get the result set object to use for the rest of the data information needed
			fcstResultSet = Database.getResultSet(sqlQuery,dbConnection);
			logger.debug("Retrieved results");

			//-----------------------------------------------------------------
			// Get the number of rows and halt the VWT if there are too many 
			// ONLY IF IT IS INITIATED BY WEB SERVICES.
			// This is because too many rows will make the applet run out of
			// memory on the client or time out.
			//
			int numRows = Database.getNumRSRows(fcstResultSet);
			logger.trace("webflag is : " + webFlag);
			if (webFlag == true) {
				logger.trace("Web flag is : " + webFlag + ", so will check to see if the number of rows of data exceeds allowable (" + numRows + ")");
				if (numRows > MAX_NUM_ROWS) {
					logger.fatal("The forecast ResultSet contains "+numRows+" rows, which is greater than the maximum allowed number of rows ("+MAX_NUM_ROWS+")");
					throw new Exception("The current selection contains too much data to verify. Please limit the number of dates or locations selected.");
				}
				else {
					logger.info("Number of rows of data are allowed. Continue processing...");
				}
			}
			// If it is the first fcst source in the loop, save first and last dates to an array
			if (f==0) {
				// Get first and last dates from the first forecast dataset
				// These values will be used to compare to results from the next loop run
				// (If more than one fcst source chosen)
				try {
					firstLastArrayFirstFcst = Database.getFirstAndLastResults("fcstDateValid",fcstResultSet,fcstSource);
				} catch (Exception e) {
					logger.fatal("Exception: "+e.getMessage());
					throw e;
				}
				logger.debug("First and last forecast valid dates are :  " + firstLastArrayFirstFcst[0] + " , " + firstLastArrayFirstFcst[1]);
				// Set fcst date bounds (in dates valid) so that the observations data
				// is bounded by these dates. It is set to the first forecast source by default.
				// If any of the subsequent forecast sources in loop do not match these, process killed.
				setFcstDateValidBounds(firstLastArrayFirstFcst[0],firstLastArrayFirstFcst[1]);
				logger.debug("For forecast source : " + fcstSource + " first valid date of fcst is : " + firstLastArrayFirstFcst[0] + " last valid date of fcst is : " + firstLastArrayFirstFcst[1]);
			}
			// If it is not the first forecast source, get the first and last available dates for that
			// forecast source. If it is different than the first source, kill process, log fatal problem
			else {
				// Array that contains results from the current forecast source loop
				try {
					firstLastArray = Database.getFirstAndLastResults("fcstDateValid",fcstResultSet,fcstSource);
				} catch (Exception e) {
					logger.fatal("Exception: "+e.getMessage());
					throw e;
				}
				logger.debug("Comparing forecast source bounding dates of : " + fcstSource + " - " +  firstLastArray[0] + " , "
						+ firstLastArray[1] + " to first forecast source bounding dates " + firstLastArrayFirstFcst[0]
						+ " , " + firstLastArrayFirstFcst[1]);
				// Check to see if the first value date of this fcst source matches the first date of the first fcst source. If not, kill process and throw error
				if (firstLastArray[0].compareToIgnoreCase(firstLastArrayFirstFcst[0]) != 0) {
					logger.fatal("First available date of forecast source " + fcstSource + " does NOT match the first selected forecast source. Process killed.");
					Log.fatal("Non-matching beginning dates for selected forecast sources","#errorPanelText");
					throw new Exception("The selected forecast models do not all have the same start date, please report this error");
				}
				// Check to see if the last value date of this fcst source matches the last date of the first fcst source. If not kill process and throw error.
				if (firstLastArray[1].compareToIgnoreCase(firstLastArrayFirstFcst[1]) != 0) {
					logger.fatal("Last available date of forecast source " + fcstSource + " does NOT match the first selected forecast source. Process killed.");
					Log.fatal("Non-matching ending dates for selected forecast sources","#errorPanelText");
					throw new Exception("The selected forecast models do not all have the same end date, please report this error");
				}
			}

			// Get the reference dates using dates valid based on date issued, these are unique values without duplicates
			validDates = Database.getUniqueRSResults("fcstDateValid",fcstResultSet);
			// Set formatted reference dates array. Then after this is done,
			// the getFormattedReferenceDatesArray method can be called
			setFormattedReferenceDatesArray(validDates,sdfSourceStr,leadTimeUnit);
			// Get the issued dates of the forecast, these are unique values without duplicates
			issuedDates = Database.getUniqueRSResults("date_issued",fcstResultSet);
			// Set formatted forecast issued dates array. Then after this is done,
			// the getFormattedIssuedDatesArray method can be called
			setFormattedIssuedDatesArray(issuedDates,sdfSourceStr,leadTimeUnit);
			logger.trace("Dates issued : " + Arrays.toString(issuedDates));
			logger.trace("Dates valid : " + Arrays.toString(validDates));
			//////////////////////////////
			// Get dimensions of space and time to allocate array space for forecast and obs data arrays
			// numFcstDates also used by other classes
			//////////////////////////////
			// Use the sqlQuery to get the number of unique occurences of dates (date_issued)
			// Getting these # dates and # locations
			try {
				numFcstDates = Database.getUniqueRSCount(dateName,fcstResultSet);
			} catch(Exception e) {
				logger.fatal("Couldn't get the number of issued dates");
				throw e;
			}
			// Throw an exception if no forecasts were found
			if (numFcstDates < 1) {
				logger.fatal("No forecast dates were found in the loaded dataset.");
				Log.fatal("No forecast dates were found in the loaded dataset.","#errorPanelText");
				throw new Exception();
			}
			// Get number of locations (id is column name in database) needed for dimension for fcst array later on
			logger.trace("Getting the unique id from forecasts");
			try {
				numFcstLocations = Database.getUniqueRSCount("id",fcstResultSet);
			} catch (Exception e) {
				logger.fatal("Cannot get the number of locations");
				throw new Exception("Cannot get the number of locations -> " + e);
			}
			logger.debug("Unique # locations are : " + numFcstLocations);
			// Throw an exception if no locations were found
			if (numFcstLocations < 1) {
				logger.fatal("No forecast locations were found in the loaded dataset.");
				Log.fatal("No forecast locations were found in the loaded dataset.","#errorPanelText");
				throw new Exception();
			}

			//-----------------------------------------------------------
			// If this is the first forecast source, allocate array space for forecast and obs
			// This allocates space for all fcst sources. This is done to have proper
			// array allocation.
			//-----------------------------------------------------------
			if (f == 0) {
				// Set reference values to compare subsequent forecast sources to for # dates and locations
				firstFcstNumLocations = numFcstLocations;
				firstFcstNumDates = numFcstDates;
				// allocate space
				// Note that other classes downstream may rearrange these dims
				fcstProb = new float[fcstSourceArray.length][numFcstDates][numFcstLocations][3];
				fcstCat  = new float[fcstSourceArray.length][numFcstDates][numFcstLocations];
			}
			// If not the first, then compare the # locations and # forecast dates from forecast source (f) to the reference values from the first forecast source
			// Process should die if either of these are not the same. It was the job of the upstream data import process to fill in values with null
			// so that all forecast sources have the same dimensions
			else {
				if (numFcstDates != firstFcstNumDates) {
					logger.fatal("Forecast sources do not all have the same number of dates." + fcstSourceArray[f] + " has " + numFcstDates + " forecast dates but " + fcstSourceArray[0] + " has " + firstFcstNumDates);
					Log.fatal("Mismatched number of dates amongst forecast sources.","#errorPanelText");
					throw new Exception("Forecast sources do not all have the same number of dates.");
				}
				if (numFcstLocations != firstFcstNumLocations) {
					logger.fatal("Forecast sources do not all have the same number of locations." + fcstSourceArray[f] + " has " + numFcstLocations + " forecast dates but " + fcstSourceArray[0] + " has " + firstFcstNumLocations);
					Log.fatal("Mismatched number of locations amongst forecast sources.","#errorPanelText");
					throw new Exception("Forecast sources do not all have the same number of locations.");
				}
			}

			logger.trace("Number of unique fcst dates for the FIRST forecast source " + fcstSourceArray[0] + " : " + firstFcstNumDates);
			logger.trace("Number of unique fcst locations for the FIRST forecast source " + fcstSourceArray[0] + " : " + firstFcstNumLocations);

			logger.trace("Number of unique fcst dates for forecast source " + fcstSourceArray[f] + " : " + numFcstDates);
			logger.trace("Number of unique locations for forecast source " +  fcstSourceArray[f] + " : " + numFcstLocations);

			logger.debug("Retrieving the forecast probs from the database.");
			// Retrieve data
			fcstProb[f] = Database.retrieveFcstProbs(numFcstDates, numFcstLocations, fcstResultSet);
			logger.debug("Forecast probs for fcst source # " + f + " are : " + fcstProb[f][0][0][0]);
			// Calculate forecast category using Scott's method
			logger.debug("Calculating category from probabilities...");
			for (int d=0; d<numFcstDates; d++) {
				for (int l=0; l<numFcstLocations; l++) {
					fcstCat[f][d][l] = getFcstCategoryArray(fcstProb[f][d][l],fcstSource,fcstType,variable);
				}
			}
			logger.debug("///////////////////////////////////////////");

		} // End loop over all forecast sources
		///////////////////////////////////////////////////////////////////////
		// Make sure at least one forecast value was found, otherwise none of
		// the models have data during the given date range
		//
		if (!checkForAtLeastOneFcstVal()) {
			logger.fatal("No forecasts were found during the selected period (some models are fairly recent). Most likely the selected period is not recent enough. Please select a different period.");
			throw new Exception("No forecasts were found during the selected period (some models are fairly recent). Most likely the selected period is not recent enough. Please select a different period.");
		}
	} // End loadFcstData()

	/**
	  Returns float values representing forecast categories based on the given probibilities.
	  <br>Returns the following float array values that represent the following categories:
	  <ul>
	  <li>1 - Below average category
	  <li>2 - Normal category
	  <li>3 - Above average category
	  <li>0 - Equal chances category (typically only for long range forecasts)
	  </ul>
	  <br>
	  The current methods for doing so include:
	  <ul>
	  <li>
	  simply picking the category with the highest probability
	  </li>
	  <li>
	  picking the higher of the two extreme categories (when at
	  least one of them are higher than 1/3), or the normal category
	  </li>
	  </ul>
	  @param fcstProb Array of float values of probabilities used for calculating the forecast category
	  @param fcstSource A forecast source to return the categories for
	  @param fcstType Type of forecast (extendedRange or longRange)
	  @return Float array of values representing forecast categories based on passed probabilities.
	 */
	public float getFcstCategoryArray(float[] fcstProb, String fcstSource, String fcstType, String variable) {
		Pattern pattern;
		Matcher matcher;
		float fcstCat = Float.NaN;
		// If the fcstProbs are NaN, then so is the category
		if (Float.isNaN(fcstProb[0]) || Float.isNaN(fcstProb[1]) || Float.isNaN(fcstProb[2])) {
			fcstCat = Float.NaN;
		} else {
			//---------------------------------------------------
			// Get the category with the highest probability
			//
			// Use the getMaxValueIndices() method, which returns
			// an array. There may be multiple maxes...
			if (fcstSource.compareToIgnoreCase("cdc_cdcgfs")==0 && fcstType.compareToIgnoreCase("extendedRange")==0) {
				int maxCategory[] = new int[3];
				maxCategory = MathLibrary.getMaxValueIndices(fcstProb);
				// Add 1 to every element of the returned array to convert
				// from array index (starts at 0) to CPC's forecast category
				// (starts at 1)
				for (int i=0; i<maxCategory.length; i++) {
					maxCategory[i]++;
				}
				//logger.trace("In getFcstCategoryArray - maxCategory: " + Arrays.toString(maxCategory));
				// If there's only 1 max, use it
				if (maxCategory.length == 1) {
					fcstCat = maxCategory[0];
					// If there are multiple maxes:
				} else {
					// If B and A tie, pick N
					if (MathLibrary.contains(maxCategory,1) && MathLibrary.contains(maxCategory,3)) {
						fcstCat = 2;
						// If B and N tie, pick B
					} else if (MathLibrary.contains(maxCategory,1) && MathLibrary.contains(maxCategory,2)) {
						fcstCat = 1;
						// If N and A tie, pick A
					} else if (MathLibrary.contains(maxCategory,2) && MathLibrary.contains(maxCategory,3)) {
						fcstCat = 3;
					}
				}
				// Use Scott's method, which always picks a below or above, unless
				// both are below 1/3.
			} else {
                // If one of the possible categories for extremes are being processed, then use different logic to select category        			        // Get the category label unit
                String possibleCategoryUnitsList = SettingsHashLibrary.getPossibleCategoryUnitsList();
                String regex = ".*(" + possibleCategoryUnitsList + ")-([0-9pt]+)-and-([0-9pt]+).*";
                logger.trace("regex is " + regex);
			    pattern = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
			    matcher = pattern.matcher(variable);
			    matcher.find();        
                if (matcher.matches() == true) {
                    logger.debug("Getting favored category based on an extreme for " + matcher.group(1));
                    // If both A and B are below 0.20 (the minimum forecast probability expected to consider as a usable probability), pick N
                   if (Float.compare(fcstProb[0],0.2f) < 0 && Float.compare(fcstProb[2],0.2f) < 0) {
					    fcstCat = 2;
				    }             
                    // If this is seasonal and A==B==N, pick EC (0)
                    else if (fcstType.compareToIgnoreCase("longRange")==0 && fcstProb[0]==fcstProb[1] && fcstProb[0]==fcstProb[2]) {
					    fcstCat = 0;
				    }
                    // Else pick the greater of A or B
                    else {
				        if (Float.compare(fcstProb[0],fcstProb[2]) > 0) {
					        fcstCat = 1;
				        } else {
					        fcstCat = 3;
				        }
				    }
                    logger.trace("Fcst prob for B: " + fcstProb[0] + " AL " + fcstProb[2]);
                    logger.trace("Favored category is (1=B,2=N,3=A,0=EC(long range only)" + fcstCat);
                }
				// Else, assume terciles are being processed. If both A and B are below 1/3, pick N
                else {
                    logger.debug("Getting favored category based on terciles.");
				    if (Float.compare(fcstProb[0],0.3333f) < 0 && Float.compare(fcstProb[2],0.3333f) < 0) {
					    fcstCat = 2;
				    }
                    // If this is seasonal and A==B==N, pick EC (0)
                    else if (fcstType.compareToIgnoreCase("longRange")==0 && fcstProb[0]==fcstProb[1] && fcstProb[0]==fcstProb[2]) {
					    fcstCat = 0;
				    }
			        // Otherwise pick the greater of A or B
                    else {
				        if (Float.compare(fcstProb[0],fcstProb[2]) > 0) {
					        fcstCat = 1;
				        } else {
					        fcstCat = 3;
				        }
				    }
                }
			}
		}
		//logger.trace("In getFcstCategoryArray - picked " + fcstCat);
		return fcstCat;
	}

	/**
	Returns the number of data points found in an array for each category (below normal, normal, above normal, equal chances[long range]),
	or (B,N,A, EC) which corresponds to categories with float values (in corresponding order) of (1.0,2.0,3.0,0.0). The output dimension
	determines what information is returned. This method is typically called to retrive the number of EC forecasts when the "noEC" option is used
	(not count any EC scores).
	@param dataArray3d 3-D Array of data in category format (B, N, A, EC) as (1.0,2.0,3.0,0.0) with dimensions depending on the output dimension:
	time: [# forecast sources][# dates][# locations]   , space : [model][location][time][category], probability : [model][time][location][probability].
	The Stats.java calcStats() method would typically perform any switching of dimensions prior to calling this method to put the passed data array
	into the appropriate dimension order.
	@param outputDimension This is the dimension that the output represents. For example, space, time, or probability.
	@return 3-D Array of number of data points in each category (B,N,A,EC) where the dimension is :
	For output dimension space or time: [# fcst sources][reference points][below, normal, above, equal chances]
	for output dimension probability: [# fcst sources][0][below, normal, above, equal chances]
	For probability (ie. reliability score), quality control on the forecast-observations data pairs are assessed over all dates and locations, so there is only
	one value that would be needed.
	The first dimension is for each forecast source,
	second dimension is the reference points is the dimension of the number of points in the reference dimension that varies based on the output dimension type:
	- space: # locations
	- time : # dates
	- probability : For reliability scores, one QC is done evaluating cross all locations and dates, so only one number needed evaluating entire dataset.
	and the third dimension is for each of the categories (size 4). Indices for the third dimension of category are
	as follows: (array index - category) : (below normal - 0)(normal - 1)(above normal - 2) (equal chances- 3).
	*/
	public float[][][] getNumDataByCategory(float[][][] dataArray3d, String outputDimension) throws Exception {
		logger.trace("Getting the number of data points by category value (getNumDataByCategory)");
		// Initialize the returned array for count
		// Size is # different categories B,N,A,EC
		logger.trace("# fcst sources in getNumDataByCategory is " + dataArray3d.length);

		float[][][] countDataArray;

		// Initialize counters
		float[] countCat = new float[4];
		Arrays.fill(countCat,0.0f);
		logger.trace("2nd dimension " + dataArray3d[0].length + " , 3rd dimension " + dataArray3d[0][0].length);
		// For output dimension space or time (2nd dimension is the reference dimension)
		if ((outputDimension.compareToIgnoreCase("space") == 0) ||  (outputDimension.compareToIgnoreCase("time") == 0)) {
			countDataArray = new float[dataArray3d.length][dataArray3d[0].length][4];
			// For each fcst source
			for (int i=0; i<dataArray3d.length; i++) {
				// Loop through reference points (dimension 2)
				for (int j=0; j<dataArray3d[0].length; j++) {
					logger.trace("---- New ref point : " + j + " --------");
					// Loop through points to sum up in opposite dimension (dimension 3)
					// Reset count of each to 0
					Arrays.fill(countCat,0.0f);
					for (int k=0; k<dataArray3d[0][0].length; k++) {
						//logger.trace("Value for point " + k + " is : " + dataArray3d[i][j][k]);
						// If below normal (1)
						if (dataArray3d[i][j][k] == 1.0f) {
							countCat[0] = countCat[0] + 1;
						}
						// If normal (2)
						else if (dataArray3d[i][j][k] == 2.0f) {
							countCat[1] = countCat[1] + 1;
						}
						// If above (3)
						else if (dataArray3d[i][j][k] == 3.0f) {
							countCat[2] = countCat[2] + 1;
						}
						// If EC (0)
						else if (dataArray3d[i][j][k] == 0.0f) {
							countCat[3] = countCat[3] + 1;
						}
						// If NaN, dont count anything
						else if (Float.isNaN(dataArray3d[i][j][k])) {
						}
						else {
							logger.fatal("Invalid category for a data value in forecast source indexed " + i + ". Must be a float value of 0.0, 1.0, 2.0, or 3.0. Value found is : " + dataArray3d[i][j][k]);
							Log.fatal("Invalid category data value found.","#errorPanelText");
							throw new Exception("Invalid category for a data value. Must be a float value of 0.0, 1.0, 2.0, or 3.0. Value found is : " + dataArray3d[i][j][k]);
						}
					} // End location loop
					countDataArray[i][j][0] = countCat[0];
					countDataArray[i][j][1] = countCat[1];
					countDataArray[i][j][2] = countCat[2];
					countDataArray[i][j][3] = countCat[3];
					logger.trace("Num expected data points by category: below : " + countDataArray[i][j][0] + " | normal : " +  countDataArray[i][j][1] + " | above : " +  countDataArray[i][j][2] + " | equal chances : " +  countDataArray[i][j][3]);

				} // End date loop
			} // End each fcst source loop
		} // End for output space and time
		// For output dimension probability evaluate categories over both date and time
		else if (outputDimension.compareToIgnoreCase("probability") == 0) {
			countDataArray = new float[dataArray3d.length][1][4]; // There is only one value for each category since the date and location dimension is combined

			// For each fcst source
			for (int i=0; i<dataArray3d.length; i++) {
				// Reset count of each to 0
				Arrays.fill(countCat,0.0f);
				// Loop through dates
				for (int j=0; j<dataArray3d[0].length; j++) {
					// Loop through locations
					for (int k=0; k<dataArray3d[0][0].length; k++) {
						logger.trace("Value is : " + dataArray3d[i][j][k] + " for j = " + j + " for k = " + k);
						// If below normal (1)
						if (dataArray3d[i][j][k] == 1.0f) {
							countCat[0] = countCat[0] + 1;
						}
						// If normal (2)
						else if (dataArray3d[i][j][k] == 2.0f) {
							countCat[1] = countCat[1] + 1;
						}
						// If above (3)
						else if (dataArray3d[i][j][k] == 3.0f) {
							countCat[2] = countCat[2] + 1;
						}
						// If EC (0)
						else if (dataArray3d[i][j][k] == 0.0f) {
							countCat[3] = countCat[3] + 1;
						}
						// If NaN, dont count anything
						else if (Float.isNaN(dataArray3d[i][j][k])) {
						}
						else {
							logger.fatal("Invalid category for a data value in forecast source indexed " + i + ". Must be a float value of 0.0, 1.0, 2.0, or 3.0. Value found is : " + dataArray3d[i][j][k]);
							Log.fatal("Invalid category data value found.","#errorPanelText");
							throw new Exception("Invalid category for a data value. Must be a float value of 0.0, 1.0, 2.0, or 3.0. Value found is : " + dataArray3d[i][j][k]);
						}
					} // End location loop
				} // End date loop
				countDataArray[i][0][0] = countCat[0];
				countDataArray[i][0][1] = countCat[1];
				countDataArray[i][0][2] = countCat[2];
				countDataArray[i][0][3] = countCat[3];
				logger.debug("Num expected data points by category: below : " + countDataArray[i][0][0] + " | normal : " +  countDataArray[i][0][1] + " | above : " +  countDataArray[i][0][2] + " | equal chances : " +  countDataArray[i][0][3]);
			} // End each fcst source loop

		} // End if probability
		else {
			logger.fatal("Invalid output dimension. Must be either time, space, or proability.");
			Log.fatal("Invalid output dimension for assessing categorical data.","#errorPanelText");
			throw new Exception("Invalid output dimension. Must be either time, space, or proability.");
		}
		return countDataArray;
	}

	/**
	  Loads all the observation data into the data object. This method is called by
	  {@link #loadData} when the observation data is needed. The loadFcstData()
	  must be called prior to this method because the beginning and end dates
	  are used to bound the retrieved observation data according to the forecast
	  data range. Also, checks are done with the forecast data to ensure
	  correctly paired forecasts and observations.
	  <b> The following steps are done in this method : </b>
	  1) Build sql query syntax. Various methods are called to build the final query. including retrieving the date piece of the syntax. <br>
	  2) The query is executed and the results set is retrieved. The database is only queried once for observation data. The result set is used to retrieve information rather than multiple database queries to make processing more efficient.<br>
	  3) Retrieve the number of unique observation dates from the result set.<br>
	  If there are no observation dates returned, process is killed.<br>
	  4) Retrieve the number of unique location IDs from the result set. <br>
	  If there are no observation locations returned, process is killed.<br>
	  5) If the number of observation dates or locations IDs do not match the
	  number of forecast dates or locations, the process is killed. <br>
	  6) Allocate array space for the observation data using the unique # of
	  dates and location IDs.<br>
	  7) Retrieve the observation data from the result set and load into arrays accessible by get methods.
	  @param settingsObj  Settings object defining all necessary variables
	 */
	public void loadObsData(Settings settingsObj) throws Exception {
		//-----------------------------------------------------------
		// Get settings from the Settings object
		//-----------------------------------------------------------
		String variable        = settingsObj.getVariable();
		String aveWindow       = settingsObj.getAveWindow();
		String datesValidType  = settingsObj.getDatesValidType();
		String datesValid      = settingsObj.getDatesValid();
		String regionType      = settingsObj.getRegionType();
		String regions         = settingsObj.getRegions();
		String spatialType     = settingsObj.getSpatialType();
		String scoreType       = settingsObj.getScoreType();
		String outputDimension = settingsObj.getOutputDimension();
		String leadTime        = settingsObj.getLeadTime();
		String leadTimeUnit    = settingsObj.getLeadTimeUnit();
		// Get the names of the databases
		String fcstDBName = settingsObj.getFcstDBName();
		String obsDBName  = settingsObj.getObsDBName();
		String climDBName = settingsObj.getClimDBName();
		String refDBName  = settingsObj.getRefDBName();
		String VWTDBName  = settingsObj.getVWTDBName();

		//-----------------------------------------------------------
		// Initialize variables
		//-----------------------------------------------------------
		String columns    = null;
		String dbJoinsCols = ""; // String of column labels to use in case a DB joins is used
		String dataTableName  = null;
		String refTableName = null;
		String dateFilter = null;
		String baseSqlQuery = null;
		String sqlQuery   = null;
		String regionList = null;
		String dateName   = null;
		String[] colsArray = null;
		String refSignalTable = null;
		String signalType = null;
		String signalValue = null;
		String signalConditionStr = null;
		String whereClauseStr = null;
		String[] obsDates = null; // This contains the actual date values from the DB without formatting

		//-----------------------------------------------------------
		// Determine $columns
		//-----------------------------------------------------------
		columns = "category";

		//-----------------------------------------------------------
		// Determine $table
		//-----------------------------------------------------------
		// Data table name
		dataTableName = "`" + Sql.getDataTableName(variable, aveWindow, spatialType) + "`";
		// Reference table name
		refTableName = Sql.getRefTableName(spatialType);
		//-----------------------------------------------------------
		// Determine $regionList
		//
		// Convert the regions to a comma-separated list of strings,
		// each surrounded by single quotes (eg. 'TX','LA','MS')
		//-----------------------------------------------------------
		regionList = Sql.regionsToRegex(regions, regionType);
		// If spatialType is 'climateDivision' and regionType is 'climateDivision',
		// then use the 'id' column from locationList. Otherwise use
		// the regionType column itself.
		if (regionType.compareToIgnoreCase("climateDivision") == 0 && spatialType.compareToIgnoreCase("climateDivision") == 0)
		{
			locationListCol = "id";
		}
		else
		{
			locationListCol = regionType;
		}


		//-----------------------------------------------------------
		// Determine $dateName
		//
		// Column name in database of the date valid
		dateName = "date_valid";

		//-----------------------------------------------------------
		// Determine $dateFilter
		//
		// If the datesValidType is 'selectSeasonalSignal' set this to empty
		if ((datesValidType.compareToIgnoreCase("selectSeasonalSignal") == 0) || (datesValidType.compareToIgnoreCase("selectMonthlySignal") == 0)) {
			dateFilter = "";
		}
		// Else retrive the date filter syntax
		else {
			dateFilter = Sql.getObsDateFilter(datesValidType,datesValid,dateName);
		}
		// Get the first and last valid forecast dates to bound observation data by,
		// in addition to the normal date filter
		String[] dateBounds = getFcstDateValidBounds();
		dateFilter = dateFilter + " AND data." + dateName + " BETWEEN '" + dateBounds[0] + "' AND '" + dateBounds[1] + "'";

		//-----------------------------------------------------------
		// Add a few extra columns
		//
		columns = "data.id, data." + dateName + ", data." + dateName + ", " + columns;

		//-----------------------------------------------------------
		// Build the INNER JOIN part of the query
		//
		// We'll always at least JOIN the reference location list with the data table
		String innerJoinStr = obsDBName + "." + dataTableName + " AS data INNER JOIN " + refDBName + "." + refTableName + " AS locationList";
		// If datesValidType = "selectSeasonalSignal" then add the climate phenomena table to the INNER JOIN
		if (datesValidType.compareToIgnoreCase("selectSeasonalSignal") == 0) {
			// Get the name of the climate phenomena table
			refSignalTable = SettingsHashLibrary.getSignalTableName("selectSeasonalSignal");
			// Add to the INNER JOIN
			innerJoinStr = innerJoinStr + " INNER JOIN " + refDBName + "." + refSignalTable + " AS signal";
		}
		// If datesValidType = "selectMonthlySignal" then add the climate phenomena
		// table to the INNER JOIN
   	 	if (datesValidType.compareToIgnoreCase("selectMonthlySignal") == 0) {
   			// Get the name of the climate phenomena table
   			refSignalTable = SettingsHashLibrary.getSignalTableName("selectMonthlySignal");
   			// Add to the INNER JOIN
   			innerJoinStr = innerJoinStr + " INNER JOIN " + refDBName + "." + refSignalTable + " AS signal";
   		}

		//-----------------------------------------------------------
		// Build the JOIN condition ("ON") of the query
		//
		// We'll always at least have the condition matching the IDs
		// of the location list and the data table
		String innerJoinConditionStr = "data.id=locationList.id";
		// If datesValidType = "selectSeasonalSignal" then add the condition
		// where the date_valid of the climate phenomena must match the date_valid
		// of the observation
		if ((datesValidType.compareToIgnoreCase("selectSeasonalSignal") == 0) || (datesValidType.compareToIgnoreCase("selectMonthlySignal")
		== 0)) {
			innerJoinConditionStr = innerJoinConditionStr + " AND data.date_valid=signal.date_valid";
		}

		//-----------------------------------------------------------
		// Build the WHERE clause
		//
		// If datesValidType = "selectSeasonalSignal", then build appropriate WHERE clause
		if (datesValidType.compareToIgnoreCase("selectSeasonalSignal") == 0) {
			// Get parsed signal type and signal value from the datesValid
			String[] signalInfo = FormatLibrary.toStringArray(datesValid,";");
			signalType = signalInfo[0]; // Get signal type
			signalValue = signalInfo[1]; // Get signal value
			// If signal is either positive or negative then assign query string
			// ToDo: Can make variable thresholds, and make 3 cats instead of 2
			// If 'positive'
			if (signalValue.compareToIgnoreCase("positive") == 0) {
				signalConditionStr = signalType + " >=0";
			}
			// If signal is 'negative'
			else if (signalValue.compareToIgnoreCase("negative") == 0) {
			        signalConditionStr = signalType + " <0";
			}
			// else set signal equal to value of var (no additional syntax needed)
			else {
				signalConditionStr = signalType + "='" + signalValue;
			}
			whereClauseStr = signalConditionStr + "' AND locationList." + locationListCol + " RLIKE '(" + regionList + ")'";
		} // End if selectSeasonalSignal
		// If datesValidType = "selectSeasonalSignal", then build appropriate WHERE clause
		else if (datesValidType.compareToIgnoreCase("selectMonthlySignal") == 0) {
			// Get parsed signal type and signal value from the datesValid
			String[] signalInfo = FormatLibrary.toStringArray(datesValid,";");
			signalType = signalInfo[0]; // Get signal type
			signalValue = signalInfo[1]; // Get signal value
			// If signal is either positive or negative then assign query string
			// If 'positive'
			if (signalValue.compareToIgnoreCase("positive") == 0) {
				signalConditionStr = signalType + " >=0";
			}
			// If signal is 'negative'
			else if (signalValue.compareToIgnoreCase("negative") == 0) {
				signalConditionStr = signalType + " <0";
			}
			// else set signal equal to value of var (no additional syntax needed)
			else {
				signalConditionStr = signalType + "='" + signalValue;
			}
			whereClauseStr = signalConditionStr + " AND locationList." + locationListCol + " RLIKE '(" + regionList + ")'";
		} // End if selectSeasonalSignal
		// If datesValidType is not "selectSeasonalSignal", then we just
		// need the WHERE clause to include the date and id filters
		else {
			whereClauseStr = dateFilter + " AND locationList." + locationListCol + " RLIKE '(" + regionList + ")'";
		}

		//-----------------------------------------------------------
		// Build the ORDER BY organization clauses
		//
		// By default, date and ORDER BY date, id
		String organizationClauseStr = "ORDER BY data." + dateName + ", data.id";

		//-----------------------------------------------------------
		// Create SQL query
		//
		// Build base Sql query using user selections
		sqlQuery = "SELECT " + columns + " FROM " + innerJoinStr + " ON " + innerJoinConditionStr + " WHERE " + whereClauseStr + " " + organizationClauseStr;

		logger.debug("Obs sqlQuery : " + sqlQuery);
		// Get the result set object to use for the rest of the data information needed
		obsResultSet = Database.getResultSet(sqlQuery,dbConnection);

		// Get the reference dates using dates valid based on date issued, these are unique values without duplicates
		// Do this mostly for printing values
		obsDates = Database.getUniqueRSResults("date_valid",obsResultSet);
		logger.trace("Obs dates valid : " + Arrays.toString(obsDates));

		// Get # unique dates valid from obs table
		try {
			numObsDates = Database.getUniqueRSCount(dateName,obsResultSet);
		} catch(Exception e) {
			logger.fatal("Couldn't get the number of unique observation dates");
			throw e;
		}
		// Throw an exception if no observations were found
		if (numObsDates < 1) {
			logger.fatal("No observation dates found in the loaded observation dataset.");
			Log.fatal("No observation dates found in the loaded observation dataset.","#errorPanelText");
			throw new Exception("No observation dates were found for the given criteria.");
		}
		logger.trace("Number of unique observation dates: " + numObsDates);
		logger.trace("Getting the unique location IDs from observations");
		try {
			numObsLocations = Database.getUniqueRSCount("id",obsResultSet);
		} catch (Exception e) {
			logger.fatal("Cannot get the number of locations for observations");
			throw new Exception("Cannot get the number of locations -> " + e);
		}
		logger.debug("Unique # obs locations are : " + numObsLocations);
		// Throw an exception if no locations were found
		if (numObsLocations < 1) {
			logger.fatal("No observation locations found in the loaded observation dataset.");
			Log.fatal("No observation locations found in the loaded observation dataset.","#errorPanelText");
			throw new Exception();
		}
		//////////////////////////////
		// Check to see if there are the same number of unique dates between forecasts and observations
		//////////////////////////////
		if (numObsDates != numFcstDates) {
			logger.fatal("The # of observation dates ("+ numObsDates + ") and # of forecast dates (" + numFcstDates + ") do NOT match.");
			Log.fatal("Report unevenly paired # of observation and forecast data values due to different # date points.","#errorPanelText");
			throw new Exception("The number of observed dates to not match the number of forecast dates.");
		}
		//////////////////////////////
		// Check to see if there are the same number of unique locations between forecasts and observations
		//////////////////////////////
		if (numObsLocations != numFcstLocations) {
			logger.fatal("The # of observation locations ("+ numObsLocations + ") and # of forecast locations (" + numFcstLocations + ") do NOT match.");
			Log.fatal("Report unevenly paired # of observation and forecast data values due to different # location points.","#errorPanelText");
			throw new Exception("The number of observed locations to not match the number of forecast locations.");
		}
		// If all checks and validation checking for matching pairs of fcst & obs data passes, try to retrieve/load the obs data
		// Allocate observation data array space
		obsCat = new float[numObsDates][numObsLocations];
		// Retrieve data
		try {
			logger.debug("Retrieving the observation categories from the database.");
			obsCat = Database.resultSetTo2DFloatArray(numObsDates, numObsLocations, "category", obsResultSet);
			logger.debug("Retrieving the observation data.");
		}
		catch (Exception e) {
			logger.fatal("Cannot load the observation data, problem retriving from the database.");
			throw e;
		}
		for (int d=0; d<obsCat.length; d++) {
			for (int l=0; l<obsCat[0].length; l++) {
				//logger.trace("obsCat[" + d + "][" + l + "] = " + obsCat[d][l]);
			}
		}
	} //  End loadObsData()

	/**
	  Loads all the climatology data into the data object. This method is called by
	  {@link #loadData} when the climatology data is needed. The loadFcstData()
	  must be called prior to this method because the beginning and end dates
	  are used to bound the retrieved climatology data according to the forecast
	  data range. Also, checks are done with the forecast data to ensure
	  correctly paired forecasts and climos.
	  <b> The following steps are done in this method : </b>
	  1) Build sql query syntax. Various methods are called to build the final query. including retrieving the date piece of the syntax. <br>
	  2) The query is executed and the results set is retrieved. The database is only queried once (TODO: if date range spans multiple climo periods this may not be correct. UPDATE!!) for climatology data. The result set is used to retrieve information rather than multiple database queries to make processing more efficient.<br>
	  3) Retrieve the number of unique climatology dates (corresponds to each observation) from the result set.<br>
	  If there are no climatology dates returned, process is killed.<br>
	  4) Retrieve the number of unique location IDs from the result set. <br>
	  If there are no climatology locations returned, process is killed.<br>
	  5) If the number of climatology dates or locations IDs do not match the
	  number of forecast dates or locations, the process is killed. <br>
	  6) Allocate array space for the climatology data using the unique # of
	  dates and location IDs.<br>
	  7) Retrieve the climatology data from the result set and load into arrays accessible by get methods.
	  @param settingsObj  Settings object defining all necessary variables
	 */
	public void loadClimData(Settings settingsObj) throws Exception {
		//-----------------------------------------------------------
		// Get settings from the Settings object
		//-----------------------------------------------------------
		String variable          = settingsObj.getVariable();
		String aveWindow         = settingsObj.getAveWindow();
		String datesValidType    = settingsObj.getDatesValidType();
		String datesValid        = settingsObj.getDatesValid();
		String regionType        = settingsObj.getRegionType();
		String regions           = settingsObj.getRegions();
		String spatialType       = settingsObj.getSpatialType();
		String scoreType         = settingsObj.getScoreType();
		String outputDimension   = settingsObj.getOutputDimension();
		String leadTime          = settingsObj.getLeadTime();
		String leadTimeUnit      = settingsObj.getLeadTimeUnit();
		// Get the names of the databases
		String fcstDBName = settingsObj.getFcstDBName();
		String obsDBName  = settingsObj.getObsDBName();
		String climDBName = settingsObj.getClimDBName();
		String refDBName  = settingsObj.getRefDBName();
		String VWTDBName  = settingsObj.getVWTDBName();

		//-----------------------------------------------------------
		// Initialize variables
		//-----------------------------------------------------------
		String columns    = null;
		String dbJoinsCols = ""; // String of column labels to use in case a DB joins is used
		String dataTableName  = null;
		String refTableName = null;
		String dateFilter = null;
		String baseSqlQuery = null;
		String sqlQuery   = null;
		String regionList = null;
		String dateName   = null;
		String[] colsArray;
		String refSignalTable = null;
		String signalType = null;
		String signalValue = null;
		String signalConditionStr = null;
		int numClimDates = 0; // Number of climatology dates to verify over
		int numClimLocations = 0;     // Number of locations to verify over
		//-----------------------------------------------------------
		// Determine $columns
		//-----------------------------------------------------------
		columns = "percentDry";

		//-----------------------------------------------------------
		// Determine the climatology period(s) spanned by the valid dates
		//
		// This is really a future feature. Currently Scott's verification
		// system uses the 1971-2000 dry location climo for all forecasts,
		// including those made after the switch to the 1981-2010 climos.
		// The first stage of adding dry location correction is to match
		// Scott's methods, so we don't need to care if the VWT selection
		// spans multiple climo periods. In the future, we will want to
		// add this feature though, so the partially completed method
		// gov.noaa.ncep.cpc.utils.Date.climPeriods() will be the future
		// method used to get the climo periods.
		//-----------------------------------------------------------
		// Get the first and last valid forecast dates to bound observation data by
		String[] dateBounds = getFcstDateValidBounds();
		//				// Get the climatology periods
		//				Date.climPeriods(dateBounds[0],dateBounds[1]);

		//-----------------------------------------------------------
		// Determine table
		//-----------------------------------------------------------
		// Data table name
		dataTableName = "`" + Sql.getDataTableName("percentDry", aveWindow, "1971-2000", spatialType) + "`";

		// Reference table name
		refTableName = Sql.getRefTableName(spatialType);
		//-----------------------------------------------------------
		// Determine $regionList
		//
		// Convert the regions to a comma-separated list of strings,
		// each surrounded by single quotes (eg. 'TX','LA','MS')
		//-----------------------------------------------------------
		regionList = Sql.regionsToRegex(regions, regionType);
		// If spatialType is 'climateDivision' and regionType is 'climateDivision',
		// then use the 'id' column from locationList. Otherwise use the regionType column itself.
		if (regionType.compareToIgnoreCase("climateDivision") == 0 && spatialType.compareToIgnoreCase("climateDivision") == 0)
		{
			locationListCol = "id";
		}
		else
		{
			locationListCol = regionType;
		}


		//-----------------------------------------------------------
		// Determine $dateName
		//-----------------------------------------------------------
		// Column name in database of the date valid
		dateName = "date_valid";

		//-----------------------------------------------------------
		// Determine $dateFilter
		//
		// Make a custom date filter for climo (include all 366 days of the year [2000 is used for climo])
		dateFilter = dateName + " BETWEEN '2000-01-01' AND '2000-12-31'";

		//-----------------------------------------------------------
		// Add a few extra columns
		//
		columns = "data.id, data." + dateName + ", " + columns;

		//-----------------------------------------------------------
		// Build the INNER JOIN part of the query
		//
		// We'll always at least JOIN the reference location list with the data table
		String innerJoinStr = climDBName + "." + dataTableName + " AS data INNER JOIN " + refDBName + "." + refTableName + " AS locationList";
		// If datesValidType = "selectSeasonalSignal" then add the climate phenomena table to the INNER JOIN
		if (datesValidType.compareToIgnoreCase("selectSeasonalSignal") == 0) {
			// Get the name of the climate phenomena table
			refSignalTable = SettingsHashLibrary.getSignalTableName("selectSeasonalSignal");
			// Add to the INNER JOIN
			innerJoinStr = innerJoinStr + " INNER JOIN " + refDBName + "." + refSignalTable + " AS signal";
		}
		// If datesValidType = "selectMonthlySignal" then add the climate phenomena
		// table to the INNER JOIN
   	 	if (datesValidType.compareToIgnoreCase("selectMonthlySignal") == 0) {
   			// Get the name of the climate phenomena table
   			refSignalTable = SettingsHashLibrary.getSignalTableName("selectMonthlySignal");
   			// Add to the INNER JOIN
   			innerJoinStr = innerJoinStr + " INNER JOIN " + refDBName + "." + refSignalTable + " AS signal";
   		}
		//-----------------------------------------------------------
		// Build the JOIN condition ("ON") of the query
		//
		// We'll always at least have the condition matching the IDs
		// of the location list and the data table
		String innerJoinConditionStr = "data.id=locationList.id";
		// If datesValidType = "selectSeasonalSignal" then add the condition
		// where the date_valid of the climate phenomena must match the date_valid
		// of the forecast
		if ((datesValidType.compareToIgnoreCase("selectSeasonalSignal") == 0)  || (datesValidType.compareToIgnoreCase("selectMonthlySignal")
		== 0)) {
			innerJoinConditionStr = innerJoinConditionStr + " AND data.date_valid=signal.date_valid";
		}

		//-----------------------------------------------------------
		// Build the WHERE clause
		//
		String whereClauseStr;
		// For the where clause want all data for climo because it will match to retrieved obs later on
		whereClauseStr = dateFilter + " AND locationList." + locationListCol + " RLIKE '(" + regionList + ")'";

		//-----------------------------------------------------------
		// Build the ORDER BY organization clauses
		//
		// By default, ORDER BY date, id
		String organizationClauseStr = "ORDER BY data." + dateName + ", data.id";

		//-----------------------------------------------------------
		// Create SQL query
		//
		// Build base Sql query using user selections
		sqlQuery = "SELECT " + columns + " FROM " + innerJoinStr + " ON " + innerJoinConditionStr + " WHERE " + whereClauseStr + " " + organizationClauseStr;

		//-----------------------------------------------------------
		// The above SQL query pulls the appropriate percentDry climos
		// from the database and places them into a 2-d hash array.
		// It's probably simplest to just grab the climos for every day
		// of the year. This array will then be reshaped to match the
		// lengths of the forecast and observation arrays below.
		//-----------------------------------------------------------

		logger.debug("Clim sqlQuery : " + sqlQuery);

		// Get the result set object to use for the rest of the data information needed
		climResultSet = Database.getResultSet(sqlQuery,dbConnection);

		// Ensure there are 366 x numLocations values, since we want all days of the year,
		// and for every location.
		numClimDates = Database.getUniqueRSCount(dateName, climResultSet);
		numClimLocations = Database.getUniqueRSCount("id", climResultSet);
		if (numClimDates != 366) {
			logger.fatal("The number of days retrieved from the climatology database (" + numClimDates + ") is not equal to 366 (all days including Feb. 29th), but it should be.");
			Log.fatal("There was a problem retrieving the climatology data from the database.","#errorPanelText");
			throw new Exception();
		}
		if (numClimLocations != numObsLocations) {
			logger.fatal("The number of locations retrieved from the climatology database (" + numClimLocations + ") is not equal to the number of locations containing a valid forecast/observation pair (" + numObsLocations + ")");
			Log.fatal("There was a problem retrieving the climatology data from the database.","#errorPanelText");
			throw new Exception();
		}

		// Convert the array of climatology data (366xnumLocations) to a new array with
		// dimensions matching the forecast and observation arrays. The current climatology
		// array has data for every day of the year, but we want an array that has all days
		// in the verification period, which can be a subset of days of the year, or even
		// span multiple years, so the current climatology array needs to be transformed.
		try {
			percentDry = createClimArray(obsResultSet, climResultSet, "percentDry");
		} catch (Exception e) {
			logger.fatal("Couldn't convert the dry-location ResultSet into an array.");
			throw e;
		}

		for (int d=0; d<percentDry.length; d++) {
			for (int l=0; l<percentDry[0].length; l++) {
				logger.trace("percentDry[" + d + "][" + l + "] = " + percentDry[d][l]);
			}
		}
	} //  End loadClimData()

	/**
	  Creates a climatology array using the given ResultSet. The start and end dates are to be provided as arguments, and
	  should match the start and end dates of the observation array. This method needs to be run after the loadObsData
	  and loadFcstData methods have run, since it needs the list of locations and the list of observed dates.

	  @param obsResultSet     ResultSet containing the observaitons
	  @param climResultSet    ResultSet containing the full year of climatological data for every location
	  @param columnName       Name of the column storing the climatological value

	  @return Array of climatology data with dimensions [numDates,numLocations]
	 */
	public float[][] createClimArray(ResultSet obsResultSet, ResultSet climResultSet, String columnName) throws Exception {
		//---------------------------------------------------------------------
		// Initialize variables
		//
		// The keys for this HashMap will be a combination of the date and the
		// location, separated by commas. For example, for a date of 2000-03-15
		// and a location of 77747, the key would be 2000-03-15,77747.
		HashMap<String, Float> climHash = new HashMap<String, Float>();
		// 2-d array that will be returned
		float climArray[][] = new float[numObsDates][numObsLocations];
		logger.trace("Initializing climArray["+numObsDates+"]["+numObsLocations+"]");
		logger.trace("Number of rows in obsResultSet: "+Database.getNumRSRows(obsResultSet));
		logger.trace("Number of rows in climResultSet: "+Database.getNumRSRows(climResultSet));
		// Sorted location array
		String[] locationArray = locationIdArray;
		Arrays.sort(locationArray);

		//---------------------------------------------------------------------
		// Step 1 - Convert climResultSet into an ArrayList
		//
		// Reset to first row
		try {
			climResultSet.beforeFirst();
		} catch (Exception e) {
			logger.fatal("Problem trying to reset result set row index to 0: "+e);
			Log.fatal("There was a problem trying to retrieve the climatology data.","#errorPanelText");
			throw e;
		}
		// Loop over ResultSet
		while (climResultSet.next()) {
			try {
				// Retrieve column values
				String key = climResultSet.getString("date_valid")+","+climResultSet.getString("id");
				float val  = climResultSet.getFloat(columnName);
				// If this value is NULL, then set it to NaN
				if (climResultSet.wasNull()) {
					val = Float.NaN;
				}
				climHash.put(climResultSet.getString("date_valid")+","+climResultSet.getString("id"),val);
				logger.trace("climHash.put("+climResultSet.getString("date_valid")+","+climResultSet.getString("id")+","+val+")");
			} catch (Exception e) {
				logger.fatal("Problem trying to get values from the climatology ResultSet: "+e);
				Log.fatal("There was a problem trying to retrieve the climatology data.","#errorPanelText");
				throw e;
			}
		}

		//-----------------------------------------------------------------------------------------
		// Step 2 - Loop over the obsResultSet and create a climatology array of dimensions
		// numObsDates x numObsLocations
		//
		// Reset to first row
		try {
			obsResultSet.beforeFirst();
		} catch (Exception e) {
			logger.fatal("Problem trying to reset result set row index to 0: "+e);
			Log.fatal("There was a problem trying to retrieve the climatology data.","#errorPanelText");
			throw e;
		}
		// Loop over ResultSet
		for (int dateCount=0; dateCount<numObsDates; dateCount++) {
			for (int idCount=0; idCount<numObsLocations; idCount++) {
				// Advance ResultSet by 1
				obsResultSet.next();
				try {
					// Retrieve column values
					String date = obsResultSet.getString("date_valid");
					String id   = obsResultSet.getString("id");
					// If this value is NULL, then set it to NaN
					if (obsResultSet.wasNull()) {
						climArray[dateCount][idCount] = Float.NaN;
					} else {
						// Replace the real obs year with '2000', which is how the climo is stored
						String climDate = "2000" + date.substring(4);
						logger.trace("climArray[" + dateCount + "][" + idCount + "] = climHash.get("+climDate+","+id+")");
						climArray[dateCount][idCount] = climHash.get(climDate+","+id);
					}
				} catch (Exception e) {
					logger.fatal("Problem trying to get values from the climatology ResultSet: "+e);
					Log.fatal("There was a problem trying to retrieve the climatology data.","#errorPanelText");
					throw e;
				}
			}
		}
		return climArray;
	}
	//---------------------------------------------------------------
	// Get methods
	//---------------------------------------------------------------

	/**
		Checks for at least one forecast probability value. Once a single
		one is found, this method returns true. If none are found, it returns
		false. This is useful to stop the VWT early if none of the models contain
		any data for the given date range.

		@return  boolean  true if at least one forecast prob is found, false otherwise
	 */
	public boolean checkForAtLeastOneFcstVal() {
		for (int f=0; f<fcstProb.length; f++) {
			for (int d=0; d<fcstProb[0].length; d++) {
				for (int l=0; l<fcstProb[0][0].length; l++) {
					for (int c=0; c<fcstProb[0][0][0].length; c++) {
						if (!Float.isNaN(fcstProb[f][d][l][c])) {
							return true;
						}
					}
				}
			}
		}
		return false;
	}

	/**
	  Get the forecast category as a 3-d array. Dimensions are
	  [# forecast sources][# dates][# locations].
	  @return  3-d array of forecast category in array format  [# forecast sources][# dates][# locations]
	 */
	public float[][][] getFcstCat() {
		return fcstCat;
	}

	/**
	  Get the forecast probabilities as float values in a 4D array.
	  The dimensions of the returned array is as follows:
	  [fcstSourceArray.length][numFcstDates][numFcstLocations][categories(B,N,A)]
	  @return  2-d array of forecast probabilities
	 */
	public float[][][][] getFcstProb() {
		for (int f=0; f<fcstProb.length; f++) {
			for (int d=0; d<fcstProb[0].length; d++) {
				for (int l=0; l<fcstProb[0][0].length; l++) {
					// logger.trace("In get fcst prob for " + f + "th model:  fcstProb[" + f + "][" + d + "][" + l + "] = " + Arrays.toString(fcstProb[f][d][l]));
					//logger.trace("fcstCat probs : " + fcstCat[f][d][l]);
				}
			}
		}
		return fcstProb;
	}

	/**
	  Returns the observation data in dimensions [#dates][#locations] .
	  @return  Observed data
	 */
	public float[][] getObsCat() {
		return obsCat;
	}

	/**
	  Get the percent dry climatology as a 2-d array
	  @return  2-d array of percent dry climatology
	 */
	public float[][] getPercentDry() {
		return percentDry;
	}


	/**
	  Returns the database connection.
	  @return  Database connection
	 */
	public Connection getDbConnection() {
		return dbConnection;
	}

	/**
	  Returns the array of reference data associated with the output dimension requested by the settings object. The variable outputDimension in the settings object represents the dimension that the output stats would be (after data and stats processing). This can either be dates, location names, probability, etc.
	  <br><b>NOTE: </b>The main loadData() uses logic to set the reference data returned by this method. Therefore, loadData() in this class <b>MUST</b> process successfully in order for the reference array to be accesed.
	  @return String array of reference data that would represent the output statistics.
	 */
	public String[] getReferenceArray() {
		if (referenceArray == null) {
			logger.fatal("Reference array is null. Make sure that loadObs() has successfully ran. This method loads this array.");
			Log.fatal("Report null reference array. Possible that incorrect loading of observation data led to this problem.","#errorPanelText");
		}
		return referenceArray;
	}

	/**
	  Returns the array of formatted reference dates associated with the loaded data object. <br>
	  This array is created in loadObs() method. This means that loadObs() in this class <b>MUST</b>
	  be successfully called and processed to return a valid array from this method.
	  <br>
	  To create this array, loadObs() obtains an array of unique dates associated with the load observation data query from the observation database (obtains dates valid). Then loadObs() formats the data. The format is hard-wired in the static formatReferenceDatesArray() method
	  in this class which is called by loadObs(). Currently, depending on whether the leadTimeUnit is "m" or any other unit, it formats the date which is originally
	  YYYY-mm-dd in the DB to MM/yyyy and MM/dd/yyyy, respectively.
	  <br>
	  @return String array of formatted reference dates.
	 */
	public String[] getFormattedReferenceDatesArray() {
		return formattedRefDatesArray;
	}

	/**
	  Returns the array of formatted forecast issued dates associated with the loaded data object. <br>
	  This array is created in loadFcst() method. This means that loadFcst() in this class <b>MUST</b>
	  be successfully called and processed to return a valid array from this method.
	  <br>
	  To create this array, loadFcst() obtains an array of unique dates associated with the load observation data query from the observation database (obtains dates valid). Then loadFcst() formats the data. The format is hard-wired in the static formatReferenceDatesArray() method
	  in this class which is called by loadFcst(). Currently, depending on whether the leadTimeUnit is "m" or any other unit, it formats the date which is originally
	  YYYY-mm-dd in the DB to MM/yyyy and MM/dd/yyyy, respectively.
	  <br>
	  @return String array of formatted reference dates.
	 */
	public String[] getFormattedIssuedDatesArray() {
		return formattedIssuedDatesArray;
	}


	/**
	  Returns an integer representing the number of weekdays in the forecast range of dates.
	  The calculation is done in utils.Date.java.
	  @return Integer value of the number of weekdays in the forecast range of dates.
	 */
	public int getNumWeekdays() {
		return numWeekdays;
	}


	/**
	  Returns an integer representing the number of unique occurences of dates in the forecast data loaded (non-redundant dates associated with multiple locations for example).
	  @return Integer value of the number of unique dates representing the loaded forecast data to this data object.
	 */
	public int getNumUniqueFcstDates() {
		return numFcstDates;
	}

	/**
	  Returns a String array of location IDs. This can be an array of WMO number (station table), grid point number (gridded table), and climate division number (climate division table), etc.
	  @return 1-D String array of location IDs associated with the loaded data object.
	 */
	public String[] getLocationIdArray() {
		return locationIdArray;
	}

	/**
	  Returns a String array of location names. There are various types of formats of location information returned, depending on the type of locations. Stations return station names, for climate divisions, 3-digit number of the climate division is returned, for a gridded set a grid point XXYY (ie. DC National, 005, 0120) is returned.
	  @return 1-D String array of location names associated with the loaded data object.
	 */
	public String[] getLocationNameArray() {
		return locationNameArray;
	}

	/**
	  Returns a String array of Lon/Lat values. Float values, each pair is formatted lon,lat (ie.  80.30,45.20).
	  @return 1-D String array of location lon/lat values associated with the loaded data object.
	 */
	public String[] getlocationLonLatArray() {
		return locationLonLatArray;
	}

	/**
	  Returns a String array of Longitude values. Array of lon gitudevalues are  float values (ie. 80.30).
	  @return 1-D String array of longitude values associated with the loaded data object.
	 */
	public String[] getLocationLonArray() {
		return locationLonArray;
	}

	/**
	  Returns a String array of latitude values. Array of latitude values are returned in the form of float values (ie. 45.20).
	  @return 1-D String array of latitude values associated with the loaded data object.
	 */
	public String[] getLocationLatArray() {
		return locationLatArray;
	}

	/**
	  Returns the String representing the format of date issued in Java SimpleDateFormat.
	  @return sdfSourceFormat String representing the format of the dates in the date issued column as a valid SimpleDateFormat value.
	 */
	public String getSdfSourceFormat() {
		return sdfSourceFormat;
	}

	/**
	  Returns the first and last forecast valid dates in a String array. The first valid date is in index 0, the last valid date is in index 1. The date is formatted the way it occurs in the forecast database. Typically this is formatted as YYYY-mm-dd which is the way that MySQL dates are formatted.
	  @return String array containing the first available valid date of the loaded forecast (index 0), and the last available valid date of the loaded forecast (index 1).
	 */
	public String[] getFcstDateValidBounds() throws Exception {
		String[] dateBoundsArray = new String[2];
		// If either first of last fcst valid dates null, kill process
		if ((firstFcstValidDate == null) ||  (lastFcstValidDate == null)) {
			throw new Exception("First and/or last forecast dates are null and cannot be retrieved.");
		}
		dateBoundsArray[0] = firstFcstValidDate;
		dateBoundsArray[1] = lastFcstValidDate;
		return dateBoundsArray;
	}

	/**
	  Returns the number of expected locations based on the forecast source. Typically used for use in quality control using a percentage threshold for passing. These values were determined somewhat subjectively by the Climate Prediction Center to make better judgements for quality control. This method retrieves the values from the reference database.
	  @param forecastSource Forecast source to retrieve the number of expected locations for. The format is typically xxxx_yyyy_zzz <br>
where: <br>
xxxx tool that produced the forecast data <br>
yyyy model that the tool is based on <br>
zzz  cycle of the model <br>
@param forecastType Type of forecast (ie 'extendedRange' or 'longRange'). Can be retrieved from the loaded settings object.
@param variable Type of variable (ie 'temp or 'precip'). Can be retrieved from the loaded settings object.
@param spatialType Type of spatial information used for data (ie 'station' or 'gridded' or 'climateDivision')
@param refDBName Name of the reference table
@return Integer representing the number of expected locations associated with the passed settings to this method.
	 */
	public int getNumExpectedLocations(String forecastSource, String forecastType,String variable, String spatialType, String refDBName) throws Exception {
		int numExpectedLocations = 0;
		// Name of column in reference table with num expected locations
		String numExpectedLocationsColName = "numExpectedLocations";
		String toolName = null;
		String modelName = null;
		String cycleName = null;
		String refQuery = null;
		String[] refResultsStrArray  = null;
		String numExpectedLocationsStr;

		try {
			toolName = Settings.getForecastToolName(forecastSource);
			logger.trace("Tool name is : " + toolName);
			modelName = Settings.getModelName(forecastSource);
			logger.trace("Model name is : " + modelName);
			cycleName = Settings.getCycleName(forecastSource);
			logger.trace("Cycle name is : " + cycleName);
		}
		catch (Exception e) {
			Log.fatal("Could not retrieve forecast source name components.","#errorPanelText");
			throw new Exception("Could not retrieve the forecast tool, model, or cycle name from the passed forecast source " + forecastSource);

		}

		// if there is only 1 value (nothing after underscores) in the fcst Source name, use the fcst source as the value for fcstSource, otherwise use the word 'tool'.

		// If the model name has an associated tool, build Sql query for the tool
		if (modelName != null) {
			refQuery = "SELECT " + numExpectedLocationsColName + " FROM " + refDBName + ".dataSettings WHERE dataType='forecast' AND variable='" + variable + "' AND fcstSource='tool' AND fcstType='" + forecastType + "' AND tool='" + toolName + "' AND model='" + modelName + "' AND spatialType='" +  SettingsHashLibrary.getSpatialTypeTableName(spatialType) + "'";
			logger.trace("Sql Query to retrieve # expected locations based on the forecast (for tool) : " + refQuery);
		}
		// Else use non-tool query
		else {
			// Set tool and model to empty in query
			toolName = "";
			modelName = "";
			refQuery = "SELECT " + numExpectedLocationsColName + " FROM " + refDBName + ".dataSettings WHERE dataType='forecast' AND variable='" + variable + "' AND fcstSource='" +  forecastSource + "' AND fcstType='" + forecastType + "' AND tool='" + toolName + "' AND model='" + modelName + "' AND spatialType='" +  SettingsHashLibrary.getSpatialTypeTableName(spatialType) + "'";
			logger.trace("Sql Query to retrieve # expected locations based on the forecast (not for tool) : " + refQuery);
		}
		// try to get results from database
		try {
			// Get the result set object to use for the rest of the data information needed
			ResultSet refResults = Database.getResultSet(refQuery,dbConnection);
			refResultsStrArray = Database.getUniqueRSResults("numExpectedLocations",refResults);
			numExpectedLocationsStr = refResultsStrArray[0];
			numExpectedLocations = Integer.parseInt(numExpectedLocationsStr);
			logger.trace("# expected locations based on forecast is : " + numExpectedLocationsStr);
		}
		catch (Exception e) {
			throw e;
		}

		return numExpectedLocations;
	}
	//---------------------------------------------------------------
	// Set methods
	//---------------------------------------------------------------

	/**
	  Formats a passed array of dates which can be retrieved by calling getFormattedReferenceDatesArray() in this class . A String representing a Java SimpleDateFormat date format must be passed representing the original format of the passed date array. The format it is converted to
	  depends on the passed lead time unit. The formats associated with the available units are hard-wired in this method, currently as:
	  <br>
	  leadTimeUnit = "m" -> format MM/yyyy
	  <br>
	  Any other leadTimeUnit -> format MM/dd/yyyy
	  @param dateArray String array of dates to convert to a new format
	  @param sdfSourceStr String value of a valid SimpleDateFormat representation of the original dateArray passed
	  @param leadTimeUnit String value of a character represnting the unit of lead time (typically "m" or "d").
	 */
	public void setFormattedReferenceDatesArray(String[] dateArray, String sdfSourceStr, String leadTimeUnit) {

		// Initialize variables
		SimpleDateFormat sdfSource;
		String sdfDestinationStr;
		SimpleDateFormat sdfDestination;
		String[] formattedDateArray = new String[dateArray.length];
		java.util.Date date;
		// For each dateArray value, convert to new format
		// Desired format for displayed date display labels
		if  (leadTimeUnit.compareToIgnoreCase("m")==0) {
			sdfDestinationStr = "MM/yyyy";
		}
		else {
			sdfDestinationStr = "MM/dd/yyyy";
		}
		logger.trace("in setFormattedReferenceDatesArray(). Date array : " + Arrays.toString(dateArray) + " , sdfSourceStr :  " + sdfSourceStr + " sdfDestinationStr : " + sdfDestinationStr);
		/////////////////////////////////
		//Format date with either including the full day string in the date or month and year
		// - For lead times with the unit "m", include just the mm/YYYY, mm/dd/YYYY
		/////////////////////////////////
		// Create SimpleDateFormat object with original date format
		sdfSource = new SimpleDateFormat(sdfSourceStr);
		// Create SimpleDateFormat object with desired date format
		sdfDestination = new SimpleDateFormat(sdfDestinationStr);

		try {
			for (int i = 0;i<formattedDateArray.length;i++){
				// Parse the string into Date object
				date = (java.util.Date)sdfSource.parse(dateArray[i]);
				// Parse the date into another format. The new format to convert to is set at the top of the
				// class (sdfDestination = new...)
				formattedDateArray[i] = sdfDestination.format(date);
			}
		}
		catch (ParseException e) {
			// return original array if reformatting did not work
			formattedDateArray = dateArray;
			logger.warn("Could not format the dates passed to the new format. Make sure that valid Strings of Java SimpleDateFormat are passed correctly.");
			logger.warn("See if the passed date string array and its source is correct. If it was not, then it could not be formatted. : " + Arrays.toString(dateArray) + " , sdfSourceStr :  " + sdfSourceStr + " sdfDestinationStr : " + sdfDestinationStr);
			Log.error("Dates displayed are not formatted but are likely still correct values. Report unintended format of dates.","#errorPanelText");
		}
		// Set shared array to the formatted array
		formattedRefDatesArray = formattedDateArray;
	}

	/**
	  Formats a passed array of forecast issued dates which can be retrieved by calling getFormattedIssuedDatesArray() in this class . A String representing a Java SimpleDateFormat date format must be passed representing the original format of the passed date array. The format it is converted to
	  depends on the passed lead time unit. The formats associated with the available units are hard-wired in this method, currently as:
	  <br>
	  leadTimeUnit = "m" -> format MM/yyyy
	  <br>
	  Any other leadTimeUnit -> format MM/dd/yyyy
	  @param dateArray String array of dates to convert to a new format
	  @param sdfSourceStr String value of a valid SimpleDateFormat representation of the original dateArray passed
	  @param leadTimeUnit String value of a character represnting the unit of lead time (typically "m" or "d").
	 */
	public void setFormattedIssuedDatesArray(String[] dateArray, String sdfSourceStr, String leadTimeUnit) {

		// Initialize variables
		SimpleDateFormat sdfSource;
		String sdfDestinationStr;
		SimpleDateFormat sdfDestination;
		String[] formattedDateArray = new String[dateArray.length];
		java.util.Date date;
		// For each dateArray value, convert to new format
		// Desired format for displayed date display labels
		if  (leadTimeUnit.compareToIgnoreCase("m")==0) {
			sdfDestinationStr = "MM/yyyy";
		}
		else {
			sdfDestinationStr = "MM/dd/yyyy";
		}
		logger.trace("in setFormattedIssuedDatesArray(). Date array : " + Arrays.toString(dateArray) + " , sdfSourceStr :  " + sdfSourceStr + " sdfDestinationStr : " + sdfDestinationStr);
		/////////////////////////////////
		//Format date with either including the full day string in the date or month and year
		// - For lead times with the unit "m", include just the mm/YYYY, mm/dd/YYYY
		/////////////////////////////////
		// Create SimpleDateFormat object with original date format
		sdfSource = new SimpleDateFormat(sdfSourceStr);
		// Create SimpleDateFormat object with desired date format
		sdfDestination = new SimpleDateFormat(sdfDestinationStr);

		try {
			for (int i = 0;i<formattedDateArray.length;i++){
				// Parse the string into Date object
				date = (java.util.Date)sdfSource.parse(dateArray[i]);
				// Parse the date into another format. The new format to convert to is set at the top of the
				// class (sdfDestination = new...)
				formattedDateArray[i] = sdfDestination.format(date);
			}
		}
		catch (ParseException e) {
			// return original array if reformatting did not work
			formattedDateArray = dateArray;
			logger.warn("Could not format the dates passed to the new format. Make sure that valid Strings of Java SimpleDateFormat are passed correctly.");
			logger.warn("See if the passed date string array and its source is correct. If it was not, then it could not be formatted. : " + Arrays.toString(dateArray) + " , sdfSourceStr :  " + sdfSourceStr + " sdfDestinationStr : " + sdfDestinationStr);
			Log.error("Dates displayed are not formatted but are likely still correct values. Report unintended format of dates.","#errorPanelText");
		}
		// Set shared array to the formatted array
		formattedIssuedDatesArray = formattedDateArray;
	}


	//---------------------------------------------------------------
	// Set methods
	//---------------------------------------------------------------

	/**
	  Sets the database connection.
	  @param conn  Database connection
	 */
	public void setDbConnection(Connection conn) {
		dbConnection = conn;
	}

	// Location set methods
	// Set methods aren't typically called, typically the Data.loadObs() method
	// creates these values

	/**
	  Sets an array storing the lon,lat String of each location being verified
	  @param array  The array to set
	 */
	public void setLocationLonLatArray(String[] array) {
		locationLonLatArray = array;
	}

	/**
	  Sets an array storing the lat String of each location being verified
	  @param array  The array to set
	 */
	public void setLocationLatArray(String[] array) {
		locationLatArray = array;
	}

	/**
	  Sets an array storing the lon String of each location being verified
	  @param array  The array to set
	 */
	public void setLocationLonArray(String[] array) {
		locationLonArray = array;
	}

	/**
	  Sets an array storing the names of each location being verified
	  @param array  The array to set
	 */
	public void setLocationNameArray(String[] array) {
		locationNameArray = array;
	}

	/**
	  Set the first and last dates of dates valid of forecast data that was loaded into the data object.
	  This is so the loadObs() load observation method can include these bounds to match the beginning and end dates of the loaded forecast data for correctly paired data.
	  @param firstDate First date in the format 'YYYY-mm-dd' that is the first date of available loaded forecast data in terms of date valid.
	  @param lastDate Last date in the format 'YYYY-mm-dd' that is the lastt date of available loaded forecast data in terms of date valid.
	 */
	public void setFcstDateValidBounds(String firstDate, String lastDate) {
		firstFcstValidDate = firstDate;
		lastFcstValidDate = lastDate;
	}

	/**
	  Sets the String representing the format of date issued in the forecast database as a Java SimpleDateFormat. This would typically be 'yyyy-MM-dd' since the MySQL databse requires this format. You can call this set method in the verification driver once the data object is created.
	  @param sdfSourceFormatStr String representing the format of the dates in the date issued column as a valid SimpleDateFormat value.
	 */
	public void setSdfSourceFormat(String sdfSourceFormatStr) {
		sdfSourceFormat = sdfSourceFormatStr;
	}


}
