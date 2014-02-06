package gov.noaa.ncep.cpc.applets;

import gov.noaa.ncep.cpc.display.PlotChart;
import gov.noaa.ncep.cpc.format.Format;
import gov.noaa.ncep.cpc.format.FormatHTMLLibrary;
import gov.noaa.ncep.cpc.format.ReadFileToString;
import gov.noaa.ncep.cpc.qc.Log;
import gov.noaa.ncep.cpc.services.Results;
import gov.noaa.ncep.cpc.services.ServiceCallThread;
import gov.noaa.ncep.cpc.settings.Settings;
import gov.noaa.ncep.cpc.stats.StatsLibrary;

import java.applet.Applet;
import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.Frame;
import java.awt.Point;
import java.io.File;
import java.net.URL;
import java.util.Arrays;
import java.util.List;
import java.util.ArrayList;

import javax.swing.JApplet;
import javax.swing.JFileChooser;
import javax.swing.JLabel;
import javax.swing.JTextPane;
import javax.swing.SwingUtilities;

import netscape.javascript.JSObject;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

/**
Applet that adds a JCChart to itself in order to display
a plot of the verification scores). This score(s) is calculated
by the VerificationDriver class as well as other functions, and is passed back to the
applet.
*/
public class ChartApplet extends JApplet {

	//-----------------------------------------------------
	// Initialize all variables
	//-----------------------------------------------------
	JFileChooser chooser;
	static protected Applet currentApplet = null; // Current Applet
	static public String xmlString;               // XML string containing score
	static String home = null;                    // Home directory of Verification System
	PlotChart plotChartObj;                       // PlotChart object
	static String htmlString;                     // HTML code to display on the info panel
	static protected Logger logger;               // log4j Logger
	static Settings settingsObj;                  // Settings object
	static JSObject window;                       // JSObject containing the window
	static protected JTextPane textPane;          // JClass text pane for initial message
	// Initialize the run() method flag. This flag is changed to 1 after the
	// Save chart as image button is displayed for the first time.
	static int runFlag = 0;

	ServiceCallThread serviceCallThread = null;

	/**
	Default constructor. Gets a reference to the current applet.
	*/
	public ChartApplet() {
		currentApplet = this;
	}

	static String errorMsg = "<html><center><H2>Applet could not be" +
    " loaded!</H2></CENTER><p>" +
    "The necessary classes to load the applet could not be found.<P>" +
    "Some troubleshooting notes:<UL>" +
    "<LI>In JDK 1.2 or later, the appletviewer does not honor your CLASSPATH." +
    "<LI> Some browsers do not support Java 2.  For others you will need to " +
    "install the Java Plug-in." +
    "</UL>";

