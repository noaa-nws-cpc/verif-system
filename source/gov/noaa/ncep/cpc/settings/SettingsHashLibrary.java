package gov.noaa.ncep.cpc.settings;

import gov.noaa.ncep.cpc.qc.Log;
import gov.noaa.ncep.cpc.format.FormatLibrary;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;
/**
  Library of functions that return and contain hash arrays for needed settings. Example, returning the long name of a string settings for a shorter string. Purpose is to have all the hash arrays in one class and allow code to access these methods without needing a settings object to access these methods.
 */
public class SettingsHashLibrary {
	static Logger logger = Logger.getLogger(gov.noaa.ncep.cpc.settings.SettingsHashLibrary.class);

	/**
	Returns the Sql syntax date unit corresponding to a character or String in the leadTime specification of the time unit of lead. This is needed for the data package DateSql.java that creates date filters specific to the lead time and lead time units. For example, a user could use "08d" as the lead time value (leadTime) for the 8-14 day forecast. The convention is for the lead time to have a character representing the time units of the lead time specified. This means that 08 days is the lead time for the forecast being verified. "d" in this method is set to Sql time unit "DAY" by a hash value "put" command to be properly used in Sql. Current lead time units available are:<br>
	<ul>
	<li>"d" - "DAY"
	<li>"m" - "MONTH"
	</ul>
	If a developer edits this method to add another lead time unit, please include this Java API documentation bulleted list to include your update.
	@param timeUnit character representing the time unit that which MUST be 1 character long.
	*/
	public static String getSqlTimeUnit(String timeUnit) {
		String sqlTimeUnit = null;
		// Initialize variables
		HashMap<String, String> stringHash = new HashMap();
		// Populate the hashmap
		stringHash.put("d","DAY"); // day units
		stringHash.put("m","MONTH"); // month units
		// Return the sql value of the character if it exists
		if (stringHash.containsKey(timeUnit)) {
			return stringHash.get(timeUnit);
		} else {
			Log.error("Could not find an Sql syntax time unit for " + timeUnit, "#errorPanelText");
			logger.warn("Could not find an Sql syntax time unit for " + timeUnit);
			return sqlTimeUnit;
		}
	}

	/**
	Returns a String label for the reference data associated with the type of output dimension.
	Typically used in writing a header on an output file with output dimension (reference array) data.
	For example for output dimension time, returns "Date Valid".
	@return output dimension label
	*/
	public static String getReferenceDimensionLabel(String outputDimension) {
		HashMap<String, String> stringHash = new HashMap();
		stringHash.put("time","Date Valid");
		stringHash.put("space","id");
		stringHash.put("probability","Probability");
		if (stringHash.containsKey(outputDimension)) {
			return stringHash.get(outputDimension);
		} else {
			Log.error("Could not find a label for output dimension for " + outputDimension , "#errorPanelText");
			logger.warn("Could not find a label for output dimension for " + outputDimension);
			return outputDimension;
		}
	}

	/**
	Returns a String label for the number of good data points associated with the type of output dimension.
	Typically used in writing a header on an output file with output dimension (reference array) data.
	For example for output dimension time, returns "Num Valid Locations".
	@return Text label for number of valid points based on the passed output dimension. If invalid output dimension passed, output dimension returned instead.
	*/
	public static String getNumValidPointsLabel(String outputDimension) {
		HashMap<String, String> stringHash = new HashMap();
		stringHash.put("time","Num Valid Locations");
		stringHash.put("space","Num Valid Dates");
		stringHash.put("probability","Num Valid Forecasts");
		if (stringHash.containsKey(outputDimension)) {
			return stringHash.get(outputDimension);
		} else {
			Log.error("Could not find a label for output dimension for " + outputDimension , "#errorPanelText");
			logger.warn("Could not find a label for output dimension for " + outputDimension);
			return outputDimension;
		}
	}
	
