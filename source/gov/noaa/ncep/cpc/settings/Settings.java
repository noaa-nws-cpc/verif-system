package gov.noaa.ncep.cpc.settings;

//-------------------------------------------------------------------
// Import classes needed for date manipulation
//-------------------------------------------------------------------
import gov.noaa.ncep.cpc.exception.InvalidSettingException;
import gov.noaa.ncep.cpc.settings.SettingsHashLibrary;
import gov.noaa.ncep.cpc.format.FormatLibrary;
import gov.noaa.ncep.cpc.qc.Log;
import java.util.Arrays;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.LinkedHashMap;

import org.apache.log4j.Logger;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
Contains methods responsible for loading
and storing the settings as well as get methods to retrieve the settings values.
See the constructor API documentation for a list of settings and fu
*/
public class Settings {

	//---------------------------------------------------------------
	// Initialize variables
	//
	// Variables ending in an 's' can have multiple values, separated
	// by commas (eg. regions = 'TX','LA','MS'). These variables will
	// also have an associated Array version (eg. fcstSources and
	// fcstSourceArray).
	//---------------------------------------------------------------
	private String variable;               // Variable used to calculate score
	private String fcstSources;            // What produced the forecast (Can be a list)
	private String leadTime;               // Time to the center of the valid period
	private String aveWindow;              // Width of verification period
	private String categoryType;	       // scores calculated for all categories or for separate categories
	private String datesValidType;         // Type of specification of dates valid to process for
	private String datesValid;             // Dates valid, which is reformatted during Settings processing with a dummy day in the date for monthly/seasonal settings
	private String datesValidOriginalFormat; // Comma and semi-colon delimited list of specs for filtering data to verify for.
	private String regionType;             // Regional divisions users select from
	private String regions;                // Particular regions users selects
	private String spatialType;            // How each datapoint is spatially stored
	private String outputType;             // Method of displaying score
	private String outputDimension;        // Dimension that output represents
	private String scoreType;              // Verification score type
	private boolean dryLocationCorrection; // Specifies whether precip dry location correction is done 
	private String homeDir;                // Home directory of the Verification System
	private String ECType;                 // Existence of equal chances in the forecasts. Either non equal chances forecasts only or all forecasts
	private boolean webFlag;		// Boolean of whether web services is or is not initiating run-time.
	private String settingsMethod;         // Method of passing settings to driver
	private String[] settingsArray;        // Array storing all settings
	private String[] dateStringArray;      // String array of dates in verification period
	private int numProbLevels = 3;         // Number of probability levels for the forecast data
	private String dateRangeFormat = null; // Format of the startDate and endDate values in Java SimpleDateFormat format.
	// Settings with multiple values
	private String[] fcstSourceArray;
	private String[] regionArray;
	private String fcstToolName;
	// Database names
	private String fcstDBName, obsDBName, climDBName, refDBName, VWTDBName;
								 
	// Initialize logger
	static Logger logger = Logger.getLogger(Settings.class.getName());

	/**
	Creates a Settings object that will parse settings from the provided
	array. The array must contain the following variables in order:
<ul>
<li> variable   -      Variable to perform verification for. (ie. temp, precip)
<li> fcstSources   -    List of forecast sources separated by commas. Logic downstream will separate these forecast sources appropriately. (ie. manual, auto)
<li> leadTime     -    Time to the center of the valid period. Format is ${numSpan}${unit}, where ${numSpan} is the number representing the lead time according to the following ${unit} unit of time. ${unit} can have the values of characters "d" and "m", for days and months, respectively. (ie. "05d" is a lead time of 5 days)
<li> aveWindow   -     Width of valid period. Format is ${numSpan}${unit}, where ${numSpan} is the number of time units (according to type ${unit}) that the verification is over. ${unit} can have the values of characters "d" and "m", for days and months, respectively. (ie. "05d" is a valid period of 5 days)
<li> datesValidType - Type of way to filter the data to verify for. Current available ways to filter:<br>
<table border="1">
<th>
Filter method
</th>
<th>value of datesValidType
<tr>
	<td>Days in a range:</td>
	<td>dateRange</td>
</tr>
<tr>
	<td>Select months for all years:</td>
	<td>selectMonths</td>
</tr>
<tr>
	<td>Select months and select years:</td>
	<td>selectMonthsYears</td>
</tr>
<tr>
	<td>Select seasonal climate signals (ie. ENSO) :</td>
	<td>selectSeasonalSignal</td>
</tr>
<tr>
	<td>Select monthly climate signals (ie. AO) :</td>
	<td>selectMonthlySignal</td>
</tr>
</table>
<li> datesValid - Formatted string of date information representing how to filter the data to verify for as specified by dateFilterRequestType. These dateValidRequest values applies to the valid date of forecast data. The format allows for multiple combined ways to filter.
The set within one type of filtering is comma delimited, the different sets of filtering
specifications are separated by a semi-colon.:
<table border="1">
<th>Verify forecasts valid for</th>
<th>value of datesValidType</th>
<th>value of datesValid</th>
<tr>
	<td>Days between 20090101 and 20090620</td>
	<td>dateRange</td>
	<td>20090101,20090620</td>
</tr>
<tr>
	<td>January and July months for all years:</td>
	<td>selectMonths</td>
	<td>01,07</td>
</tr>
<tr>
	<td>January and July months that are in the years 2000,2005,2010</td>
	<td>selectMonthsYears</td>
	<td>01,07;2000,2005,2010</td>
</tr>
<tr>
	<td>Seasons with warm El Nino/La-Nina Southern Oscillation ENSO conditions</td>
	<td>selectSeasonalSignal</td>
	<td>ENSO;warm</td>
</tr>
<tr>
	<td>Seasons with positive Arctic Oscillation (AO) conditions</td>
	<td>selectMonthlySignal</td>
	<td>AO;positive</td>
</tr>
</table>
<li> regionType  -     Type of regional division to use for verification calculations. ie. regional climate centers, states, stations, etc. (ie. climateRegion, state, climateDivision)
<li> regions     -     Particular region(s) to perform verification for. (ie. NE,SE,W, All, NY,NJ,CT,RI, 8,16,98)
<li> spatialType  -    Type of storage of each data point. The datasets of forecasts and/or observations are made up of different types of ways that the data represents. (ie.station,gridded,climateDivision)
<li> outputType   -    Method of displaying and/or producing output for a score. This is the representational format of the output data produced by the verification software. (ie. chart, map, ascii, etc.)
<li> outputDimension - Dimension that the output represents. It would be the reference dimension that each of the score values represent. ie. 
<br>space - scores representing spatial points, ie. on a map
<br>time - scores representing dates, ie. on a timeseries chart
<br>probability - scores representing probability values, ie. reliability scores, where the scores represent an interval of probabilities of a forecast category
<li> scoreType   -  Type of verification score to calculate. (ie. heidke, rpss, brier, reliability)
<li> categoryType  -   How to plot scores for the categories. (ie. total, separate, B, N, A)
<li> ECType - Status of whether forecasts to be verified uses equal chances forecasts or not. (ie. "noEC" or "withEC"). An example of setting this to "withEC" would be for monthly and seasonal forecasts that have equal chances as a category. See setECType() method in this class
</ul>
There are some settings that are set within methods automatically based on a settings value passed and are not included in the passed settings array :
<ul>
<li> dryLocationCorrection - Status of whether dry location correction should be done. Applies to heidke precip short range only.
<li> spatialTypeTableName - String piece of database table name representing the spatial type (ie. stn, grid2deg, cd). See getSpatialTypeTableName() method API documentation in this class for more information.
<li> numProbLevels - The number of probability levels as an integer. This is hard-wired currently in this class as '3'.
<li> homeDir - Home directory of the verification system (ie. /cpc/prod_tst/cpcfcst/verification).
<p> The below variables exist, but do not have get methods for these. Should get methods for these be added?
<li>dateRangeFormat - String format representing the date values as specified in datesValid. This representation is in format of Java SimpleDateFormat. There is a get and set method to access this information in this class.
</ul>
<br>Developer's Notes:<br>
dateStringArray - Array of Strings of the dates associated with the data points (ie. 11/22/2010, 11/23/2010) can be retrieved from the data object in the /data package. See Data.java getReferenceDatesArray() method.
@param settingsArray String array of settings values.
	*/
	public Settings(String[] settingsArray) {
		// Set the global settingsArray to the one passed to the constructor
		this.settingsArray = settingsArray;
		// Split the array into separate variables
		splitStringArray(settingsArray);
	}