	/**
	Overloaded method. This method creates a PlotChart object and adds it
	to the content pane. It also creates a database connection to be used
	throughout the VWT's exist in the Java Virtual Machine. This also
	sets the JSObject window in the Log.java (in qc package) for web logging.
	<br>
	*/
	public void init()
	{
		//-------------------------------------------------
		// Set up the logger
		//-------------------------------------------------
		// Set up configuration file
		String configFile = "/input/logConfigApplet.txt";
		// Get the URL version of the file
		URL url = ChartApplet.class.getResource(configFile);
		// Configure the logger
		PropertyConfigurator.configure(url);
		// Get the new logger
		logger = Logger.getLogger(ChartApplet.class.getName());
		// Reset flag to 0 to display the save chart as image button
		runFlag = 0;
		// Get the window for calling Javascript later
		window = JSObject.getWindow(this);
		// Pass window object to the Log.java class for web logging.
		// This is a required step.
		Log.setJSObject(window);
		// Empty content in the messaging panel for a new run
		Log.empty("#errorPanelText");
		// Create an instance of the html file to use for displaying initial text
		// THIS IS ON THE BOTTOM PANEL not the chart panel
		//File initTextFile = new File("initTextDisplay.html");
		//logger.debug("Name of the file is " + initTextFile);

		// Grid Layout gives a Container divided into equal-sized rectangles.
		// Since we want the chart to be larger than the bottom pane, use FlowLayout instead
		// Example of grid layout : getContentPane().setLayout(new GridLayout(2,1));
		// FlowLayout usage :
		// public FlowLayout(int align, int hgap, int vgap)
		// Creates a new flow layout manager with the indicated alignment and the indicated horizontal and vertical gaps.
		getContentPane().setLayout(new FlowLayout(FlowLayout.CENTER,0,0));

		try {
			// Create a new Plot Chart object
			plotChartObj = new PlotChart();
			// Tell PlotChart how big the applet is, using the builtin
			// applet methods to get the width and height
			// Right now, we don't want JClass taking up the whole applet, because
			// some of the applet is used by the text panel at the bottom for
			// messages to the user.
			plotChartObj.setChartSize(getWidth(), getHeight());
// 			plotChartObj.setChartSize(getWidth(), 500);
			// Make the chart
			plotChartObj.makeChart();
			// Add the PlotChart object to the top pane (first item to add)
			getContentPane().add(plotChartObj);



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

		}
		catch (Exception e) {
			e.printStackTrace(System.out);
			JLabel l = new JLabel(errorMsg);
			l.setVerticalAlignment(JLabel.TOP);
			getContentPane().add(l);
			Log.fatal("Cannot create the chart. Report a plotChart object error.", "#errorPanelText");
		}
	} // End init()

	/**
	* Overloaded method that performs all necessary functions for updated settings options. This method creates a VerificationDriver
	* object, and uses its runDriver method to verify the given
	* variable, based on the given settings. The chart is then
	* updated with the newly obtained score.
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
</table>
	@param regionType Type of regional division to use for verification calculations. ie. regional climate centers, states, stations, etc. (ie. Regional climate centers, states...)
	@param regions Particular region(s) to perform verification for. (ie. Northeast, Midwest, New York, Maryland...)
	@param spatialType Type of storage of each data point. The datasets of forecasts and/or observations are made up of different types of ways that the data represents. (ie. station, gridded, climate division, etc.)
	@param outputType Method of displaying and/or producing output for a score. This is the representational format of the output data produced by the verification software. (ie. chart, spatial map, table, etc.)
	@param outputDimension - Dimension that the output represents. It would be the reference dimension that each of the score values represent. Examples of outputput dimension:
<br>space - scores representing spatial points, ie. on a map
<br>time - scores representing dates, ie. on a timeseries chart
<br>probability - scores representing probability values, ie. reliability scores, where the scores represent an interval of probabilities of a forecast category
	@param scoreType Type of verification score to calculate. (ie. heidke, RPSS, etc)
	@param categoryType The categories to verify. (ie. all together or separate)
	@param ECType Status of whether forecasts to be verified uses equal chances forecasts or not. (ie. "noEC" or "withEC")
	@return success  Success code (1 for successful score calculation and plotting, 0 for non-successful)
	*/