		/**
	Returns a String label for the percent of "good" or valid scores.
	Typically used in writing a column header on an output file. Does not vary depending on output dimension.
	@return Text label associated with valid percent of data that went into a score on the
	passed output dimension. If invalid output dimension passed, output dimension returned instead.
	*/
	public static String getPerecentValidScoresLabel(String outputDimension) {
		String label = "Percent Valid Scores";
		HashMap<String, String> stringHash = new HashMap();
		stringHash.put("time","Percent Valid Locations");
		stringHash.put("space","Percent Valid Dates");
		if (stringHash.containsKey(outputDimension)) {
			return stringHash.get(outputDimension);
		} else {
			Log.error("Could not find a label for output dimension for " + outputDimension , "#errorPanelText");
			logger.warn("Could not find a label for output dimension for " + outputDimension + ". It should be noted that Reliability does not have a label because percent valid score is not a valid metric for relability.");
			return outputDimension;
		}
	}

	/**
	Returns the plain-english version of settings that can be used for displaying text associated
	with the settings. Some settings may not have an associated available display label since some probably not needed. If there is no hash array value for the setting desired, the original setting value passed is returned as the label name. The plain-english version of the settings are hard-wired as hash arrays in this method. Often the paired plain-english label is needed because the value is more than one word, not separated by spaces.
	<p> One way of getting the label version is by passing the value of the setting, if it is known, ie. settingsObj.getSettingsLabel("S"); Another way is using a get method in this class and then getting the associated label with that value, ie. settingsObj.getSettingsLabel(settingsObj.getVariable);
 	@param settingStr String of the setting value that you want to get the plain-english label for.
	@return String of plain-english version of the setting.
	*/
	public static String getSettingsLabel(String settingStr) {
		String getSettingsLabel;

		// Initialize variables
		HashMap<String, String> stringHash = new HashMap();
		// Populate the hashmap
		// Regions
		stringHash.put("Northeast","NE");
		stringHash.put("Southeast","SE");
		stringHash.put("Midwest","MW");
		stringHash.put("South","S");
		stringHash.put("High Plains","HP");
		stringHash.put("West","W");
		// variable
		stringHash.put("temp","Temperature");
		stringHash.put("precip","Precipitation");
		stringHash.put("tmax","Maximum Temperature");
		stringHash.put("tmin","Minimum Temperature");
		// Forecast source
		stringHash.put("autoblend","auto");
		// Region type
		stringHash.put("climate region","climateRegion");
		// Spatial Type
		stringHash.put("climate division","climateDivision");//climate division
        // Try to split the setting to retrieve the first piece delimited by a '-' if it exists in the name
        settingStr = settingStr.split("-")[0];
        logger.trace("Variable label is : " + stringHash.get(settingStr));
		// Forecast Type (timescale)
		// See Settings.getTimescale()
		// Category Label 
		// See getCategoryLabel() in this method
		// Return the label if it exists
		if (stringHash.containsKey(settingStr)) {
			return stringHash.get(settingStr);
		} else {
			Log.error("Could not find a Settings Label for " + settingStr + ".", "#errorPanelText");
			logger.warn("Could not find a Settings Label for " + settingStr + "." + " There may be another method to retrieve this label.");
			return settingStr;
		}
	}
        /** 
        Returns an array of internally used category names corresponding to the categories in the score array, including
	total, in the same order as in the score array. These are used by the back-end code but not necessarily displayed in the output. 
        @return String array of category names associated with all of the categories including total.
        */
        public static String[] getCategoryNames() {
		String[] categoryNames = new String[4];
		categoryNames[0] = "total";
		categoryNames[1] = "B";
		categoryNames[2] = "N";
		categoryNames[3] = "A";
		return categoryNames;
        }


	/**
	Returns an array of possible units that can be used to obtain ie. category labels. These are currently assumed to represent extremes and may therefore impact logic suh as how the favored category is selected in Data.java. These may be used to determine if an extreme is being processed.
	@return Array of allowable category units, typically used for labeling what the 3-category structure of data would be assigned.
	*/
	public static String[] getPossibleCategoryUnitsArray() {
		String[] categoryUnits = new String[5];
		categoryUnits[0]= "DegF";
		categoryUnits[1]="DegC";
		categoryUnits[2]="Ptile";
		categoryUnits[3]="mm";
		categoryUnits[4]="in";
		return categoryUnits;
	}