	//---------------------------------------------------------------
	// Get-methods
	//---------------------------------------------------------------

	/**
	Gets the name of the forecast database

	@return Forecast database name
	*/
	public String getFcstDBName() {
		return fcstDBName;
	}

	/**
	Gets the name of the observation database

	@return Observation database name
	*/
	public String getObsDBName() {
		return obsDBName;
	}

	/**
	Gets the name of the climatology database

	@return Climatology database name
	*/
	public String getClimDBName() {
		return climDBName;
	}

	/**
	Gets the name of the reference database

	@return Reference database name
	*/
	public String getRefDBName() {
		return refDBName;
	}

	/**
	Gets the name of the VWT database

	@return VWT database name
	*/
	public String getVWTDBName() {
		return VWTDBName;
	}

	/**
	Gets the number of probability levels in the forecast data.

	@return  The number of probability levels
	*/
	public int getNumProbLevels() {
		return numProbLevels;
	}

	/**
	Gets the variable

	@return  The variable
	*/
	public String getVariable() {
		return variable;
	}

	/**
	Returns a list of forecast sources separated by commas.

	@return  The forecast source
	*/
	public String getFcstSources() {
		return fcstSources;
	}

	/**
	Returns the lead time as specified by the settings passed. This would typically be
	in the format that represents the lead time part of the Database table name associated with it.
	For example, a table with forecast of 0.5 months lead has the convention of being denoted as
	'0pt5m', table name :temp_off_0pt5m_01m_stn . This would be what is passed in the settings as the lead time.
	This string passed builds the table name in the database.
	<br>
	To get a numeric version of the lead time (without the lead time unit included), you can call the method in this class getLeadTimeNumberFormat.
	This would return '0.5' instead of '0pt5m' as this method would.
	<br>
	The lead time unit can be retrieved by calling getLeadTimeUnit() in this class as well.
	@return  The lead time
	*/
	public String getLeadTime() {
		return leadTime;
	}

	/**
	Returns the lead time value as a String of the numeric value based on the leadTime. This includes the character at the end of the string with the lead time unit. A non-integer value lead, ie. a leadTime of '0pt5m', is converted to a decimal formatted lead time, ie. '0.5m'. 0.5m would be the value returned in this case.
	@return Lead time value of a numeric value as represented by a String including the character at the end of the string with the time unit.
	*/
	public String getLeadTimeNumberFormat() {
		// Convert a leadTime submitted value to SettingsHashLibrary.convertLeadTime(),
		// This will convert a value representing a non-integer value with the string 'pt' to a decimal value,
		String leadTimeConverted = leadTime.replaceAll("pt",".");
		return leadTimeConverted;
	}

	/**
	Returns the numeric portion of the lead time value as a non-zero padded number, with no character representing the lead time unit. ie. '08d' would be returned as '8'.
	@return Time part without zero pads of the lead time value of a numeric value as represented by a String.
	*/
	public String getLeadTimeNumber() {
		// Convert a leadTime submitted value to SettingsHashLibrary.convertLeadTime(),
		// This will convert a value representing a non-integer value with the string 'pt' to a decimal value,
		String leadTimeValue=getLeadTimeNumberFormat();
		String leadTimeConverted = leadTimeValue.substring(0,leadTimeValue.length()-1);
		
		return leadTimeConverted;
	}

