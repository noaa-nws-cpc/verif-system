package gov.noaa.ncep.cpc.services;

import gov.noaa.ncep.cpc.display.PlotChart;
import gov.noaa.ncep.cpc.format.Format;
import gov.noaa.ncep.cpc.format.FormatLibrary;
import gov.noaa.ncep.cpc.format.WriteLibrary;
import gov.noaa.ncep.cpc.format.XMLReader;
import gov.noaa.ncep.cpc.qc.Log;
import gov.noaa.ncep.cpc.qc.Requirements;
import gov.noaa.ncep.cpc.settings.Settings;

import java.awt.Image;
import java.io.File;
import java.net.URL;
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

//
//
// TODO: This is meant to be run like the StaticRunDriver but will use web services
//       instead of accessing the database directly. Currently it is mostly a cut and
//       paste of the StaticRunDriver and will be modified slowly as the web service
//       pieces fall into place.
//
//


//
//
// Notes: Libs to copy to axis2 lib dir - mysql.jar, 
//
//
public class WebServiceRunDriver
{
  // Initialize all variables
  static Logger logger;
  static String homeDir = null;
  static PlotChart chart;
  static String settingsXMLFile;
  static String logConfigFile;
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

  public WebServiceRunDriver() {
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
    
    // Loop over all runs
    Results resultsObj = null;
    for (String[] settings : settingsArray) {

      // TODO: Reorganize ServiceCallThread so we can retrieve the results object without
      //       creating a thread for specific cases where we know that we will not be
      //       executing request inside a secure sandbox. This will reduce overhead.
      logger.info("Calling services for results");
      ServiceCallThread serviceCallThread = new ServiceCallThread();
      serviceCallThread.start();
      resultsObj = serviceCallThread.doQuery(settings);
      serviceCallThread.stop();
      
      if (resultsObj.getResultType() == Results.RESULT_TYPE_ERROR)
      {
        logger.fatal("Can not run the driver for settings: " + Arrays.toString(settings));
        logger.fatal("Resulting error message: " + resultsObj.getErrorMessage());
        Log.fatal("Can not run the driver","#errorPanelText");
        System.exit(0);
      }
      
      logger.info("Results timestamp : " + resultsObj.getTimestamp());

      Settings settingsObj = new Settings(settings);
      settingsObj.setHomeDir(homeDir);

      //settingsObj.printSettings();
      
      // Get the output type
      outputType = settingsObj.getOutputType();
      // If this is an ASCII file run...

      if (outputType.equals("ascii")) {
        // To Do : Make file name an option
        try {
          String fileName;
          fileName = FormatLibrary.getAsciiFileName(settingsObj,resultsObj);
          // Write data to Ascii text file
          logger.info("File name : " + fileName);
          WriteLibrary.writeToAscii(resultsObj,settingsObj,fileName);
        } catch (Exception e) {
          logger.fatal("Exception", e);
          logger.fatal("Could not get the ascii file name or write to the file");
          Log.fatal("Could not get the ascii file name or write to the file","#errorPanelText");
          System.exit(0);
        }
      }
      // If this is a CHART (timeseries or reliability diagram) run...
      else if (outputType.equals("chart")) {
        // Create a PlotChart object
        chart = new PlotChart();
        chart.setSettingsObj(settingsObj);
        chart.setResultsObj(resultsObj);
        // Set the Applet size so JClass can set a size for the image
        chart.setChartSize(660,500);
        // Get the XML string of stats formatted for display from the driver
        String xmlString = Format.getFormattedData(resultsObj, settingsObj);
        // Create the chart and also saves as file
		try {
	        chart.makeStaticChart(xmlString);
		} catch (Exception e) {
			logger.fatal("Could not make a JClass chart: " + e);
			Log.fatal("There was a problem with the plotting package","#errorPanelText");
		}
        logger.debug("Created chart with xmlString of data");
      }
      else {
        logger.fatal("Could not make output because invalid output type : " + outputType);
      }
      
    //logger.debug("Ran obj for " + driverObj.getClass());
    }
  } // End constructor

  

  
/**
Accepts command line arguments and initializes a PlotChart chart object. Accepts a
flag and path and name of an XML formatted file that lists the settings.
<p>To run the static driver from the command line :
<p> > java gov/noaa/ncep/cpc/driver/WebServiceRunDriver -f /path/to/settingsXML/file.xml -l /path/to/loggerConfigFile.txt
<p> where -f is the flag notifying the program that a file following the flag
is specified, and /path/to/settingsXML/file.xml is the full path and file name of
the settings XML file,
and -l is the flag notifying the program that a file following the flag is specified for
the logger configuration file for log4j Apache software.
<p>
@see Image
*/
  public static void main(String[] args) {
    //
    // TODO: the logger variable is null until later in main causing null pointer
    //       exceptions if something goes wrong. Maybe setup the logger first and
    //       notify user if the logger configuration is not avaiable? Note!! This
    //       is also true of the StaticRunDriver and should be fixed at some point.
    //
    
    //
    // TODO: should not need to process the -f command line arg since we will not be
    //       creating the database connection here.
    //
    //
    
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
      formatter.printHelp("java WebServiceRunDriver [OPTIONS]",options);
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
    logger = Logger.getLogger(WebServiceRunDriver.class.getName());
    // Set the log file path
    System.setProperty("logDir", homeDir + "/logs");
    // Configure the logger
    PropertyConfigurator.configure(url);
    logger.info("Starting WebServiceRunDriver");
    logger.info("Use logger config file: " + logConfigFile);
    logger.info("Use settings XML file: " + settingsXMLFile);
    logger.debug("Create PlotChart object");

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
    logger.trace("Run static driver");
    WebServiceRunDriver p = new WebServiceRunDriver();
    logger.info("Sucessfully completed running WebServiceRunDriver");
  } // End main() method
}