    /**
    Returns a pipe delimited list of possible category units that can be used for a regex command. These are obtained from the list in getPOssibleCategoryUnitsArray(). These may be used to determine if an extreme is being processed.
    @return Pipe delimited list of allowable category units.
    */
    public static String getPossibleCategoryUnitsList() {
		// Get list of possible units
		String[] possibleCategoryUnits = getPossibleCategoryUnitsArray();
		String possibleCategoryUnitsList="";
		// Build the array into a string separate by pipes for the regex
		for (int i=0; i<possibleCategoryUnits.length; i++) {
			if (i==0) {
				possibleCategoryUnitsList = possibleCategoryUnits[i];
			}
			else {
				possibleCategoryUnitsList = possibleCategoryUnitsList + "|" + possibleCategoryUnits[i];
			}
		}
		logger.trace("category units list is : " + possibleCategoryUnitsList);
        return possibleCategoryUnitsList;
    }

    /**
    Returns a 1-D array containing the 2 thresholds associated with the forecast categories. 
    @param variable Variable from the settings object    
    @return 1-D array containing the 2 thresholds associated with the forecast categories. The first (0th) array index is the lower category threshold, and the second is the upper.
    */
    public static String[] getCategoryThresholds(String variable) throws Exception {
		Pattern pattern;
		Matcher matcher;
		String[] thresholds = new String[2]; 
		// Try to create category labels based off of the variable
		try {
			// Get the category label unit
			// Get percentile from the variable
            String possibleCategoryUnitsList = getPossibleCategoryUnitsList();
            String regex = ".*(" + possibleCategoryUnitsList + ")-([0-9pt]+)-and-([0-9pt]+).*";
            logger.trace("regex is " + regex);
			pattern = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
			matcher = pattern.matcher(variable);
			matcher.find();
            variable = matcher.group(1);
			// If there is a valid threshold unit found for categories in the variable
			if (matcher.matches() == true) {
				logger.trace("Getting category thresholds from the variable name.");
				thresholds[0] = matcher.group(2);
				thresholds[1] = matcher.group(3);
                logger.trace("Thresholds are : " + thresholds[0] +  " and " + thresholds[1]);
            }
            else throw new Exception("Couldn't get the thresholds associated with variable " + variable);
        } catch(Exception e) {
				logger.fatal("Couldn't get the thresholds associated with variable " + variable);
				throw e;
		}
        return thresholds;
    }

    /** 
    Returns boolean of whether the forecast being processed is even terciles (with even probabilities for each category).
    @param String variable
    @return boolean value, True if the variable being processed is even terciles, False if not.
    */
    public static boolean isEvenTerciles(String variable) {
        boolean isEvenTerciles = true; // Default set to True
		Pattern pattern;
		Matcher matcher;
		// Get the category label unit
        String possibleCategoryUnitsList = getPossibleCategoryUnitsList();
        String regex = ".*(" + possibleCategoryUnitsList + ")-([0-9pt]+)-and-([0-9pt]+).*";
        logger.trace("regex is " + regex);
        pattern = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
        matcher = pattern.matcher(variable);
        matcher.find();
        if (matcher.matches() == true) {
            isEvenTerciles = false;
        }
        return isEvenTerciles;
    }