	/**
	Returns the character of the leadTime as a String value representing the lead time unit.
	This method assumes it the unit is represented by a single character in the last character of the lead time string.
	@return String of a single character representing the lead time unit.
	*/
	public String getLeadTimeUnit() {
		String leadTimeUnit = leadTime.substring(leadTime.length()-1);
		return leadTimeUnit;
	}

	/**
	Returns the fcstType as a String value representing the type of forecast in question.
	This method uses the leadTimeUnit variable to determine whether this forecast is
	extendedRange or longRange.
	@return String of the forecast type
	*/
	public String getFcstType() {
		String regex = ".*(" + SettingsHashLibrary.getPossibleCategoryUnitsList() + ")-([0-9pt]+)-and-([0-9pt]+).*";
		Pattern pattern = Pattern.compile(regex);
		Matcher match = pattern.matcher(this.getForecastToolName(getFcstSources()));
		if (match.find()) {
			return "extremes";
		} else if (this.getLeadTimeUnit().compareToIgnoreCase("d")==0) {
			return "extendedRange";
		} else if (this.getLeadTimeUnit().compareToIgnoreCase("m")==0) {
			return "longRange";
		} else {
			return "none";
		}
	}

	/**
	Gets the averaging window

	@return  The averaging window
	*/
	public String getAveWindow() {
		return aveWindow;
	}

	/**
	Returns the numeric portion of the average time window as a String of the numeric value based on the leadTime. This includes the character at the end of the string with the lead time unit. A non-integer value ie. '0pt5m', is converted to a decimal formatted lead time, ie. '0.5m'. 0.5m would be the value returned in this case.
	@return Lead time value of a numeric value as represented by a String.
	*/
	public String getAveWindowNumberFormat() {
		// Convert a leadTime submitted value to SettingsHashLibrary.convertLeadTime(),
		// This will convert a value representing a non-integer value with the string 'pt' to a decimal value,
		String aveWindowConverted = aveWindow.replaceAll("pt",".");
		return aveWindowConverted;
	}

	/**
	Returns the numeric portion of the average window value as a non-zero padded number, with no character representing the average window time unit. ie. '08d' would be returned as '8'.
	@return Time part without zero pads of the average window value of a numeric value as represented by a String.
	*/
	public String getAveWindowNumber() {
		// Convert a leadTime submitted value to SettingsHashLibrary.convertLeadTime(),
		// This will convert a value representing a non-integer value with the string 'pt' to a decimal value,
		String aveWindowValue=getAveWindowNumberFormat();
		logger.debug("aveWindowValue is " + aveWindowValue);
		String aveWindowConverted = Integer.toString(Integer.parseInt(aveWindowValue.substring(0,aveWindowValue.length()-1)));
		return aveWindowConverted;
	}

	/**
	Returns the character of the aveWindow as a String value representing the average time window unit.
	This method assumes it the unit is represented by a single character in the last character of the average time window string.
	@return String of a single character representing the average time window unit.
	*/
	public String getAveWindowTimeUnit() {
		String aveWindowUnit = aveWindow.substring(aveWindow.length()-1);
		return aveWindowUnit;
	}

	/**
	Gets the EC type, which is set by calling setECType. setECType needs to be called prior to using this method. Typically this occurs in a driver.

	@return  The EC type
	*/
	public String getECType() {
		return ECType;
	}

        /**
        Gets the dryLocationCorrection status (true does the correction, false does not do it). 
	Applies to variable of precip, scoreType of heidke, and fcstType of extendedRange only (station and gridded forecast/observation data).
	Stats class calls appropriate score calculation method based on this value of this parameter. 

        @return The dry station correction status 
        */
        public boolean getDryLocationCorrection() {
			if (this.getVariable().equals("precip") && this.getScoreType().equals("heidke") && 
			    this.getLeadTimeUnit().compareToIgnoreCase("d")==0 &&
			    (this.getSpatialType().equals("station") || this.getSpatialType().equals("gridded")) &&
			    Arrays.asList("extendedRange").contains(this.getFcstType())
			) {
				return true;
			}
			else {
				return false;
			}
        }

	/**
	Gets the category type
Total means scores are calculated for all categories together and separate is for
scores by categories B,N,A, in that order.

	@return  The category type
	*/
	public String getCategoryType() {
				return categoryType;
	}


	/**
	Gets the datesValidType.
	@return The type of date filter desired
	to be applied to the forecast for verifying.
	*/
	public String getDatesValidType() {
		return datesValidType;
	}

	/**
	Gets the datesValid.
	@return The String representation of date information used to apply to the date filtering
	to verify forecasts for.
	*/
	public String getDatesValid() {
		return datesValid;
	}

	/**
	Gets the datesValid.
	@return The String representation of date information used to apply to the date filtering
	to verify forecasts for.
	*/
	public String getDatesValidOriginalFormat() {
		return datesValidOriginalFormat;
	}
	
    /**
    Gets the date string array.
    */
	public String[] getDateStringArray()
	{
		return dateStringArray;
	}

	/**
	Gets the region type

	@return  The region type
	*/
	public String getRegionType() {
		return regionType;
	}

	/**
	Gets the regions

	@return  The region(s)
	*/
	public String getRegions() {
		return regions;
	}

    /**
    Gets the region array
    */
	public String[] getRegionArray()
	{
		return regionArray;
	}

	/**
	Gets the spatial type

	@return  The spatial type
	*/
	public String getSpatialType() {
		return spatialType;
	}

	/**
	Gets the output type

	@return  The output type
	*/
	public String getOutputType() {
		return outputType;
	}

	/**
	Gets the output dimension. This is the dimension of reference for the score output.
	@return The output dimension
	*/
	public String getOutputDimension() {
		return outputDimension;
	}

