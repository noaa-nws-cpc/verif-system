package gov.noaa.ncep.cpc.format;

// Import needed verification packages
import gov.noaa.ncep.cpc.qc.Log;
import gov.noaa.ncep.cpc.services.Results;
import gov.noaa.ncep.cpc.settings.Settings;
import gov.noaa.ncep.cpc.settings.SettingsHashLibrary;
import gov.noaa.ncep.cpc.stats.Stats;
import gov.noaa.ncep.cpc.stats.StatsLibrary;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Date;

import org.apache.log4j.Logger;

/**
Library of write functions including formatting and writing to output files.
*/
public class WriteLibrary {
	// Initialize variables
	static Logger logger;

	/**
	Writes to an ASCII text file to a passed file name and location. Uses the passed
	settings and stats objects to obtain necessary information to write output
	to the file. The stats written to this file is either in the space or time dimension.
	This is specified by the settings object variable outputDimension which should have
	either the value of 'time' or 'space'.
	<br>
	NOTE : All header names are forced to have no spaces. An underscore replaces all spaces that may occur in the header name. This is so parsing the ASCII file in post-processes could be easier.
	<br>
	########################################################################<br>
	# Content : Verification statistics ASCII data file.<br>
	# Variable verified : $variable<br>
	# Score calculated : $scoreType<br>
	# Forecast types verified : $fcstSources<br>
	# Each forecast represents a : $aveWindow<br>
	# Verification period is over: $numberOfDates $Units<br> **NOTE This may need to be revisited when doing space and time options
	# From :$first AvailableDate to $lastAvailableDate
	# Lead time of forecasts verified : $leadTime<br>
	# Region type of input data : $regionType<br>
	# Regions included in verification : $regions<br>
	# Type of spatial formatting of the input data used in verification: $spatialType<br>
	# Category type : $categoryType categories<br>
	# Output dimension : $outputDimension <br>
	# Type of date filtering : $datesValidType <br>
	# Date filtering options selected: $datesValid<br>
	########################################################################<br>
	$refLabel &nbsp;&nbsp;&nbsp;Forecast Source&nbsp;&nbsp;&nbsp;Score&nbsp;&nbsp; &nbsp;Forecast Source&nbsp;&nbsp; &nbsp; Score <br>
	$referenceData[i]&nbsp;&nbsp;&nbsp; $fcstSource1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; $scoreForFcstSource1&nbsp;&nbsp;&nbsp; $fcstSource2&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; $scoreForFcstSource2&nbsp;&nbsp;&nbsp; <br>
	<br>
	The first column header ($refLabel) is the reference label, ie. Date, Location, etc. In the example data shown
	the column is date. <br>
	The subsequent columns represent the statistics for each forecast source processed.
	For each forecast source there is a column for the name of the forecast source, the following column
	to its right contains the associated score value for that forecast source and reference index (either a date or a location depending on the value of outputDimension).
	<br>
	<b>The field widths are:</b><br>
	$refLabel - 15 chars <br>
	Forecast Source - 20 chars<br>
	Score - 10 chars
	<br>
	An example of what the output file would like :
	<br>
	########################################################################<br>
	# Content: Verification statistics ASCII data file <br>
	# Variable verified: temperature                  <br>
	# Score calculated: brier                       <br>
	# Forecast types verified: manual                <br>
	# Each forecast represents a : 05d period  <br>
	# Verification period is over: 10 days  <br>
	# From: 01/01/2009 to 01/10/2009  <br>
	# Lead time of forecasts verified: 08d          <br>
	# Region type of input data: climateRegion      <br>
	# Regions included in verification: NE,SE,MW,S,HP,W  <br>
	# Type of spatial formatting of the input data used in verification:  gridded   <br>
	# Category type : total categories<br>
	# Output dimension : time <br>
	# Type of date filtering : selectSeasonalSignal <br>
	# Date filtering options selected: ENSO;warm<br>
	########################################################################  <br>
	Date_Valid &nbsp;&nbsp;&nbsp;Forecast_Source&nbsp;&nbsp;&nbsp;all_cats&nbsp;&nbsp; &nbsp;Forecast_Source&nbsp;&nbsp; &nbsp; Score <br>
	1/23/2010&nbsp;&nbsp;&nbsp; manual&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 44.09&nbsp;&nbsp;&nbsp; auto&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 58.72&nbsp;&nbsp;&nbsp; <br>
	1/24/2010&nbsp;&nbsp;&nbsp; manual&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 31.02&nbsp;&nbsp;&nbsp; auto&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 16.06&nbsp;&nbsp;&nbsp; <br>
	*** NOTE : The below info about the first column of reference info is not completed as of 2/22/11 but should
	be completed within the next few weeks. As of now only the dates are retrieved, and the stats only allows
	the ascii to use the time output dimension. ***
	<br>
	The correct reference information for the first column is determined based on the outputDimension set in the settings (time or space). If it is for 'time', the reference dates array representing <i>valid forecast dates</i>will be retrieved and used in this column.
	Otherwise, for 'space', location names will be used. Other location information is available such as latitude and longitude, but for now only location names will be used.
	<b>
	@param resultsObj Results object containing stats data and other related information
	@param settingsObj Settings object containing settings data
	@param fileName File name to write to. This is built in FormatLibrary.getAsciiFileName(). The location of the output ASCII file is by default in
	the verification process home /output sub-directory. Currently this sub-directory
	is hard-wired in this method.
	*/
	public static void writeToAscii(Results resultsObj, Settings settingsObj, String fileName) throws Exception {
		// Initialize logger
		logger = Logger.getLogger(WriteLibrary.class.getName());

		// Get stats object
		Stats statsObj = resultsObj.getStats();

		String leadTime = settingsObj.getLeadTime();
		String categoryType = settingsObj.getCategoryType();
		String[] referenceArray = null;
		String header1 = "";
		String header2 = "";
		String[] header3 = new String[4];
		String header4 = "";
		String[] latArray = null;
		String[] lonArray = null;
		String[] dateBounds = null;
		String[][] goodScorePercentArray = null;
		String[][] goodScoreCountArray = null;
		float[][][]goodDataReliabilityQCArray = null;
		String[][][] validDataArray = null;
		String[][][] numValidDataArray = null;
		String[][][] pctValidDataArray = null;
		String[] fcstSourceLength = new String[settingsObj.getFcstSourceArray().length];
		String categoryLabel;
		String[] categoryLabelLength = new String[settingsObj.getFcstSourceArray().length];
		int defaultCategoryLabelLength = 15; // Default length to assign the category label/stats column.
		//String[] categoryLabels;
		// Parse the string into Date object
		Date date;

		// Create string buffer
		StringBuffer str = new StringBuffer();

		// Create path with file name for output file.
		// This file will be output to the process home /output directory.
		String filePathName = settingsObj.getHomeDir() + "/output/" + fileName;
		// Open output file.
		File file = new File(filePathName);

		// Get date string array
		String[] dateArray = resultsObj.getFormattedReferenceDatesArray();

		// Get forecast sources String array
		String[] fcstSourceArray = settingsObj.getFcstSourceArray();
		

		// Get score data string array (3-D array) of all forecast sources
		// Dimensions are:[model][category][day/location/bin]
		String[][][] statsArray = statsObj.getScoreCatStringArray();
		
		// Get 3-D array with information about the percent of valid (good) data points 
		// Append a '%' symbol to each of the values
		String [][][] pctValidDataArrayTemp = FormatLibrary.toStringArray(statsObj.getGoodDataPercentArray());
		logger.debug("pctValidDataArrayTemp.length is " + pctValidDataArrayTemp.length);
		logger.debug("pctValidDataArrayTemp[0].length is " + pctValidDataArrayTemp[0].length);
		logger.debug("pctValidDataArrayTemp[0][0].length is " + pctValidDataArrayTemp[0][0].length);

		// Allocate space for array
		logger.debug("allocate arrays...");
		//fcstCat  = new float[fcstSourceArray.length][numFcstDates][numFcstLocations];
		pctValidDataArray = new String[pctValidDataArrayTemp.length][pctValidDataArrayTemp[0].length][pctValidDataArrayTemp[0][0].length];
		try {
			for (int i=0; i<pctValidDataArrayTemp.length; i++) {
				for (int j=0; j<pctValidDataArrayTemp[0].length; j++) {
					for (int k=0; k<pctValidDataArrayTemp[0][0].length; k++) {
						pctValidDataArray[i][j][k] = pctValidDataArrayTemp[i][j][k] + "%";
					}
				}
			}
			logger.debug("finished adding %");
		}	
		catch (Exception e) {
			throw new Exception("Problem trying to append a '%' to values!");
		}
		// # of valid (good) data points used to calculate each score 
		numValidDataArray = statsObj.getGoodDataCountStringArray();	
			
		logger.debug("Creating header for ASCII output...");
		// Get the reference array from the data object
		referenceArray = resultsObj.getReferenceArray();
		logger.trace("Reference array : " + Arrays.toString(referenceArray));

		// Get the lat and lon data
		if (settingsObj.getOutputDimension().compareToIgnoreCase("space") == 0) {
			// If the output dimension is space, get the lat and lon arrays as well
			latArray = resultsObj.getLocationLatArray();
			lonArray = resultsObj.getLocationLonArray();
		}
		
		// Create header for output file in string buffer
		str.append("########################################################################\n");
		str.append("# Content: Verification statistics ASCII data file\n");
		str.append(String.format("# Variable verified: %1$-30s \n", SettingsHashLibrary.getSettingsLabel(settingsObj.getVariable())));
		str.append(String.format("# Score calculated: %1$-30s \n", settingsObj.getScoreType()));
		str.append(String.format("# Forecast types verified: %1$-30s \n", settingsObj.getFcstSources()));
		str.append(String.format("# Each forecast represents a : %s period \n", settingsObj.getAveWindow()));

		// Get start and end dates. This is retrieved from the forecast database, first and last available
		// dates. The start and end dates represent the valid dates, which are calculated from the date issued
		// with the Databse.getFirstValidDate() method
		String colDateIssued = "date_issued";
		// Get the date bounds representing date valid
		try {
			dateBounds = resultsObj.getFcstDateValidBounds();
		}
		catch (Exception e) {
			logger.fatal("Date bounds could not be retrieved");
			Log.fatal("Date bounds could not be retrieved","#errorPanelText");
			throw e;
		}
		String firstAvailableDate = dateBounds[0];
		// Get the last date available from the database
		String lastAvailableDate = dateBounds[1];
		String leadTimeUnit = SettingsHashLibrary.getSqlTimeUnit(leadTime.substring(leadTime.length()-1));
		str.append(String.format("# Verification period is over: %s %s%s \n",resultsObj.getNumUniqueFcstDates(),leadTimeUnit.toLowerCase(),"s"));
		str.append(String.format("# From: %s to %s \n",firstAvailableDate,lastAvailableDate));
		str.append(String.format("# Lead time of forecasts verified: %1$-30s \n", settingsObj.getLeadTime()));
		str.append(String.format("# Region type of input data: %1$-30s \n", settingsObj.getRegionType()));
		str.append(String.format("# Regions included in verification: %s \n", settingsObj.getRegions()));
		str.append(String.format("# Type of spatial formatting of the input data used in verification:  %s \n", settingsObj.getSpatialType()));
		str.append(String.format("# Category type: %s %s\n", categoryType,"categories"));
		str.append(String.format("# Output dimension: %s \n", settingsObj.getOutputDimension()));
		str.append(String.format("# Type of date filtering: %s\n", settingsObj.getDatesValidType()));
		str.append(String.format("# Date filtering options selected: %s\n", settingsObj.getDatesValid()));
		
		// In header: QC info
		// If total categories -> print % and number of good scores overall
		// If separate scores, B, N, A -> print number of good scores for each category
		try {
		
			// Get the percent of good scores for each forecast (NaNs for some situations)
			goodScorePercentArray = FormatLibrary.toStringArray(statsObj.getGoodScorePercentArray());
			// Get the number of good scores for each forecast 
			goodScoreCountArray = FormatLibrary.toStringArray(statsObj.getGoodScoreCountArray());
					
			logger.debug("Category is : " + categoryType);
			// Loop through all models for % valid scores
			for (int i=0; i<fcstSourceArray.length;i++) {
				
				// IF RELIABILITY get the count and % good fcst-obs data pairs for each cat 
				if (settingsObj.getScoreType().compareToIgnoreCase("reliability") == 0) {
					// Get the percent of good data pairs for each forecast (NaNs for some situations)
					goodScorePercentArray = FormatLibrary.toStringArray(statsObj.getGoodScorePercentArray());
					// Get the number of good data pairs for each forecast 
					goodScoreCountArray = FormatLibrary.toStringArray(statsObj.getGoodScoreCountArray());
					
					// Get category label associated with the forecast source
					categoryLabel = SettingsHashLibrary.getCategoryLabel(categoryType,fcstSourceArray[i]); 
					str.append(String.format("# Percent of valid fcst-obs pairs of data for %s forecast %s : %s \n", fcstSourceArray[i],categoryLabel,goodScorePercentArray[i][0]));
					str.append(String.format("# Number of valid fcst-obs pairs of data for %s forecast %s : %s \n", fcstSourceArray[i],categoryLabel,goodScoreCountArray[i][0]));
				}
				
				// If NOT RELIABILITY
				// For the below goodScorePerecentArray and goodScoreCountArray - both are retrieved, even though in
				// some situations values could be NaN - formatting logic below this uses one of the two arrays
				// depending on the scoreType, categoryType, etc.
				else {
					// Get category label
					categoryLabel = SettingsHashLibrary.getCategoryLabel(categoryType,fcstSourceArray[i]);
					// For each index in the category dimension, write a value
					// The stats array always has the category values for total,B,N,A.
					// Write the scores in the 'total' categories index
					str.append(String.format("# Percent of valid scores for %s forecast %s category : %s \n", fcstSourceArray[i],categoryLabel,goodScorePercentArray[i][0]));
					str.append(String.format("# Number of valid scores for %s forecast %s category : %s \n", fcstSourceArray[i],categoryLabel,goodScoreCountArray[i][0]));
				} // End non-reliability
			} // End for loop for fcst sources
		} // End try
		catch (Exception e) {
			logger.fatal("Could not get header information regarding the percent of valid scores.");
			Log.fatal("COuld not get header information regaring the perecent of valid scores.","#errorPanelText");
			throw e;
		}
        // Score Summary
		int startIndex = 0;
		int endIndex = 0;
		if (settingsObj.getCategoryType().equals("separate")) {
			startIndex = 1;
			endIndex = 3;
		}
		else if (settingsObj.getCategoryType().equals("B")) {
			startIndex = 1;
			endIndex = 1;
		}
		else if (settingsObj.getCategoryType().equals("N")) {
			startIndex = 2;
			endIndex = 2;
		}
		else if (settingsObj.getCategoryType().equals("A")) {
			startIndex = 3;
			endIndex = 3;
		}
		// Create text associated with each of the categories to use in the info panel text
		// The number of elements should be identical to the category array size
		String[] categoryText = {"including all categories","the below normal category","the normal category", "the above normal category"};
		//---------------------------------------------------
		// Parse string of forecast sources into a String array
		//---------------------------------------------------
		String fcstSources = settingsObj.getFcstSources();
		logger.debug("String of long forecast sources is : " + fcstSources);
		String delims = "[,]"; // Syntax that denotes separate items
		String[] fcstSourcesArray = fcstSources.split(delims);
		// Get 3-D array of score information
		String[][][] scoreSummaryArray;
		scoreSummaryArray = StatsLibrary.getScoreSummaryArrayEachModel(resultsObj.getStats(), resultsObj.getReferenceArray());
    	if (!(settingsObj.getScoreType().equals("reliability"))) {
		str.append("#----------------------------------------------------------------------- \n");
        str.append("#                             Score Summary                             \n");
        //---------------------------------------------------
		// Print the average scores
		//---------------------------------------------------
		// Loop over categories
			for (int j=startIndex;j<(endIndex+1);j++) {
				str.append("# The average " + settingsObj.getScoreType() + " score(s) for "+ categoryText[j] +" for the : \n");
				// Loop over forecasts
				for (int i=0; i<fcstSourcesArray.length; i++) {
					str.append("# " + fcstSourcesArray[i] + " forecast is " + scoreSummaryArray[i][j][4] + " with " + scoreSummaryArray[i][j][5] + " values \n");
				}
// 					// Print a line to separate the text output for each category
// 					if (settingsObj.getOutputType().equals("chart") && settingsObj.getCategoryType().equals("separate") && j<endIndex) {
// 						text = text.concat("<hr>");
// 					}
			} // End category loop
        }
		str.append("######################################################################## \n");
        
		logger.debug("Finished creating header for ASCII output...");
		
		// WRITE COLUMN HEADERS
		// Create reference information header
		header1 = SettingsHashLibrary.getReferenceDimensionLabel(settingsObj.getOutputDimension());
		// Replace all spaces by underscores for the ascii output for col 1
		header1 = header1.replace(" ","_");


		// WRITE COLUMN HEADER FOR VALID DATA (% or #) AND SET VARIABLE validDataArray TO APPROPRIATE ASSOCIATED DATA TO BE WRITTEN LATER ON 
		// If output dimension is time or space, then get label for perecent good data
		// if dimension is probability, then get label for num valid points
		// Get labels for number of good data points
		// If total categories use following logic
		//validDataArray = new String[validDataArrayTemp.length][validDataArrayTemp[0].length][validDataArrayTemp[0][0].length];
		if (categoryType.compareToIgnoreCase("total") == 0) {
			if ((settingsObj.getOutputDimension().compareToIgnoreCase("space") == 0) || (settingsObj.getOutputDimension().compareToIgnoreCase("time") == 0)) {
				header4 = SettingsHashLibrary.getPerecentValidScoresLabel(settingsObj.getOutputDimension());
				validDataArray = pctValidDataArray;
			}
			else if (settingsObj.getOutputDimension().compareToIgnoreCase("probability") == 0) {
				header4 = SettingsHashLibrary.getNumValidPointsLabel(settingsObj.getOutputDimension());
				validDataArray = numValidDataArray;
			}
			else {
				logger.fatal("Invalid call to get a column header label for information about valid data for each data point");
				Log.fatal("Invalid attempt to get a column header label for information about valid (good) data for output dimension " + settingsObj.getOutputDimension(),"#errorPanelText");
			}
		}
		// If separate use following logic
		else if ((categoryType.compareToIgnoreCase("separate") == 0) || (categoryType.compareToIgnoreCase("B") == 0) || (categoryType.compareToIgnoreCase("N") == 0) || (categoryType.compareToIgnoreCase("A") == 0)) {
			// For all cases (heidke, brier, reliability, use % valid data
			if (settingsObj.getScoreType().compareToIgnoreCase("rpss") == 0) {
				header4 = "N/A"; // In the case of separate RPSS, this header and its associated info should not be written to output
				validDataArray = null;
				logger.debug("# valid data points set as null as expected because it is not applicable to this score.");
			} 
			// For all other cases use number valid datas
			else {
				header4 = SettingsHashLibrary.getNumValidPointsLabel(settingsObj.getOutputDimension());
				validDataArray = numValidDataArray;
			}
		}
		// If not separate or total, there is no valid logic
		else {
			logger.fatal("Invalid call to get column information about valid (good) data for each data point");
			Log.fatal("Invalid attempt to get column information about valid (good) data for output dimension " + settingsObj.getOutputDimension(),"#errorPanelText");
			throw new Exception ("Invalid call to get column information about valid (good) data for each data point");
		}
		// Replace all spaces by underscores for the ascii output for col 1
		header4 = header4.replace(" ","_");
		
		// If the output dimension is 'space', allow more space for location name
		if (settingsObj.getOutputDimension().compareToIgnoreCase("space") == 0) {
			// ID
			str.append(String.format("%1$-28s%2$-8s%3$-8s",header1,"lat","lon"));
		}
		else {
			str.append(String.format("%1$-15s",header1));
		}
		// For each forecast source, create a header for the forecast source and a score header
		for (int i=0; i<fcstSourceArray.length;i++) {
			// Get all possible category labels associated with this forecast source i
			// header3[0] - total cats, header[1] - lower cat, header[2] - normal cat, header[3] - above cat
			// Also replace all spaces by underscores for the ascii output for category col headers
			header3[0] = SettingsHashLibrary.getCategoryLabel("total",fcstSourceArray[i]).replace(" ","_");
			header3[1] = SettingsHashLibrary.getCategoryLabel("B",fcstSourceArray[i]).replace(" ","_");
			header3[2] = SettingsHashLibrary.getCategoryLabel("N",fcstSourceArray[i]).replace(" ","_");
			header3[3] = SettingsHashLibrary.getCategoryLabel("A",fcstSourceArray[i]).replace(" ","_");
			// Get the character length of fcst source (used for headers and later for data formatting)
			// header2 is forecast source
			header2 = "Forecast Source";
			// Replace all spaces by underscores for the ascii output for col 2
			header2 = header2.replace(" ","_");
			// Get character length of forecast source
			logger.trace("fcst char len for forecast source: " + fcstSourceArray[i] + " is " + Integer.toString(fcstSourceArray[i].length()));
			// Set char length for fcst source col			
			// If the forecast source length is less than length of header2 then set to length of header 2			
			// Add 1 space for delimeter			
			if (fcstSourceArray[i].length() < header2.length()) {
				fcstSourceLength[i] = Integer.toString(header2.length()+1);
			}
			// Else set to the fcst source length + 1
			else {
				fcstSourceLength[i] = Integer.toString(fcstSourceArray[i].length()+1);
			}
			// Set col length of category/stats col
			// If the category label is greater than the default assigned length, then set length to category label length
			// otherwise the default size set from defaultCategoryLabelLength will be used.
			if (header3[i].length() > defaultCategoryLabelLength) {
				categoryLabelLength[i] = Integer.toString(header3[i].length()+1);
			}	
			else {
				categoryLabelLength[i] = Integer.toString(defaultCategoryLabelLength+1);
			}
			str.append(String.format("%-"+fcstSourceLength[i]+"s",header2));
			// For each of the category labels, write a header for the column
			// For each index in the category dimension, write a value
			// The stats array always has the category values for total,B,N,A.
			// If total categories selected, write out 0th index
			if (categoryType.compareToIgnoreCase("total") == 0) {
				// Add category label
				str.append(String.format("%1$-"+categoryLabelLength[0]+"s",header3[0]));
				// Add num valid points label
				str.append(String.format("%1$-25s",header4));
			}
			// If separate categories, write out 1st, to last index
			else if (categoryType.compareToIgnoreCase("separate") == 0) {
				// Add category label
				str.append(String.format("%1$-"+categoryLabelLength[0]+"s",header3[1]));
				// Add num valid points label
				str.append(String.format("%1$-25s",header4));
				// Add category label
				str.append(String.format("%1$-"+categoryLabelLength[0]+"s",header3[2]));
				// Add num valid points label
				str.append(String.format("%1$-25s",header4));
				// Add category label
				str.append(String.format("%1$-"+categoryLabelLength[0]+"s",header3[3]));
				// Add num valid points label
				str.append(String.format("%1$-25s",header4));
			}
			// If below normal category only use index k=1
			else if (categoryType.compareToIgnoreCase("B") == 0) {
				// Add category label
				str.append(String.format("%1$-"+categoryLabelLength[0]+"s",header3[1]));
				// Add num valid points label
				str.append(String.format("%1$-25s",header4));
			}
			// If normal category only use index k=2
			else if (categoryType.compareToIgnoreCase("N") == 0) {
				// Add category label
				str.append(String.format("%1$-"+categoryLabelLength[0]+"s",header3[2]));
				// Add num valid points label
				str.append(String.format("%1$-25s",header4));				
			}
			// If below normal category only use index k=1
			else if (categoryType.compareToIgnoreCase("A") == 0) {
				// Add category label
				str.append(String.format("%1$-"+categoryLabelLength[0]+"s",header3[3]));
				// Add num valid points label
				str.append(String.format("%1$-25s",header4));				
			}
			// If category type doesn't exist, error
			else {
				logger.fatal("Could not write to ASCII file, invalid category type : " + categoryType);
				Log.fatal("Report invalid category type for writing to ASCII file", "#errorPanelText");
			}
		} // End for each forecast source

		// Add new line
		str.append("\n");
		logger.debug("Length of stats array categories dimension: " + statsArray[0].length);
		logger.debug("Output dimension type is : " + settingsObj.getOutputDimension());
		logger.debug("Reference array length is : " + referenceArray.length);
		logger.debug("Size of last statsArray dimension : " + statsArray[0][0].length);

		// Fcst source
		logger.debug("stats array (dimension for ref array) : " + statsArray[0][0].length + " , " + statsArray[0].length + "," + statsArray.length);
		logger.debug("fcst source length : " + fcstSourceArray.length + " category " + statsArray[0].length + " ref array " + referenceArray.length);

		// Check to see if the reference array dimension is different than the
		// dimension of the stats array dimension that is supposed to be the reference array size
		// If these are different, the original data loaded likely didn't have the correct # points
		if (referenceArray.length != statsArray[0][0].length) {
			logger.fatal("The dimension in the stats array representing the reference output dimension does not match the dimension of reference points retrieved from the reference table. Stopping process.");
			throw new Exception("The dimension in the stats array representing the reference output dimension does not match the dimension of reference points retrieved from the reference table. Stopping process.");
		}

		// Below is just optional print of stats for logger trace level
		for (int j=0; j<fcstSourceArray.length;j++) {
			logger.trace("For fcst source : " + j);
			// For each category (total,B,N,A)
			for (int k=0;k<statsArray[0].length; k++) {
				logger.trace("For category : " + k);
				//For each of the reference values
				for (int i=0;i<referenceArray.length;i++) {
					logger.trace("at i = " + i + " stats = " + statsArray[j][k][i] + " | ref = " + referenceArray[i]);
				}
			}
		}
			
		// WRITE DATA
		if (validDataArray == null) {
			throw new Exception("Array with information about the valid data is null.");
		}
		try {
		// For each reference array value write date data
		for (int i=0; i<referenceArray.length;i++) {
			// If the output dimension is 'space', allow more space for location name
			if (settingsObj.getOutputDimension().compareToIgnoreCase("space") == 0) {
				str.append(String.format("%-28s",referenceArray[i]));
				str.append(String.format("%-8s",latArray[i]));
				str.append(String.format("%-8s",lonArray[i]));
			}
			else {
				str.append(String.format("%1$-15s",referenceArray[i]));
			}
			// For each forecast source write forecast source and score information
			for (int j=0; j<fcstSourceArray.length;j++) {
				// If separate category and RPSS, do not print any valid data array. Typically caught in validation earlier in run.
				if ((settingsObj.getScoreType().compareToIgnoreCase("rpss") == 0) &&  ((categoryType.compareToIgnoreCase("separate") == 0) || (categoryType.compareToIgnoreCase("B") == 0) || (categoryType.compareToIgnoreCase("N") == 0)  || (categoryType.compareToIgnoreCase("A") == 0)) ) {
					logger.fatal("Could not write to ASCII file, invalid category type for RPSS and separate categories case. Category type is : " + categoryType + ". Needs to be of value separate, B, N, or A in this case.");
					Log.fatal("Report invalid category type for writing to ASCII file", "#errorPanelText");
					throw new Exception("Could not write to ASCII file, invalid category type for RPSS and separate categories case (including for individual categories B,N, or A");
				}
				// For other cases do below logic, ie. category type is total. This writes the forecast source and stats and valid data info
				else {
					// Add forecast source info to string buffer
					str.append(String.format("%1$-"+fcstSourceLength[j]+"s",fcstSourceArray[j]));
					// For each index in the category dimension, write a value
					// The stats array always has the category values for total,B,N,A.
					// If total categories selected, write out 0th index
					if (categoryType.compareToIgnoreCase("total") == 0) {
						// Write the scores in the 'total' categories index
						str.append(String.format("%1$-"+categoryLabelLength[0]+"s",statsArray[j][0][i]));
						str.append(String.format("%1$-25s",validDataArray[j][0][i]));
					}
					// If separate categories, write out 1st, to last index
					else if (categoryType.compareToIgnoreCase("separate") == 0) {
						for (int k=1; k<statsArray[0].length; k++) {
							str.append(String.format("%1$-"+categoryLabelLength[0]+"s",statsArray[j][k][i]));
							str.append(String.format("%1$-25s",validDataArray[j][k][i]));
						}
					}
					// If below normal category only use index k=1
					else if (categoryType.compareToIgnoreCase("B") == 0) {
						str.append(String.format("%1$-"+categoryLabelLength[0]+"s",statsArray[j][1][i]));
						str.append(String.format("%1$-25s",validDataArray[j][1][i]));
					}
					// If normal category only use index k=2
					else if (categoryType.compareToIgnoreCase("N") == 0) {
						str.append(String.format("%1$-"+categoryLabelLength[0]+"s",statsArray[j][2][i]));
						str.append(String.format("%1$-25s",validDataArray[j][2][i]));
					}
					// If below normal category only use index k=1
					else if (categoryType.compareToIgnoreCase("A") == 0) {
						str.append(String.format("%1$-"+categoryLabelLength[0]+"s",statsArray[j][3][i]));
						str.append(String.format("%1$-25s",validDataArray[j][3][i]));
					}
					// If category type doesn't exist, error
					else {
						logger.fatal("Could not write to ASCII file, invalid category type : " + categoryType);
						Log.fatal("Report invalid category type for writing to ASCII file", "#errorPanelText");
					}
					
				} // End else not RPSS AND separate categories
			} // End fcst source loop
			// Add a new line to string buffer
			str.append("\n");
		} // End for each reference data row loop
		} catch(Exception e) {
			throw e;
		}
		logger.debug("Completed setting data String for file");
		// Try writing the buffered string to a file
		try {
			PrintWriter outfile = new PrintWriter(new FileOutputStream(file));
			outfile.println(str); // Write buffered string to file
			outfile.close();	// Close the file
		}
		catch(IOException e) {
			e.printStackTrace();
			Log.fatal("Cannot write to output file", "#errorPanelText");
		}
		logger.debug("Completed writing to output file");
	} // End method writeToAscii

} // End class WriteLibrary