	/**
	Returns the appropriate category label. Not the same as category type which is currently still constrained in the internal code to be either 'B','N', or 'A'. These labels would be associated with these 3 category types and would display in output. These should not be too long, since they are also used for column headers in the ASCII output.
	@param category Category type from the settings object
	@param variable Name of variable used (e.g. tmax-ptile-15-and-85). This is used to retrieve the percentile or full field value to build the label.
	@return A category label with details about thresholds assigned to the categories (if it is not symmetric terciles)
	*/
	public static String getCategoryLabel(String category, String variable) {
		Pattern pattern;
		Matcher matcher;
	
		// Initialize variables
		HashMap<String, String> stringHash = new HashMap();
		// Get list of possible units
		String[] possibleCategoryUnits = getPossibleCategoryUnitsArray();
		String possibleCategoryUnitsList="";
		// Build the array into a string separate by pipes for the regex
		for (int i=0; i<possibleCategoryUnits.length; i++) {
			if (i==0) {
				possibleCategoryUnitsList = possibleCategoryUnits[i];
			}
			else {
				possibleCategoryUnitsList = possibleCategoryUnitsList + "|" + possibleCategoryUnits[i];
			}
		}
		logger.trace("category units list is : " + possibleCategoryUnitsList);

		// Try to create category labels based off of the variable
		try {
			// Get the category label unit
			// Get percentile from the variable
            String regex = ".*(" + possibleCategoryUnitsList + ")-([0-9pt]+)-and-([0-9pt]+).*";
            logger.trace("regex is " + regex);
			pattern = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
			matcher = pattern.matcher(variable);
			matcher.find();
			logger.trace("Variable: " + variable);
			// If there is a valid threshold unit found for categories in the variable
			if (matcher.matches() == true) {
				logger.trace("Getting category labels for non-symmetric terciles");
				logger.trace("regex1 - " + matcher.group(1));
				logger.trace("regex2 - " + matcher.group(2));
				logger.trace("regex3 - " + matcher.group(3));
				String val1Str = matcher.group(2);
				String val2Str = matcher.group(3);
				String valUnit = matcher.group(1);
				// Replace all instances of 'pt' with a decimal value
				String val1 = val1Str.replaceAll("pt",".");
				String val2 = val2Str.replaceAll("pt",".");

				// If 'Ptile' found (percentile) format labels with ordinal suffixes
				if (valUnit.compareToIgnoreCase("ptile") == 0) {
					logger.trace("Creating labels for percentile categories");
					String val1Suffix = FormatLibrary.getOrdinalFor(Double.parseDouble(val1));
					String val2Suffix = FormatLibrary.getOrdinalFor(Double.parseDouble(val2));
					stringHash.put("total","Combined Categories");
					stringHash.put("B","<" + val1 + val1Suffix + " " + valUnit);
					stringHash.put("N",val1 + val1Suffix + "-" + val2 + val2Suffix + " " + valUnit);
					stringHash.put("A",">" + val2 + val2Suffix + " " + valUnit);
					stringHash.put("separate","Separate Categories");
				}
				// Else just use unit
				else {
					logger.trace("Creating labels for non-symmetric tercile categories (non-percentile)");
					stringHash.put("total","Combined Categories");
					stringHash.put("B","<" + val1 + " " + valUnit);
					stringHash.put("N",val1 + "-" + val2 + " " + valUnit);
					stringHash.put("A",">" + val2 + " " + valUnit);
					stringHash.put("separate","Separate Categories");
				}
			}
			// Else assume symmetric terciles (ie. 33.3% percentiles defining each of the 3 categories)
			else {
				logger.trace("Creating labels for symmetric tercile categories.");
				stringHash.put("total","Combined Categories");
				stringHash.put("B","B");
				stringHash.put("N","N");
				stringHash.put("A","A");
				stringHash.put("separate","Separate Categories");
			}
		}
		catch (Exception e) {
			logger.fatal("Could not create category labels from the forecast source: " + e);
		}
		if (stringHash.containsKey(category)) {
			return stringHash.get(category);
		} else {
			Log.error("Could not create a label for category " + category , "#errorPanelText");
			logger.warn("Could not create a label for category " + category + " for variable " + variable + ".");
			return category;
		}
	}

/**
	Returns the appropriate generic category label, less detailed than getCategoryLabel(). Creates one type of label based on the variable name to provide a label. Not the same as category type which is currently still constrained in the internal code to be either 'B','N', or 'A'. These labels would be associated with these 3 category types and would display in output. If the variable name contains non-symmetric tercile categories (one of the values set in getPossibleCategoryUnitsArray() then the categories are referenced as 'combined categories' (category type 'total'), 'lower category' ('B'),'middle' ('N'),'upper' ('A'), 'separate categories' ('separate')). For symmetric terciles (no forecast source containing an option from getPossibleCategoryUnitsArray()), B,N,A is used in labels.  
	@param category Category type from the settings object
	@param variable String variable name
	@return A generic category label associated with category type
	*/
	public static String getGenericCategoryLabel(String category,String variable) {
		Pattern pattern;
		Matcher matcher;
		boolean hasSymmetricTercile = true;
		// Initialize variables
		HashMap<String, String> stringHash = new HashMap();
		// Get list of possible units
		String[] possibleCategoryUnits = getPossibleCategoryUnitsArray();
		String possibleCategoryUnitsList="";
        logger.info("Getting the generic cateogory label");
		// Build the array into a string separate by pipes for the regex
		for (int i=0; i<possibleCategoryUnits.length; i++) {
			if (i==0) {
				possibleCategoryUnitsList = possibleCategoryUnits[i];
			}
			else {
				possibleCategoryUnitsList = possibleCategoryUnitsList + "|" + possibleCategoryUnits[i];
			}
		}
		logger.trace("category units list is : " + possibleCategoryUnitsList);

		// check if the variable has any match one of the non-symmetric units
		// By default, hasSymmetricTercile is set to true. 
		
		logger.trace("variable = " + variable);
		// Get the category label unit
		// Get percentile from the variable

        String regex = ".*(" + possibleCategoryUnitsList + ")-([0-9pt]+)-and-([0-9pt]+).*";
        logger.trace("regex is " + regex);
		pattern = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
		matcher = pattern.matcher(variable);
		matcher.find();
		// If there is a valid threshold unit found for categories in the variable name
		if (matcher.matches() == true) {
			hasSymmetricTercile = false;
		}
		
		logger.trace("hasSymmetricTercile : " + hasSymmetricTercile);
		//  determine what label to assign
		if (hasSymmetricTercile == true) {
			logger.trace("Creating category labels for symmetric terciles.");
			stringHash.put("total","Combined Categories");
			stringHash.put("B","Below Normal Category");
			stringHash.put("N","Normal Category");
			stringHash.put("A","Above Normal Category");
			stringHash.put("separate","Separate Categories");
		}
		else {
			logger.trace("Creating category labels for asymmetric terciles.");
			stringHash.put("total","Combined Categories");
			stringHash.put("B","Lower Category");
			stringHash.put("N","Middle Category");
			stringHash.put("A","Upper Category");
			stringHash.put("separate","Separate Categories");
		}
		if (stringHash.containsKey(category)) {
			return stringHash.get(category);
		} else {
			Log.error("Could not find a generic label for category for " + category , "#errorPanelText");
			logger.warn("Could not find a generic label for category " + category + ".");
			return category;
		}
		
	} // End getGenericCategoryLabel()