	/**
	Gets the score type

	@return  The score type
	*/
	public String getScoreType() {
		return scoreType;
	}


	/**
	Gets the forecast source array

	@return  The forecast source array
	*/
	public String[] getFcstSourceArray() {
		return fcstSourceArray;
	}

	/**
	Gets the index of the specified forecast source
	If there is no forecast source with that name it returns -1

	@param name String of the forecast source name
	@return  The index of the specified forecast
	*/
	public int getFcstSourceIndex(String name) {
		logger.debug("fcstSource to find is " + name);
		int fcstSourceIndex = -1;
		String[] fcstSourceArray = getFcstSourceArray();
		int numFcstSources = fcstSourceArray.length;
		for (int i=0; i<numFcstSources; i++) {
			if (fcstSourceArray[i].equals(name)) {
				fcstSourceIndex = i;
				logger.debug("Index is " + i);
				break;
			}
		}
		if (fcstSourceIndex == -1) {
			//Log.fatal(name + " is not a valid forecast source", "#errorPanelText");
			logger.warn(name + " is not a valid forecast source");
		}
		return fcstSourceIndex;
	}

	/**
	Returns a list of long range forecast sources that contain EC forecasts
	and should be verified including EC forecasts. Long range forecast sources not on
    this list contain EC forecasts but these forecasts are forecasts that are below
    the skill mask (skill less than .30) and should not be verified. They have
    probabilities of .3333 for all categories and a forecast category of 0. The stats
    class removes these forecasts for verification. For Consolidation, a skill mask
    is already incorporated into the probabilities and EC forecasts should be verified.

	@return An array of forecast sources that contain EC forecasts to be verified.
	*/
	public String[] getLongRangeEcFcstSourceListArray() {
		String[] longRangeEcFcstSourceListArray={"manual","con"};
		return longRangeEcFcstSourceListArray;
	}

	/**
	Returns the home directory of the Verification System
	*/
	public String getHomeDir() {
		return homeDir;
	}

    /**
    Returns the settings method
    */
	public String getSettingsMethod()
	{
		return settingsMethod;
	}

    /**
    Returns the settings array
    */
	public String[] getSettingsArray()
	{
		return settingsArray;
	}
    
    /**
    Returns the forecast tool name if it exists as part of the forecast source name.
    This method is used in situations where there are 
    The convention for the forecast source name is <br>
    xxxx_yyyy_zzz <br>
	where: <br>
	 xxxx tool that produced the forecast data <br>
	 yyyy model that the tool is based on <br>
	 zzz  cycle of the model <br>
	@param forecastSource String forecast source name
	@return Name of forecast tool. If there is no tool associated with this forecast source, an empty space value is returned.
	
    */ 
    public static String getForecastToolName(String forecastSource)
    {
    	String[] fcstSourceNameArray;
	String name = null;
    	// Use toStringArray method in FormatLibrary to parse forecast source name
	try {
		fcstSourceNameArray = FormatLibrary.toStringArray(forecastSource,"_");
		logger.trace("The forecast tool name array is : " + Arrays.toString(fcstSourceNameArray));
		// The tool is the first part of the parsed string
		name = fcstSourceNameArray[0];
	}
	catch(Exception e) {
    		logger.fatal("Could not parse the forecast source value to obtain the tool name. Make sure that the forecast source is delimited with underscores.");
		Log.fatal("Problem parsing forecast tool name","#errorPanelText");
	}
    return name;
    }

    /**
    Returns the model name if it exists as part of the forecast source name.
    This method is used in situations where there are 
    The convention for the forecast source name is <br>
    xxxx_yyyy_zzz <br>
	where: <br>
	 xxxx tool that produced the forecast data <br>
	 yyyy model that the tool is based on <br>
	 zzz  cycle of the model <br>
	@param forecastSource String forecast source name
	@return Name of forecast model associated with the forecast source. If there is no tool associated with this forecast source, an empty space value is returned.
	
    */ 
    public static String getModelName(String forecastSource) throws Exception
    {
    	String[] fcstSourceNameArray;
	String name = null;
    	// Use toStringArray method in FormatLibrary to parse forecast source name
	try {
		fcstSourceNameArray = FormatLibrary.toStringArray(forecastSource,"_");
		logger.trace("The forecast tool name array is : " + Arrays.toString(fcstSourceNameArray));
		// If the array size is greater than 1, get the second array value
		if (fcstSourceNameArray.length>1) {
			name = fcstSourceNameArray[1];
		}
	}
	catch(Exception e) {
    		logger.fatal("Could not parse the forecast source value to obtain the model name. Make sure that the forecast source is delimited with underscores.");
		Log.fatal("Problem parsing forecast model name","#errorPanelText");
	}
    return name;
    }
    
    /**
    Returns the cycle name if it exists as part of the forecast source name.
    This method is used in situations where there are 
    The convention for the forecast source name is <br>
    xxxx_yyyy_zzz <br>
	where: <br>
	 xxxx tool that produced the forecast data <br>
	 yyyy model that the tool is based on <br>
	 zzz  cycle of the model <br>
	@param forecastSource String forecast source name
	@return Name of forecast cycle associated with the forecast source. If there is no tool associated with this forecast source, an empty space value is returned.
	
    */ 
    public static String getCycleName(String forecastSource) throws Exception
    {
    	String[] fcstSourceNameArray;
	String name = null;
    	// Use toStringArray method in FormatLibrary to parse forecast source name
	try {
		fcstSourceNameArray = FormatLibrary.toStringArray(forecastSource,"_");
		logger.trace("The forecast tool name array is : " + Arrays.toString(fcstSourceNameArray));
		// If the array size is greater than 2, get the third array value
		if (fcstSourceNameArray.length>2) {
			name = fcstSourceNameArray[2];
		}
	}
	catch(Exception e) {
    		logger.fatal("Could not parse the forecast source value to obtain the forecast cycle associated with the forecast source. Make sure that the forecast source is delimited with underscores.");
		Log.fatal("Problem parsing forecast cycle","#errorPanelText");
	}
    return name;
    }