	public int update(String variable, String fcstSource, String leadTime, String aveWindow, String datesValidType, String datesValid, String regionType, String regions, String spatialType, String outputType, String outputDimension, String scoreType, String categoryType, String ECType) {

	  // Empty content in the messaging panel for a new run
		Log.empty("#errorPanelText");
		//-------------------------------------------------
		// Print a wait-message
		//-------------------------------------------------
		// Create an instance of the html file to use for displaying text
		File processingTextFile = new File("processingTextDisplay.html");
		// Set string
		String htmlProcessingString = ReadFileToString.getFileToString(processingTextFile);
		logger.debug("HTML String is :  " + htmlProcessingString);
		// Update label
		// Uncomment the line below to enable a processing message in the applet
		// plotChartObj.updateChartLabel(htmlProcessingString);
		String[] settingsArray = {variable, fcstSource, leadTime, aveWindow, datesValidType, datesValid, regionType, regions, spatialType, outputType, outputDimension, scoreType, categoryType, ECType};

		// Retrieve the Results object
    logger.info("Calling services for results");

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
		// Remove any existing chart
		logger.debug("REMOVING ANY EXISTING CHARTS...");
		plotChartObj.hideChart();
		return 0;
      }
      // Remove any existing chart
	  logger.debug("REMOVING ANY EXISTING CHARTS...");
	  plotChartObj.hideChart();
      return 0;
    }

    settingsObj = new Settings(settingsArray);

		// Format the data, passing results and settings object
		xmlString = Format.getFormattedData(resultsObj, settingsObj);
		// Print out returned string
		logger.debug("xmlString = " + xmlString);

		// next 2 lines for printing only, remove eventually
		String[] scoreCatStringArray = resultsObj.getStats().getScoreCatStringArray()[0][0];
		logger.trace("first model score cat all float array is : " + Arrays.toString(scoreCatStringArray));

		// Set the Settings object in the PlotChart object
		plotChartObj.setSettingsObj(settingsObj);
		// Set the data object
		plotChartObj.setResultsObj(resultsObj);
		// Unhides the chart (in case it was previously hidden after an error)
		plotChartObj.showChart();
		String[] referenceString = null;
		// Get reference array
		try {
			referenceString = resultsObj.getReferenceArray();
		} catch (Exception e) {
			logger.fatal("Cannot get the reference array");
			Log.fatal("Cannot get the reference array", "#errorPanelText");
			return 0;
		}

		// Get score summary (high,low,ave) for each model and category for non reliability score types
		// Print number of forecasts per bin for reliability diagram. This is temporary until we can
		// plot a histogram.
		String[][][] scoreSummaryArray;
		String text = null;
		if (!(settingsObj.getScoreType().equals("reliability"))) {
			// Get 3-D array of score information
			scoreSummaryArray = StatsLibrary.getScoreSummaryArrayEachModel(resultsObj.getStats(), referenceString);
			// Get summary text with HTML formatting to display
			text = FormatHTMLLibrary.getSummaryHTMLText(scoreSummaryArray, settingsObj, "on");
		}
		else if (settingsObj.getScoreType().equals("reliability")) {
			text = FormatHTMLLibrary.getSummaryHTMLTextReliability(resultsObj.getStats(), settingsObj);
		}
		logger.trace("TEXT == " + text);
		// Set the name of the HTML file with axis info
		File axisTextFile = new File("ChartAxisText.html");
		// Set the name of the HTML formatted file that contains chart and score information
		File updateTextFile=null;
		if (settingsObj.getScoreType().equals("heidke")) {
			updateTextFile = new File("HeidkeText.html");
		}
		else if (settingsObj.getScoreType().equals("rpss")) {
			updateTextFile = new File("RpssText.html");
		}
		else if (settingsObj.getScoreType().equals("brier")) {
			updateTextFile = new File("BrierChartText.html");
		}
		else if (settingsObj.getScoreType().equals("reliability")) {
			updateTextFile = new File("ReliabilityText.html");
		}

		logger.info("Name of the axis info text file is " + axisTextFile + "Name of the score info file is " + updateTextFile);
		htmlString = "<h4>Interpreting the X and Y Axes </h4>"+ ReadFileToString.getFileToString(axisTextFile) + "\n <h4><b> Understanding the skill score </h4></b>" +  ReadFileToString.getFileToString(updateTextFile);
		logger.debug("HTML String is :  " + htmlString);

		// Concat the summary text to the explanation text obtained from the HTML file updateTextFile
		String displayText = text.concat(htmlString);
		Object[] htmlObj = {displayText};
		try {
			// Call Javascript method updateGoogleEarth() to use to display  values
			// on a GoogleMap. Pass kmlObj which is KML formatted for displaying
			logger.info("Updating info panel with: " + displayText);
			// Get the Verification Javascript Class first, since updateInfoPanel
			// is part of that now, not part of the window (global)
			JSObject verificationClass = (JSObject) window.getMember("Verification");
			// Use the JSObject call() method to invoke the Javascript method
			verificationClass.call("updateInfoPanel",htmlObj);
		}
		catch (Throwable e) {
			logger.fatal("JSObject is null. No Javascript object to allow Java to call a Javascript method");
			Log.error("Results summary could not be written due to display communication problem.","#errorPanelText");
			e.printStackTrace();
			return 0;
		}
		try {
			// Make the chart object
			invokeAndWait(new ConfigureChart(plotChartObj, xmlString));
		}
		catch (Throwable e) {
			e.printStackTrace(System.out);
			JLabel l = new JLabel(errorMsg);
			l.setVerticalAlignment(JLabel.TOP);
			getContentPane().add(l, BorderLayout.CENTER);
			Log.fatal("Could not update the chart. Report a chart configuration problem.", "#errorPanelText");
			return 0;
		}
		Frame[] appletFrames = Frame.getFrames();
		logger.debug("# Frames = " + appletFrames.length);
		appletFrames[0].pack();
		appletFrames[0].setLocation(new Point(0,0));
		appletFrames[0].setLocation(new Point(1400,0));
        appletFrames[0].setVisible(true);

		logger.info("End of applet update method");

		//------------------------------------------------------------------------------------------
		// Append all warning messages from the results object to the errorPanel
		//
		for (String msg : resultsObj.getWarningMessages())
		{
			Log.warning(msg,"#errorPanelText");
		}
		return 1;
	}

	/**
	Contains update functionality, calls updateLabels and recalc and revalidate for chart to update the labels, recalculate and display the chart.
	@param plotChart plotChart object to configure
	@param dataString String of data formatted appropriately to set as part of the plotChart object
	*/
	public static class ConfigureChart implements Runnable {

		protected PlotChart plotChart;
		protected String dataString;

		/**
		Configures the chart by setting a plotChart and string of data.
		<p>
		@param plotChart plotChart object to configure
		@param dataString String of data formatted appropriately to set as part of the plotChart object attribute.
		*/
		ConfigureChart(PlotChart plotChart, String dataString) {
			this.plotChart = plotChart;
			this.dataString = dataString;
		}

		/**
		Updates chart data, and chart attributes, including labels.
		*/
		public void run() {
			// Set properties for the PlotChart object
			logger.trace(dataString);
			plotChart.updateChartData(dataString);
			plotChart.chart.recalc();
			plotChart.updateLabels();
			plotChart.chart.recalc();
			plotChart.chart.revalidate();
			logger.debug("Run flag is ********* " + runFlag);
			// If runFlag is set to the default value before run() has completed,
			// display the save button. This logic enables the save button to
			// only be displayed once during a session.
			if (runFlag == 0) {
				// Update button to save chart to appear
				plotChart.showSaveButton();
				// Set flag indicating that the run() method has been insantiated
				// This means the button has already been displayed once
				runFlag = 1;
			}
				// Send this text to the info panel
				logger.info("Sending HTML to the info panel...");
		} // End run
	} // End ConfigureChart

	/**
	* Wrapper method for the {@link SwingUtilities#invokeAndWait invokeAndWait}
	* method in SwingUtilities. This method is being included since we are not
	* able to run invokeAndWait from the Event Dispatch Thread.
	*
	* @param  doRun  What you want to run
	*/
	public static void invokeAndWait(Runnable doRun) throws InterruptedException, java.lang.reflect.InvocationTargetException {
		if (SwingUtilities.isEventDispatchThread()) {
			doRun.run();
		}
		else {
			SwingUtilities.invokeAndWait(doRun);
		}
	}

} // End ChartApplet.java
///////////////////////////////