	/**
	comma-delimited list of the index(ces) used in data arrays in the software used to store data associated with a specific category type.
	Argument passed should be the character string representation used to represent a category type in the settings file to use during run-time,
	such as 'separate', 'total', 'B', 'N', or 'A'. Data/score arrays are typically indexed as [total][Below][Normal][Above] in the category dimension.
	Each run-time processes all of these types of categories, it is up to post-statistics calculation to grab the correct data, either to create
	an ASCII file, chart, map, etc. This can be used to access an appropriate dimension of score array associated with the type of category. For
	'separate' - below, normal, and above indices of the score arrays would be accessed. Therefore the value returned for 'separate' would be
	a comma-delimited string of the separate indices. Usage of this information would require parsing this array (in case the category is separate)
	and looping over the indices representing the separate categories (ie. index 1,2, and 3). Usage of this method would also require converting the
	string value returned as an integer value to use in accessing the score arrays.
	@param categoryType category type associated with the settings option
	@return Integer representing the appropriate index used in the category dimension of score arrays for the passed settings category type.
	*/
	public static String getCategoryIndex(String categoryType) {

		HashMap<String, String> stringHash = new HashMap();

		stringHash.put("separate","1,2,3");
		stringHash.put("total","0");
		stringHash.put("B","1");
		stringHash.put("N","2");
		stringHash.put("A","3");

		if (stringHash.containsKey(categoryType)) {
			return stringHash.get(categoryType);
		} else {
			Log.error("Could not find an associated score array index for category type for " + categoryType , "#errorPanelText");
			logger.warn("Could not find an associated score array index for category type for " + categoryType);
			return categoryType;
		}
	}