	/**
	Returns the boolean value for the web flag. 'true' is returned if web services is initiating run-time, 'false' for not web services initiation.
	*/
	public boolean getWebFlag() {
		return webFlag;
	}
 
    /**
    Returns the time scale as a String. Determined by using the aveWindow and leadTime settings.
	@param String leadTime Lead time of forecast, formatted as a number followed by a character representing the time unit (ie.'08d','0pt5m')
	@param String aveWindow Average time window, formatted as a number followed by a character representing the time unit (ie.'05d','03m')
	@return String representing the time scale of the forecast
    */ 
    public String getTimescale(String leadTime, String aveWindow) throws Exception
    {
    	String timescale = null;
	String leadTimeFinal = null;
	logger.trace("Obtaining timescale (ie. for title string)");
    	// Use toStringArray method in FormatLibrary to parse forecast source name
	try {
		// Get numeric value of aveWindow and leadTime
		String leadTimeUnit=getLeadTimeUnit();
		double leadTimeNum=Double.parseDouble(getLeadTimeNumber());
		String aveWindowUnit=getAveWindowTimeUnit();
		double aveWindowNum=Double.parseDouble(getAveWindowNumber());
		// If aveWindow is '01d' set to 'Day $leadTime' ie. for leadTime 08d 'Day 8'
		if (aveWindowUnit.compareToIgnoreCase("d")==0 && aveWindowNum == 1.0){
			int decimal = (int)((leadTimeNum%1.0)*100);
			// If it is a whole number, format as integer
			if (decimal == 0) {
				int leadTimeInt = (int) leadTimeNum;
				leadTimeFinal = Integer.toString(leadTimeInt);
			}
			// Else leave as a double
			else {
				leadTimeFinal = Double.toString(leadTimeNum);
			}
			timescale="Day " + leadTimeFinal;
		}
		// Else if it is multiple days set as time range ie '6-10 Day'
		else if (leadTimeUnit.compareToIgnoreCase("d")==0 && aveWindowNum>1.0) {
			int leadTimeNumInt = (int) leadTimeNum;
			int aveWindowNumInt = (int) aveWindowNum;
			// Get first Day
			int day1 = leadTimeNumInt - (aveWindowNumInt/2);
			int day2 = leadTimeNumInt+ (aveWindowNumInt/2);
			timescale=day1 + "-" + day2 + " Day";
			logger.debug("day range is " + day1 + " to " + day2);
		}
		// If it is revised monthly, leadTimeUnit is 'M', leadTimeNum is 0.5, and aveWindowNum=01m
		else if (leadTimeNum==0.5 && leadTimeUnit.compareToIgnoreCase("m")==0 && aveWindowNum==1.0 && aveWindowUnit.compareToIgnoreCase("m")==0)  {
			double lead = leadTimeNum - 0.5;
			int decimal = (int)((lead%1.0)*100);
			// If it is a whole number, format as integer
			if (decimal == 0) {
				int leadTimeInt = (int) lead;
				leadTimeFinal = Integer.toString(leadTimeInt);
			}
			// Else leave as a double
			else {
				leadTimeFinal = Double.toString(lead);
			}
			timescale="Revised Monthly (Lead " + leadTimeFinal + ")";				
		} 
		// Else if it is a monthly forecast (not revised), leadTime >=1 and aveWindow=01m do 'Monthly (lead $Num)'
		else if (leadTimeNum>=1.0 && leadTimeUnit.compareToIgnoreCase("m")==0 && aveWindowNum==1.0 && aveWindowUnit.compareToIgnoreCase("m")==0) {
			double lead = leadTimeNum - 0.5;
			int decimal = (int)((lead%1.0)*100);
			// If it is a whole number, format as integer
			if (decimal == 0) {
				int leadTimeInt = (int) lead;
				leadTimeFinal = Integer.toString(leadTimeInt);
			}
			// Else leave as a double
			else {
				leadTimeFinal = Double.toString(lead);
			}	
			timescale="Monthly (Lead " + leadTimeFinal + ")";			
		}
		// Else if it is Seasonal ie. for lead time >=01m and aveWindow '03m'-> 'Seasonal (Lead 1.5 months)'
		// Lead calculated by subtracting 1.5 from lead.
		else if (leadTimeNum>=1.0 && leadTimeUnit.compareToIgnoreCase("m")==0 && aveWindowNum==3.0 && aveWindowUnit.compareToIgnoreCase("m")==0) {
			double lead = leadTimeNum - 1.5;
			int decimal = (int)((lead%1.0)*100);
			// If it is a whole number, format as integer
			if (decimal == 0) {
				int leadTimeInt = (int) lead;
				leadTimeFinal = Integer.toString(leadTimeInt);
			}
			// Else leave as a double
			else {
				leadTimeFinal = Double.toString(lead);
			}		
			timescale="Seasonal (Lead " + leadTimeFinal + " months)";
		}	
		// Else not a valid option of leadTime/aveWindow
		else {
			throw new Exception("Invalid options to create timescale label");
		}
	}
	catch(Exception e) {
    		logger.fatal("Could not return the timescale. Make sure the leadTime and aveWindow passed correctly." + e);
		Log.fatal("Problem building timescale label","#errorPanelText");
	}
    return timescale;
    }   
	///// End get methods

	/**
	Returns the value of any variable. The name of the variable is passed to this
	method, and the value of the variable with the associated name is returned.

	@param lookingForValue  The name of the desired variable
	*/
	public Object getValueOf(String lookingForValue) throws Exception {
		final Field[] fields = this.getClass().getDeclaredFields();
		Class classType;
		for (Field field : fields) {
			if (lookingForValue.equals(field.getName())) {
				classType = field.getType();
				if (classType.toString().equals("double")) {
					return field.getDouble(this);
				} else if (classType.toString().equals("int")) {
					return field.getInt(this);
				} else {
					return field.get(this);
				}
			}
		}
		return "";
	}
	
