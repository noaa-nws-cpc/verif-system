package gov.noaa.ncep.cpc.applets;

import gov.noaa.ncep.cpc.format.Format;
import gov.noaa.ncep.cpc.format.FormatHTMLLibrary;
import gov.noaa.ncep.cpc.format.FormatLibrary;
import gov.noaa.ncep.cpc.format.IconMap;
import gov.noaa.ncep.cpc.format.ReadFileToString;
import gov.noaa.ncep.cpc.qc.Log;
import gov.noaa.ncep.cpc.services.Results;
import gov.noaa.ncep.cpc.services.ServiceCallThread;
import gov.noaa.ncep.cpc.settings.Settings;
import gov.noaa.ncep.cpc.stats.StatsLibrary;

import java.io.File;
import java.net.URL;
import java.util.Arrays;

import javax.swing.JApplet;

import netscape.javascript.JSObject;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

/**
Applet that calls the appropriate backend code to perform verification.
This score(s) is calculated by the VerificationDriver class as well as
other functions, and is passed back to the applet.
*/
public class SpatialApplet extends JApplet {
	//-----------------------------------------------------
	// Initialize all variables
	//-----------------------------------------------------
	static protected JApplet currentApplet = null; // Current Applet
	static public String xmlString;               // XML string containing score
	static public String legendInfoString;        // Legend string
	static String home = null;                    // Home directory of Verification System
	static String htmlString;                     // HTML code to display on the info panel
	static protected Logger logger;               // log4j Logger
	JSObject window;                       // JSObject containing the window
	static Settings settingsObj;                  // Settings object
  	static Results resultsObj;
  	static JSObject googleEarthClass; // Google Earth Javascript object

  ServiceCallThread serviceCallThread = null;
  
	// Initialize the run() method flag. This flag is changed to 1 after the
	// Save chart as image button is displayed for the first time.
	static int runFlag = 0;

	/**
	Default constructor. Gets a reference to the current applet.
	*/
	public SpatialApplet() {
		currentApplet = this;
	}

	/**
	Creates a database connection to be used throughout the VWT's
	existence in the Java Virtual Machine.
	*/
	public void init()
	{
		//-------------------------------------------------
		// Set up the logger
		//-------------------------------------------------
		// Set up configuration file
		String configFile = "/input/logConfigApplet.txt";
		// Get the URL version of the file
		URL url = SpatialApplet.class.getResource(configFile);
		// Configure the logger
		PropertyConfigurator.configure(url);
		// Get the new logger
		logger = Logger.getLogger(SpatialApplet.class.getName());
		//JSObject window = JSObject.getWindow(this);
		// Get the window for calling Javascript later
		window = JSObject.getWindow(this);
		// Pass window object to the Log.java class for web logging.
		// This is a required step.
		Log.setJSObject(window);
		// Initialize Google Earth JS object
		logger.info("Making a Google Earth object...");
		try {
			googleEarthClass = (JSObject) window.getMember("GoogleEarth");
			logger.info("Google Earth JSObject is " + googleEarthClass);
		} catch (Exception e) {
			logger.fatal("Cannot retrieve the GoogleEarth class: " + e);
			Log.fatal("Cannot display results. If you are using a Mac OS, try using Safari instead of Firefox. Otherwise, try using the chart format for results by selecting the \"Chart\" tab. ", "#errorPanelText");
		}
		// Empty content in the messaging panel for a new run
		Log.empty("#errorPanelText");
		logger.trace("Just the web GUI log panel in init()");
		
    //
    // "Note:  JavaScript code is treated like unsigned code. When a signed applet is accessed from
    //  JavaScript code in an HTML page, the applet is executed within the security sandbox. This implies
    //  that the signed applet essentially behaves likes an unsigned applet."
    //
    // The ServiceCallThread is started here because the thread will then be able to do queries outside
    // the security sandbox when the applet is signed.
    //
    //
    serviceCallThread = new ServiceCallThread();
    serviceCallThread.start();

	} // End init()