	/**
	Returns a LinkedHashMap (which keeps the items in the same order they are
	inserted...important for validating settings in the right order) containing
	settings (as keys) and a String array containing the permitted values of that
	settings, and the error message to display in the case that the setting does
	not conform. You must pass the Settings object to this method because the
	permitted values of some settings depend on the value of other settings.
	<br><br>
	The 1st index of the HashMap value is a RegEx Strings that can be used to
	compare the settings with in order to determine if the provided setting is
	permitted. For example, use the string "option1|option2|option3" to allow
	specifically one of several options, or "\d{6}" to allow a 6 digit date.
	<br><br>
	The 2nd index of the returned HashMap is a String error message to display
	if the setting doesn't validate successfully. If you feel that the thrown
	exception has enough information, then set it to an empty string. For example,
	for a leadTimeUnit of "d", the provided date should include the day in the
	datesValid String. When this is the case, provide an error message to the
	user saying so.
	<br><br>
	<i>Remember to escape the backslashes used in the regex String (eg. "\\d{8}",
	not "\d{8}"), since Java tries to convert the \x character into some other
	escape character.</i>
	<br><br>
	<b>NOTE : </b>The following settings can be naturally validated by determining if the database table exists (these variables are included in the database table name; if the constructed table name does not exist in the database, error thrown). If not, an error can be thrown.
	<ul>
	<li>variable
	<li>fcstSources
	<li>leadTime
	<li>aveWindow
	<li>spatialType
	</ul>

	@param  settingsObj             Settings object containing settings to be validated
	@return settingsValidationHash  LinkedHashMap containing permitted value regex and an error message
	*/
	public static LinkedHashMap<String, String[]> getSettingsValidationHash(Settings settingsObj) {
		LinkedHashMap<String, String[]> settingsValidationHash = new LinkedHashMap();
		// The following settings can be naturally validated by determining if the
		// database table exists. If not, an error can be thrown.
		// variable, fcstSources, leadTime, aveWindow, spatialType
		//
		//-----------------------------------------------------------
		// datesValidType
		//
		settingsValidationHash.put("datesValidType", new String[] {"dateRange|selectMonths|selectMonthsYears|selectSeasonalSignal|selectMonthlySignal",""});
		//-----------------------------------------------------------
		// datesValid
		//
		// For extendedRange data, date should include the day
		//
		if (settingsObj.getDatesValidType().equals("dateRange")) {
			if (settingsObj.getLeadTimeUnit().equals("d")) {
				settingsValidationHash.put("datesValid", new String[] {"\\d{8},\\s*\\d{8}","You chose a fcstType that requires a day in the datesValid variable."});
			} else if (settingsObj.getLeadTimeUnit().equals("m")) {
				settingsValidationHash.put("datesValid", new String[] {"\\d{6},\\s*\\d{6}","You chose a fcstType that doesn't require a day in the datesValid variable."});
			}
		}
		else if (settingsObj.getDatesValidType().equals("selectMonths")) {

		}
		else if (settingsObj.getDatesValidType().equals("selectMonthsYears")) {

		}
		else if (settingsObj.getDatesValidType().equals("selectSeasonalSignal")) {

		}
		else if (settingsObj.getDatesValidType().equals("selectMonthlySignal")) {
		
		}
		else {
			settingsValidationHash.put("datesValid", new String[] {"",""});
		}
		//-----------------------------------------------------------
		// regionType
		//
		settingsValidationHash.put("regionType",new String[] {"climateRegion|climateDivision|state",""});
		//-----------------------------------------------------------
		// regions
		//
		// For climateDivision data, regions must be numbers
		//
		if (settingsObj.getRegionType().equals("climateDivision")) {
			settingsValidationHash.put("regions",new String[] {"(\\d+)(,\\s*\\d+)*|(?i)all","You chose a regionType that requires a list of numbered regions."});
		} else {
			settingsValidationHash.put("regions",new String[] {"([a-zA-Z]+)(,\\s*[a-zA-Z]+)*|(?i)all","You chose a regionType that requires a list of 1-3 character regions."});
		}
		//-----------------------------------------------------------
		// outputType
		//
		// If scoreType is reliability, then don't allow a map
		if (settingsObj.getScoreType().compareToIgnoreCase("reliability")==0) {
			settingsValidationHash.put("outputType",new String[] {"chart|ascii",""});
		} else {
			settingsValidationHash.put("outputType",new String[] {"chart|map|ascii",""});
		}
		//-----------------------------------------------------------
		// outputDimension
		//
		// If scoreType is reliability, only allow probability, otherwise everything else
		if (settingsObj.getScoreType().compareToIgnoreCase("reliability")==0) {
			settingsValidationHash.put("outputDimension",new String[] {"probability","You chose a scoreType that only supports an outputDimension of probability."});
		} else {
			settingsValidationHash.put("outputDimension",new String[] {"time|space",""});
		}

		//-----------------------------------------------------------
		// scoreType
		//
		// If the user chose outputType=map, scoreType can't be reliability
		//
		if (settingsObj.getOutputType().equals("map")) {
			settingsValidationHash.put("scoreType",new String[] {"brier|heidke|rpss","You chose an outputType that only supports scoreTypes of brier, heidke, or rpss"});
		} else {
			settingsValidationHash.put("scoreType",new String[] {"brier|heidke|rpss|reliability",""});
		}
		//-----------------------------------------------------------
		// categoryType
		//
		// If RPSS, only allow total, otherwise allow all
		if (settingsObj.getScoreType().compareToIgnoreCase("rpss")==0) {
			settingsValidationHash.put("categoryType",new String[] {"total","You chose a scoreType that only supports a categoryType of total"});
		} else {
			settingsValidationHash.put("categoryType",new String[] {"B|N|A|total|separate",""});
		}
		//-----------------------------------------------------------
		// ECType
		//
		// If extendedRange, set to noEC
		if (settingsObj.getLeadTimeUnit().compareToIgnoreCase("d")==0) {
			settingsValidationHash.put("ECType",new String[] {"noEC|default","For extended range forecasts, EC Type must be \"noEC\" or, if you're unsure, \"default\" (which will automatically be set to the correct EC Type)"});
		}
		// If longRange, EC Type depends on scoreType
		else if (settingsObj.getLeadTimeUnit().compareToIgnoreCase("m")==0) {
			// If this is Brier, don't use EC
			if (settingsObj.getScoreType().equals("brier")) {
				settingsValidationHash.put("ECType",new String[] {"noEC|default","For Brier scores, EC Type must be \"noEC\" or, if you're unsure, \"default\" (which will automatically be set to the correct EC Type)"});
			}
			// Otherwise it can be either withEC or noEC (or default)
			else {
				settingsValidationHash.put("ECType",new String[] {"withEC|noEC|default","EC Type must be either \"withEC\", \"noEC\", or if you're unsure, \"default\" (which will automatically be set to the correct EC Type)"});
			}
		}

		return settingsValidationHash;
	} // end getSettingsValidationHash()