	//---------------------------------------------------------------
	// Set-methods
	//---------------------------------------------------------------

	

	/**
	Sets the name of the 5 required databases

	@param fcstDBName Forecast database name
	@param obsDBName  Observation database name
	@param climDBName Climatology database name
	@param refDBName  Reference database name
	@param VWTDBName  VWT database name
	*/
	public void setDBNames(String fcstDBName, String obsDBName, String climDBName, String refDBName, String VWTDBName)
	{
		this.fcstDBName = fcstDBName;
		this.obsDBName  = obsDBName;
		this.climDBName = climDBName;
		this.refDBName  = refDBName;
		this.VWTDBName  = VWTDBName;
		logger.debug("The names of the databases were just set to: " + fcstDBName + "," + obsDBName + "," + climDBName + "," + refDBName + "," + VWTDBName);
	}

    /**
    Sets the number of probability levels

    @param numProbLevels The number of probability levels
    */
	public void setNumProbLevels(int numProbLevels)
	{
		this.numProbLevels = numProbLevels;
	}

	/**
	Sets the variable

	@param str  The variable
	*/
	public void setVariable(String str) {
		variable = str;
	}

	/**
	Sets the forecast source

	@param str  The forecast source
	*/
	public void setFcstSources(String str) {
		fcstSources = str;
	}

	/**
	Sets the lead time

	@param str  The lead time
	*/
	public void setLeadTime(String str) {
		leadTime = str;
	}

	/**
	Sets the averaging window

	@param str  The averaging window
	*/
	public void setAveWindow(String str) {
		aveWindow = str;
	}

	/**
	Sets the ec type. If the EC type is set to "default" then this is done automatically depending
	on forecast type and score type. Otherwise the EC type is just set to the provided method argument.
	ECType affects what	QC is done. "noEC" means EC forecasts will not be verified and "withEC" means
	all forecasts, including EC, will be verified. ECType is set to "noEC" for short range because EC
	is not an option for short range. For long range forecasts it depends on score type. Brier scores are
    always set to "noEC", since it not possible to verify EC for Brier. The other scores are set
    to verify with EC. The stats class uses a list of long range forecast sources that contain
    EC forecasts and should be verified using EC fcsts (see getLongRangeEcFcstSourceListArray() below).
    Forecast sources not on the EC list are not verified using EC regardless of ECType. This is
    because forecasts of EC are below the skill mask and should not be verified.
	*/
	public void setECType(String ECType) {
		// If set to default, use logic to set it to either withEC or noEC, otherwise set to
		// the argument provided
		if (ECType.equals("default")) {
			// If this is an extendedRange forecast, don't use EC
			if (this.getLeadTimeUnit().compareToIgnoreCase("d")==0) {
				ECType="noEC";
			}
			// If this is a longRange forecast, we may use EC depending on scoreType
			else if (this.getLeadTimeUnit().compareToIgnoreCase("m")==0) {
				// If this is Brier, don't use EC
				if (this.getScoreType().equals("brier")) {
					ECType="noEC";
				}
				else {  // only for Brier
					ECType="withEC";
				}
			} 
			// Otherwise, just set to withEC
			else {
				ECType="withEC";
			}
		} 
		// Set the outer ECType to this method's calculated ECType
		this.ECType=ECType;
	}

        /**
        Sets the dry location correction 

        @param b  The dry location correction 
        */
        public void setDryLocationCorrection(boolean b) {
                dryLocationCorrection = b;
        }

	/**
	Sets the region type

	@param str  The region type
	*/
	public void setRegionType(String str) {
		regionType = str;
	}

	/**
	Sets the regions

	@param str  The regions
	*/
	public void setRegions(String str) {
		regions = str;
	}

    /**
    Sets the region array

    @param regionArray  String array of regions to verify for.
    */
	public void setRegionArray(String[] regionArray)
	{
		this.regionArray = regionArray;
	}

	/**
	Sets the spatial type

	@param str  The spatial type
	*/
	public void setSpatialType(String str) {
		spatialType = str;
	}

	/**
	Sets the output type

	@param str  The output type
	*/
	public void setOutputType(String str) {
		outputType = str;
	}

	/**
	Sets the output dimension. This is the dimension that the output represents.
	For example, space, time, or probability.
	@param str The output dimension
	*/
	public void setOutputDimension(String str) {
		outputDimension = str;
	}

	/**
	Sets the score type

	@param str  The score type
	*/
	public void setScoreType(String str) {
		scoreType = str;
	}

	/**
	Sets the category type

	@param str  The category type
	*/
	public void setCategoryType(String str) {
				categoryType = str;
	}	


    /**
    Sets the dates valid type

    @param datesValidType  The dates valid type
    */
	public void setDatesValidType(String datesValidType)
	{
		this.datesValidType = datesValidType;
	}

    /**
    Sets the datesValid. This is formatted with a dummy day ('15') in the case that a month and year is submitted for MySQL purposes used in the VWT.
    */
	public void setDatesValid(String datesValid)
	{
		this.datesValid = datesValid;
	}
	
	    /**
    Sets the dates valid of the original format which is comma and semi-colon delimited (in some cases) prior to the formatting done to datesValid to make it
    suitable for MySQL use.
    */
	public void setDatesValidOriginalFormat(String datesValid)
	{
		this.datesValidOriginalFormat = datesValid;
	}

	/**
	Sets the forecast source array

	@param str  The forecast source array
	*/
	public void setFcstSourceArray(String[] str) {
		fcstSourceArray = str;
	}

	/**
	Sets the Verification System home directory

	@param str  The Verification System home directory
	*/
	public void setHomeDir(String str) {
		homeDir = str;
	}