	/**
	* Overloaded method that performs all necessary functions for updated settings options. This method performs the following functions in order:
	1) creates a VerificationDriver object
	2) Verification object performs multiple functions to set a score String based on the passed settings
	3) Call get method of verification object to obtain the score string that is XML formatted for a spatial map
	4) Get the String array of icons for the legend
	5) Get the float array of threshold values for the legend
	6) Convert float array of threshold values to a String array of range values ("-20 to \n 0")
	7) Convert the two arrays to a combined String. Each array separated by a semi-colon, items within comma delimited
	8) Convert score XML and legend information to objects to pass to Javascript methods
	8) If the JSObject "window" is not null, try to call Javascript methods to plot the XML formatted score data and legend, passing any objects with necessary information (score data and legend information)
	<p>
	@param variable Variable to perform verification for. (ie. temp, precip...)
	@param fcstSource List of forecast sources separated by commas. Logic downstream will separate these forecast sources appropriately. (ie. fcstSource = "off, auto")
	@param leadTime Time to the center of the valid period. Format is ${numSpan}${unit}, where ${numSpan} is the number representing the lead time according to the following ${unit} unit of time. ${unit} can have the values of characters "d" and "m", for days and months, respectively. (ie. "05d" is a lead time of 5 days)
	@param aveWindow Width of valid period. Format is ${numSpan}${unit}, where ${numSpan} is the number of time units (according to type ${unit}) that the verification is over. ${unit} can have the values of characters "d" and "m", for days and months, respectively. (ie. "05d" is a valid period of 5 days)
	@param datesValidType Type of way to filter the data to verify for. Current available ways to filter:<br>
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
</table>
	@param datesValid Formatted string of date information representing how to filter the data to verify for as specified by dateFilterRequestType. These dateValidRequest values applies to the valid date of forecast data. The format allows for multiple combined ways to filter.
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
</table>	@param regionType Type of regional division to use for verification calculations. ie. regional climate centers, states, stations, etc. (ie. Regional climate centers, states...)
	@param regions Particular region(s) to perform verification for. (ie. Northeast, Midwest, New York, Maryland...)
	@param spatialType Type of storage of each data point. The datasets of forecasts and/or observations are made up of different types of ways that the data represents. (ie. station, gridded, climate division, etc.)
	@param outputType Method of displaying and/or producing output for a score. This is the representational format of the output data produced by the verification software. (ie. chart, spatial map, table, etc.)
	@param outputDimension - Dimension that the output represents. It would be the reference dimension that each of the score values represent. Examples of outputput dimension:
<br>space - scores representing spatial points, ie. on a map
<br>time - scores representing dates, ie. on a timeseries chart
<br>probability - scores representing probability values, ie. reliability scores, where the scores represent an interval of probabilities of a forecast category
	@param scoreType Type of verification score to calculate. (ie. heidke, RPSS, etc)
	@param categoryType The categories to verify. (ie. all together or separate)
	@param ECType Status of whether forecasts to be verified uses equal chances forecasts or not. (ie. "noEC" or "withEC").

	@return success  Success code (1 for successful score calculation and plotting, 0 for non-successful)
	*/
	public int update(String variable, String fcstSource, String leadTime, String aveWindow, String datesValidType, String datesValid, String regionType, String regions, String spatialType, String outputType, String outputDimension, String scoreType, String categoryType, String ECType) throws Exception {
		// Empty content in the messaging panel for a new run
		Log.empty("#errorPanelText");
		logger.debug("Just EMPTIED IN init()");
		String[] settingsArray = {variable, fcstSource, leadTime, aveWindow, datesValidType, datesValid, regionType, regions, spatialType, outputType, outputDimension, scoreType, categoryType, ECType};
		String[] rangeArray;

    //
    // This call will request the serviceCallThread to query the data through
    // the web service. The call will cause the calling thread to wait until it is interrupted or
    // a result is retuned.
    //
    Results resultsObj = serviceCallThread.doQuery(settingsArray);
    
    if (resultsObj == null || resultsObj.getResultType() == Results.RESULT_TYPE_ERROR)
    {
      logger.fatal("Can not run the driver for settings: " + Arrays.toString(settingsArray));
      if (resultsObj != null)
      {
        logger.fatal("Results failed with this error message: " + resultsObj.getErrorMessage());
		Log.fatal(resultsObj.getErrorMessage(),"#errorPanelText");
		// Clear the map and legend
		logger.debug("Clearing the map...");
		googleEarthClass.call("clearMap",null);
		googleEarthClass.call("removeGoogleEarthLegend",null);
		return 0;
      }
      // Clear the map and legend
      logger.debug("Clearing the map...");
	  googleEarthClass.call("clearMap",null);
	  googleEarthClass.call("removeGoogleEarthLegend",null);
      return 0;
    }
    

    settingsObj = new Settings(settingsArray);
    
		// Get the XML string of stats formatted for display from the driver
    xmlString = Format.getFormattedData(resultsObj, settingsObj);
		// Print out returned string
		logger.info("xmlString = " + xmlString);
		// Get the icon array for the legend information
		String[] iconArray = IconMap.getIconArray(scoreType);
// 		logger.debug("Icon array is : " + Arrays.toString(iconArray) + " For score Type : " + scoreType);
		// Get the threshold array for legend information
		float[] thresholdArray = IconMap.getLegendThresholdArray(scoreType);
		//String[] thresholdArrayString = Arrays.toString(thresholdArray);
		logger.debug("Threshold array is : " + Arrays.toString(thresholdArray));
		// Create objects from icon and threshold arrays
		Object[] iconObj = {iconArray};
		Object[] thresholdObj = {thresholdArray};
		//Object[] argsObj = {iconArray, thresholdArray};

		// Create an object from the XML String of score data
		Object[] kmlObj = {xmlString};

		// Create a formatted String for Javascript of the
		// legend information
		// Format example :
		//String legendInfoString = {"1.png","2.png"; "0-10", "10-20"}
		// In Javascript, GoogleEarth.js method createGoogleEarthLegend will
		// use semi-colon delimiters to separate the 2 pieces of information
		// (icon info and threshold info) as 2 strings, then will split each by
		// commas to get each piece of each to recreate the icon and threshold Arrays.
		// Note : Many methods and research was done to try to get a 2D array of
		// information (objects, strings, etc.) to be properly passed to the
		// Javascript function but was unsuccessful. This is the reason
		// for this solution.

		// Convert float array to string array
		String[] thresholdStringArray = FormatLibrary.toStringArray(thresholdArray);
		// Initialize array
		rangeArray = new String[thresholdStringArray.length-1];
		logger.debug("Length thresholdStringArray " + thresholdStringArray.length);
		// Convert the threshold String to ranges
		// Ranges will look like "-50 to \n -20.0"
		for (int i = 1; i<thresholdStringArray.length;i++) {
			logger.debug("i = " + i);
			rangeArray[i-1] = thresholdStringArray[i-1] + " to \n " + thresholdStringArray[i];
			logger.debug("thresholdStringArray : " + thresholdStringArray[i-1]   + " to " + thresholdStringArray[i]);
			logger.debug("range array : " + rangeArray[i-1]);
		}
		logger.debug("RangeArray : " + Arrays.toString(rangeArray));
		// Make a String, icon and thresholds separated by a semi-colon
		// and each item within these arrays comma delimited
		legendInfoString = FormatLibrary.arraysToString(iconArray, rangeArray);
		logger.trace("LegendInfoString = " + legendInfoString);
		Object[] legendObj = {legendInfoString};

		// Get location string to pass as a reference string
		String[] locationNameArray = null;
		try {
			locationNameArray = resultsObj.getReferenceArray();
		} catch (Exception e) {
			logger.error("Cannot get the location name array");
			Log.error("Cannot get the location name array for displaying summary results", "#errorPanelText");
			return 0;
		}

		logger.debug("Getting score summary for each model from StatsLibrary.");
		// Get array of location names
		// Get 3-D array of score information
		String[][][] scoreSummaryArray = StatsLibrary.getScoreSummaryArrayEachModel(resultsObj.getStats(), locationNameArray);

		// Get summary text with HTML formatting to display
		String text = FormatHTMLLibrary.getSummaryHTMLText(scoreSummaryArray, settingsObj, "at");
		logger.debug("TEXT == " + text);

		// Set the name of the HTML formatted file that contains spatial and score information
		File updateTextFile = null;
		updateTextFile = new File("ERFText.html");
		if (settingsObj.getScoreType().equals("heidke")) {
				updateTextFile = new File("HeidkeMapText.html");
		}
		else if (settingsObj.getScoreType().equals("rpss")) {
				updateTextFile = new File("RpssMapText.html");
		}
		else if (settingsObj.getScoreType().equals("brier")) {
				updateTextFile = new File("BrierMapText.html");
		}

		logger.info("Name of the update file is " + updateTextFile);
		htmlString = ReadFileToString.getFileToString(updateTextFile);
		logger.trace("HTML String is :  " + htmlString);
		// Concat the summary text to the explanation text obtained from the HTML file updateTextFile
		String displayText = text.concat(htmlString);
		Object[] htmlObj = {displayText};
		// BUG! Below call to Javascript does NOT work in Mac Firefox
		// JSObject LiveConnect is No longer supported by Mozilla.
		// Replaced by NPAPI (still too new to find documentation)
		// Note, window actually is NULL in Mac Firefox, not in Safari
		// or Windows Firefox
		try {
			// Call Javascript method updateInfoPanel()
			logger.info("Updating info panel with: " + displayText);
			// Get the Verification Javascript Class first, since updateInfoPanel
			// is part of that now, not part of the window (global)
			JSObject verificationClass = (JSObject) window.getMember("Verification");
			// Use the JSObject call() method to invoke the Javascript method
			verificationClass.call("updateInfoPanel",htmlObj);
		}
		catch (Throwable e) {
			logger.fatal("JSObject is null for Verification.updateInfoPanel(). No Javascript object to allow Java to call a Javascript method");
			e.printStackTrace();
			Log.fatal("Cannot update the summary panel. If you are using a Mac OS, try using Safari instead of Firefox.","#errorPanelText");
			return 0;
		}

		// BUG! Below call to Javascript does NOT work in Mac Firefox
		// JSObject LiveConnect is No longer supported by Mozilla.
		// Replaced by NPAPI (still too new to find documentation)
		// Note, window actually is NULL in Mac Firefox, not in Safari
		// or Windows Firefox

		//-------------------------------------------------------
		// Call updateGoogleEarth()
		//
		// Call updateGoogleEarth
		logger.info("Updating the Google Earth object...");
		try {
			googleEarthClass.call("updateGoogleEarth",kmlObj);
		} catch (Exception e) {
			logger.fatal("Cannot update Google Earth: " + e);
			Log.fatal("Cannot display results. If you are using a Mac OS, try using Safari instead of Firefox. Otherwise, try using the chart format for results by selecting the \"Chart\" tab. ", "#errorPanelText");
			return 0;
		}
		// Call Javascript method to create the legend
		logger.info("Creating the Google Earth legend...");
		logger.trace("legendObj = " + legendObj + " (" + legendInfoString + ")");
		logger.trace("kmlObj = " + kmlObj);
		try {
			googleEarthClass.call("createGoogleEarthLegend",legendObj);
		} catch (Exception e) {
			logger.fatal("Cannot create the legend: " + e);
			Log.fatal("Cannot display legend. If you are using a Mac OS, try using Safari instead of Firefox. Otherwise, try using the chart format for results by selecting the \"Chart\" tab. ", "#errorPanelText");
			return 0;
		}
		logger.info("End of applet update method");
		return 1;
	} // End update()

} // End SpatialApplet.java