	/**
	Returns a string representing the part of the database table name of the spatial type.
	This method is typically called by a method that builds the name(s) of tables to query from.
	The hash values in this method must match appropriate table names in the active database(s) being used. The Sql.java source code in the data package should have methods of creating table names that build table names with the set values in this method properly.
	<p>
	For example, for spatial type passed, "station", the string "stn" would be returned, that
	is the string part of the table name for stations. This piece now would be concatenated to
	other pieces of a string to make the word by Sql.java methods to build var1+var2+"str" as
	the name of the table needed.
	<p>
	@param spatialType Type of spatial format used in input data.
	@return string used to build the name of a database table for a specific spatial type.
	*/
	public static String getSpatialTypeTableName(String spatialType) throws Exception {
		// Initialize variables
		HashMap<String, String> stringHash = new HashMap();

		// Populate hashmap
		// hash info : spatialType, string for table name piece
		stringHash.put("station","stn"); // station
		stringHash.put("gridded","grid2deg"); // gridded
		stringHash.put("climateDivision","cd"); // climate division
// 		Log.fatal("Spatial type: " + spatialType, "#errorPanelText");

		// Return the piece of the table name, if it exists
		if (stringHash.containsKey(spatialType)) {
			return stringHash.get(spatialType);
		} else {
			Log.fatal("Could not find a table name for a spatialType of " + spatialType + ".", "#errorPanelText");
			logger.fatal("Could not find a table name for a spatialType of " + spatialType + ".");
			throw new Exception("Could not find a table name for a spatialType of " + spatialType + ".");
		}
	}

	/**
	Returns the name of the database table containing reference data to filter forecast and observation data for. The table name returned is based on the passed datesValidType. This is used by the Data class if a reference table is needed to filter results to calculate verification for.
	@param datesValidType Type of dates to calculate verification for.
	@return Name of database table containing reference data associated with the passed datesValidType.
	*/
	public static String getSignalTableName(String datesValidType) {
	// hash map of variables
		HashMap<String, String> stringHash = new HashMap();
		stringHash.put("selectSeasonalSignal","climatePhenomena_seasonal");
		stringHash.put("selectMonthlySignal","climatePhenomena_monthly");
		if (stringHash.containsKey(datesValidType)) {
			return stringHash.get(datesValidType);
		} else {
			Log.fatal("Could not find a database table name for dates valid type " + datesValidType , "#errorPanelText");
			logger.fatal("Could not find a database table name for dates valid type " + datesValidType);
			System.exit(0);
			return stringHash.get(datesValidType);
		}
	}



}