    /**
    Sets the settings method
    */
	public void setSettingsMethod(String settingsMethod)
	{
		this.settingsMethod = settingsMethod;
	}

    /**
    Sets the settings array
    */
	public void setSettingsArray(String[] settingsArray)
	{
		this.settingsArray = settingsArray;
	}


/**
Sets rference date string array
*/
	public void setDateStringArray(String[] referenceDateString) {
		dateStringArray = referenceDateString;
	}

	/**
	Sets the boolean value for the web flag. 'true' is returned if web services is initiating run-time, 'false' for not web services initiation.
	*/
	public void setWebFlag(boolean webFlag) {
		this.webFlag = webFlag;
	}

    ///// End set methods

	/**
	Print out all the settings
	*/
	public void printSettings() {
		// Using a level of TRACE here because if you call
		// this method, you always want this to print.
		logger.trace("---------------------------");
		logger.trace(" variable     | " + variable);
		logger.trace(" fcstSources  | " + fcstSources);
		logger.trace(" leadTime     | " + leadTime);
		logger.trace(" aveWindow    | " + aveWindow);
		logger.trace(" datesValidType | " + datesValidType);
		logger.trace(" datesValid | " + datesValid);
		logger.trace(" regionType   | " + regionType);
		logger.trace(" regions      | " + regions);
		logger.trace(" spatialType  | " + spatialType);
		logger.trace(" outputType   | " + outputType);
		logger.trace(" outputDimension | " + outputDimension);
		logger.trace(" scoreType    | " + scoreType);
		logger.trace(" categoryType | " + categoryType);
		logger.trace(" ECType | " + ECType);
		logger.trace("---------------------------");
	}

	/**
	Parses a String array of settings into separate variables.
	Assumes a very particular array containing settings at
	specific array indices. Also, sets the original dates valid settings that can be retrieved by calling Settings.getDatesValidOriginalFormat() which
	returns the dates valid setting in its form from the submitted settings which contains comma and semi-colon separated settings. This is done because
	within the Settings processing, these datesValid gets reformatted to have a dummy day ('15') in the situation of monthly and seasonal dates valid
	which is required by MySQL dates. The original non-dummy date format is needed for other reasons, such as for String formatting in output, and
	creating the file name.

	@param  array  String array of settings
	<p>
	The settings array contains the following information in the order that they are passed as arguments. Also included is the list of possible options. NOTE : Any changes to settings options by developers should be updated in the below information as well. Therefore the caveat for the associated lists of possible options is that it may not be up to date depending on whether the lists were updated according to any changes made to settings options. :
<ul>
<li> variable   -      Variable to perform verification for. (ie. temp, precip)
<li> fcstSources   -    List of forecast sources separated by commas. Logic downstream will separate these forecast sources appropriately. (ie. fcstSources = "manual, auto")
<li> leadTime     -    Time to the center of the valid period. Format is ${numSpan}${unit}, where ${numSpan} is the number representing the lead time according to the following ${unit} unit of time. ${unit} can have the values of characters "d" and "m", for days and months, respectively. (ie. "05d" is a lead time of 5 days)
<li> aveWindow   -     Width of valid period. Format is ${numSpan}${unit}, where ${numSpan} is the number of time units (according to type ${unit}) that the verification is over. ${unit} can have the values of characters "d" and "m", for days and months, respectively. (ie. "05d" is a valid period of 5 days)
<li> datesValidType - Type of way to filter the data to verify for. Current available ways to filter:<br>
<table border="1">
<th>
Filter method
</th>
<th>value of datesValidType
<tr>
	<td>Days in a range</td>
	<td>dateRange</td>
</tr>
<tr>
	<td>Select months for all years</td>
	<td>selectMonths</td>
</tr>
<tr>
	<td>Select months and select years</td>
	<td>selectMonthsYears</td>
</tr>
<tr>
	<td>Select seasonal climate signals (ie. ENSO) :</td>
	<td>selectSeasonalSignal</td>
</tr>
<tr>
	<td>Select monthly climate signals (ie. AO) :</td>
	<td>selectMonthlySignal</td>
</tr>
</table>
<li> datesValid - Formatted string of date information representing how to filter the data to verify for as specified by dateFilterRequestType. These dateValidRequest values applies to the valid date of forecast data. The format allows for multiple combined ways to filter.
The set within one type of filtering is comma delimited, the different sets of filtering
specifications are separated by a semi-colon.:
<table border="1">
<th>Verify forecasts valid for</th>
<th>value of datesValidType</th>
<th>value of datesValid</th>
<tr>
	<td>Days between 20090101 and 20090620</td>
	<td>dateRange</td>
	<td>20090101,20090620</td>
</tr>
<tr>
	<td>January and July months for all years:</td>
	<td>selectMonths</td>
	<td>01,07</td>
</tr>
<tr>
	<td>January and July months that are in the years 2000,2005,2010</td>
	<td>selectMonthsYears</td>
	<td>01,07;2000,2005,2010</td>
</tr>
</table>
<li> regionType  -     Type of regional division to use for verification calculations. ie. regional climate centers, states, stations, etc. (ie. Regional climate centers, states...)
<li> regions     -     Particular region(s) to perform verification for. (ie. Northeast, Midwest, New York, Maryland...)
<li> spatialType  -    Type of storage of each data point. The datasets of forecasts and/or observations are made up of different types of ways that the data represents. (ie. station, gridded, climate division, etc.)
<li> outputType   -    Method of displaying and/or producing output for a score. This is the representational format of the output data produced by the verification software. (ie. chart, map, table, etc.)
<li> outputDimension - Dimension that the output represents. It would be the reference dimension that each of the score values represent. Examples of outputput dimension:
<br>space - scores representing spatial points, ie. on a map
<br>time - scores representing dates, ie. on a timeseries chart
<br>probability - scores representing probability values, ie. reliability scores, where the scores represent an interval of probabilities of a forecast category
<li> scoreType    -    Type of verification score to calculate. (ie. heidke, RPSS, etc)
<li> categoryType  -   How to plot scores for the categories. (ie. all categories together or separately)
<li> ECType - Status of whether forecasts to be verified uses equal chances forecasts or not. (ie. "noEC" or "withEC"). An example of setting this to "withEC" would be for monthly and seasonal forecasts that have equal chances as a category. See setECType() method in this class
</ul>
	*/
	public void splitStringArray(String[] array) {
		variable		= array[0];
		fcstSources		= array[1];
		leadTime		= array[2];
		aveWindow		= array[3];
		datesValidType	= array[4];
		datesValid		= array[5];
		regionType		= array[6];
		regions			= array[7];
		spatialType		= array[8];
		outputType		= array[9];
		outputDimension	= array[10];
		scoreType		= array[11];
		categoryType	= array[12];
		ECType			= array[13];

		//-----------------------------------------------------------
		// Make any adjustments needed to the variables
		//-----------------------------------------------------------
		// Convert a few of the variables into String arrays if they
		// are expected to have multiple values (eg. fcstSources = ('manual','auto');
		setDatesValidOriginalFormat(datesValid);
		logger.debug("Setting the original format of valid dates. For datesValidType " + datesValidType + " datesValid is : " + datesValid);
		fcstSourceArray = FormatLibrary.stringToArray(fcstSources);
		logger.info("Finished splitting array!");
	}

	/**
	  Checks settings and displays a message for any invalid settings. This doesn't
	  validate all settings, because some settings will naturally be validated when
	  constructing a data table name and attempting to read from it. If the table
	  name doesn't exist, and error can be thrown, and a message can be displayed to
	  the user.
	  <br><br>
	  Please see {@link SettingsHashLibrary#getSettingsValidationHash getSettingsValidationHash} for the exact patterns
	  used to validate the settings.
	  <br><br>
	  Make sure end date is not less than 4 days ago for ERF.
	  Other date checks for Monthly and Seasonal.

	 */
	public void validateSettings () throws InvalidSettingException {
		String settingValue;
		String permittedValues;
		String errorString;
		int startDateValue = 0;
		int endDateValue = 0;
		// Retrieve a Hashmap of permitted settings values and error messages
		LinkedHashMap<String, String[]> settingsValidationHash = SettingsHashLibrary.getSettingsValidationHash(this);
		logger.info("Validating settings...");
		// Check all settings in the HashMap
		for (String setting : settingsValidationHash.keySet()) {
			// Get the value of this settings
			try {
				settingValue = getValueOf(setting).toString();
			} catch (Exception e) {
				throw new InvalidSettingException("There was a problem getting the value of the variable" + setting + ", ensure that it is declared public: " + e);
			}
			// See if the setting value is equal to one of the permitted values (uses regex)
			permittedValues = settingsValidationHash.get(setting)[0];
			errorString = settingsValidationHash.get(setting)[1];
			if (! settingValue.matches(permittedValues)) {
				Log.fatal(setting + " is set to '" + settingValue + "', which does not match the regex '" + permittedValues + "'. " + errorString, "#errorPanelText");
				logger.fatal(setting + " is set to '" + settingValue + "', which does not match the regex '" + permittedValues + "'. " + errorString);
				throw new InvalidSettingException(setting + " is set to '" + settingValue + "', which does not match the regex '" + permittedValues + "'. " + errorString);
			}
		}

		///////////////////////////////////////////////////
		// Customize format of variables here if needed
		///////////////////////////////////////////////////
		// If the dateRange is the format of date filtering provided, AND
		// it is a monthly forecast, append a dummy '15' day to the start and end dates, return dates with comma separating the first and second date
		// This is needed for date manipulation in the QCLibrary eventually and for Sql retrieval
		if((datesValidType.compareToIgnoreCase("dateRange") == 0) && (getLeadTimeUnit().compareToIgnoreCase("m") == 0)) {
			// Parse the dates valid into an array of 2 values, a start and end date
			String[] dates = FormatLibrary.toStringArray(datesValid,",");
			// Put back into format that is comma delimited to return a String 'YYYYmmdd,YYYYmmdd'
			datesValid = dates[0] + "15" + ","+ dates[1] + "15";
			logger.trace("Just added a dummy date of 15 to a 'YYYYmm,YYYYmm' formatted valid date range. A string of 'YYYYmm15,YYYYmm15' should be returned, where '15' is a dummy day assigned for code reasons.");
		}
		//////////////////////////////
		// VALIDATE DATE RANGE IF datesValidType = dateRange
		// Make sure that the start date is before the end date
		//////////////////////////////
		if (datesValidType.compareToIgnoreCase("dateRange") == 0) {
			String[] dates = FormatLibrary.toStringArray(datesValid,",");
			String startDate = dates[0];
			String endDate = dates[1];
			// Convert dates to integer for comparison
			try {
				startDateValue = Integer.parseInt(startDate);
				endDateValue = Integer.parseInt(endDate);
			}
			catch (Exception e) {
				logger.fatal("Unable to parse start and end dates into integers for validation");
				Log.fatal("Report inability to parse submitted dates for validation","#errorPanelText");
				throw new InvalidSettingException("Unable to parse start or end date for evaluation.");
			}
			// If start date is after end date, kill process
			if (startDateValue > endDateValue) {
					logger.fatal("Invalid start/end date. The end date must occur after the start date!");
					Log.fatal("Error: Start date selected is after end date date. Make sure the end date selected is after the start date", "#errorPanelText");
					throw new InvalidSettingException("Invalid start/end date. Start date must be before the end date.");
			}
		}
		//////////////////////////////
		// End dateRange Validation
		//////////////////////////////
	} // End validateSettings()

} // End Settings class
