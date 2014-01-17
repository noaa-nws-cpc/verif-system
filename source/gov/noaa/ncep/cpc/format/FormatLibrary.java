package gov.noaa.ncep.cpc.format;

// Import needed packages
import gov.noaa.ncep.cpc.qc.Log;
import gov.noaa.ncep.cpc.qc.QCLibrary;
import gov.noaa.ncep.cpc.services.Results;
import gov.noaa.ncep.cpc.settings.Settings;
import gov.noaa.ncep.cpc.settings.SettingsHashLibrary;
import gov.noaa.ncep.cpc.stats.Stats;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.log4j.Logger;

/**
  Library of format functions including generic formatting and formatting for JClass.
 */
public class FormatLibrary {

	// Initialize variables
	private static String formattedData;
	private Settings settingsObj = null;
	static Logger logger = Logger.getLogger(gov.noaa.ncep.cpc.format.FormatLibrary.class);
	static String outputFormatData = null;

	/**
	  Returns a string of XML data of Stats object data formatted for a JClass chart. As long as the data object is loaded properly with a reference data array, then a chart can be created with any type of data.

	  This uses statistics data and settings data to create the formatted XML for JClass to use to create a line plot chart. This calls the XMLCreator class to build the XML. 
	  XMLCreator uses level-2 DOM to format the XML.
	  <p>
	  @param resultsObj Results object that is loaded with statistics data
	  @param settingsObj Settings object that is loaded with settings data
	  @return String of XML formatted data that JClass can read in to create a line plot chart.
	 */
	public static String formatForJClassLinePlot (Results resultsObj, Settings settingsObj) {
		// Desired format for displayed date display labels
		logger.debug("Get formatted date array");
		// Get information needed for the JClass chart
		String[] referenceArray = resultsObj.getReferenceArray();
		String[][][] scoreCatStringArray = resultsObj.getStats().getScoreCatStringArray();
		String categoryType = settingsObj.getCategoryType();
		String scoreType = settingsObj.getScoreType();
		logger.debug("Formatting for JClass line plot chart");
		// Get length of date array
		int numDateStringArrayCols = referenceArray.length;

		// Get dimensions of score array
		// Get number of dates/locations/bins
		int numScoreCatStringArrayCols = scoreCatStringArray[0][0].length;
		// Get number of models
		int numScoreCatStringArrayRows = scoreCatStringArray.length;

		logger.debug("number of dates/locations/bins = " + numScoreCatStringArrayCols);
		logger.debug("number of models = " + numScoreCatStringArrayRows);

		// Check if the referenceArray and scoreArray have the same # of columns
		if (numDateStringArrayCols == numScoreCatStringArrayCols) {
			logger.debug("The date and score arrays have the same # of data points : " + numDateStringArrayCols);
		}
		else {
			logger.debug("The date and score arrays do NOT have the same # of data points. Date String array has : " + numDateStringArrayCols + " and scoreCatStringArray has : " + numScoreCatStringArrayCols);
			// kill or throw exception?
		}

		String[] intXscoreCatStringArray = new String[numScoreCatStringArrayCols];
		logger.debug("intXscoreCatStringArray = " + intXscoreCatStringArray.length);

		//---------------------------------------------------------------------------
		// GET SETTINGS PARAMETERS
		// These are needed to format for JClass
		// These values will get formatted into XML

		// Set chart-data name , this is used in the title for the legend
		// Create this by using parts of the settings object
		// Set this to empty to maximize space for legend items.
		String chartDataName = "";

		// Get values of forecast sources for the data series sources
		String[] fcstSourceArray = settingsObj.getFcstSourceArray();

		//Create data point labels (in future can be submitted by a driver)
		//This array must be the same length as the # cols of dataArray
		for (int i=0;i<numDateStringArrayCols;i++) {
			// TO DO : Replace with reference values?
			int pointValue = i+1;
			intXscoreCatStringArray[i] = Integer.toString(pointValue);
		}
// 		logger.debug("***" + referenceArray.length + " ***** " + intXscoreCatStringArray.length + "****** " + numDateStringArrayCols);
// 		System.arraycopy(referenceArray,0,intXscoreCatStringArray,0,numDateStringArrayCols);
// 		for (int i=0;i<numDateStringArrayCols;i++) {
// 			// TO DO : Replace with reference values?
// 			//int pointValue = i+1;
// 			//intXscoreCatStringArray[i] = Integer.toString(pointValue);
// 			logger.debug("At index i= " + i + " intXscoreCatStringArray is : " + intXscoreCatStringArray[i]);
// 		}
		
		logger.debug("Num models are  " + scoreCatStringArray.length + " Num cats are " + scoreCatStringArray[0].length + " Num dates/locations/bins are " + scoreCatStringArray[0][0].length);
		// Convert 'NaN' values to 'hole' for JClass purposes
		// This allows the dwell (hover) labels to work properly
		for (int i=0;i<scoreCatStringArray.length;i++ ) { // #models
			for (int j=0;j<scoreCatStringArray[0].length;j++) { // #categories
				for (int k=0;k<scoreCatStringArray[0][0].length;k++) { // # dates/locations/bins
					// If a NaN value replace with 'hole'
					if (scoreCatStringArray[i][j][k].compareToIgnoreCase("NaN")==0) {
						scoreCatStringArray[i][j][k] = "hole";
					}
				}
			}
		}

		// Create a chart object
		try {
			Chart chart = new Chart(chartDataName,intXscoreCatStringArray,referenceArray,scoreCatStringArray,fcstSourceArray,categoryType,scoreType);
			// Call XML creator to create formatted XML for JClass
			XMLCreator xce = new XMLCreator(chart);
			// Perform function of creating the XML, pass argument for type of XML output
			// to format for ie., xce.createXML("chart"); will format for JClass chart
			xce.createXML("chart");
			logger.debug("Created chart var");
		// Set whether this document should contain a DOCTYPE header
			boolean containsDocType = true;
			// Call getString to build and write out the XML
			logger.debug("Before calling getString");
			formattedData = xce.getString(containsDocType, "Chart.dtd");
			logger.debug("Finished creating XML");
			logger.trace(formattedData);
			outputFormatData = formattedData;
		}
		catch (Exception e) {
			Log.fatal("Could not create a chart. Report a problem creating an XML chart object.", "#errorPanelText");
		}
		return outputFormatData;

	} // End formatForJClassLinePlot

	/**
	  Returns a string of XML data of Stats object data formatted for a JClass chart.
	  This uses statistics data to create the formatted XML for JClass to
	  use to create a chart. This calls the XMLCreator class to build the XML.
	  XMLCreator uses level-2 DOM to format the XML.
	  <p>
	  @param statsObj Stats object that is loaded with statistics data
	  @param settingsObj Settings object that is loaded with the settings
	  @return String of XML formatted data that JClass can read in to create a chart
	 */
	public static String formatForJClassReliabilityDiagram (Stats statsObj, Settings settingsObj) {
		float[] probabilityBinThresholdArray = statsObj.getProbabilityBinLowerThreshold();
		String[] probabilityBinThresholdStringArray = FormatLibrary.toStringArray(probabilityBinThresholdArray);
		float[] probabilityBinAxisLabels = statsObj.getProbabilityBinAxisLabels();
		String[] probabilityBinAxisLabelsStringArray = FormatLibrary.toStringArray(probabilityBinAxisLabels);

		String[][][] scoreCatStringArray = statsObj.getScoreCatStringArray();
		String[][][] aveFcstProbStringArray = statsObj.getAveFcstProbStringArray();
		String categoryType = settingsObj.getCategoryType();
		String scoreType = settingsObj.getScoreType();
		logger.debug("Formatting for JClass reliability diagram");
		logger.debug("scoreCatStringArray, model 0: " + Arrays.toString(scoreCatStringArray[0][0]) );
		logger.debug("aveFcstProbStringArray, model 0: " + Arrays.toString(aveFcstProbStringArray[0][0]) );

		// Get number of bins of probability thresholds
		int numProbStringArrayCols = probabilityBinThresholdStringArray.length;
		int numProbLabelsStringArray = probabilityBinAxisLabelsStringArray.length;

		// Get dimensions of score array
		// Get the number of bins
		int numScoreCatStringArrayCols = scoreCatStringArray[0][0].length;
		int numAveFcstProbStringArrayCols = aveFcstProbStringArray[0][0].length;
		// Get the number of models
		int numScoreCatStringArrayRows = scoreCatStringArray.length;

		logger.debug("number of scores bins = " + numScoreCatStringArrayCols);
		logger.debug("number of ave fcst prob bins = " + numAveFcstProbStringArrayCols);
		logger.debug("number of models = " + numScoreCatStringArrayRows);
		logger.debug("number of probs bins = " + numProbStringArrayCols);
		logger.debug("number of bin labels = " + numProbLabelsStringArray + " (should be 1 more than # of bins)");

		// Check if the probabilityBinThresholdStringArray and scoreArray have the same # of columns
		if ((numProbStringArrayCols == numScoreCatStringArrayCols) && (numProbStringArrayCols == numAveFcstProbStringArrayCols)) {
			logger.debug("The prob bin threshold and score arrays have the same # of data points : " + numProbStringArrayCols);
		}
		else {
			logger.warn("The prob bin threshold and data arrays do NOT have the same # of data points. Prob bin String array has : " + numProbStringArrayCols + ", scoreCatStringArray has : " + numScoreCatStringArrayCols + " , and ave fcst prob bin has : " + numAveFcstProbStringArrayCols);
			// kill or throw exception?
		}

		//---------------------------------------------------------------------------
		// GET SETTINGS PARAMETERS
		// These are needed to format for JClass
		// These values will get formatted into XML

		// Set chart-data name , this is used in the title for the legend
		// Create this by using parts of the settings object
		String chartDataName = "";

		// Get values of forecast sources for the data series sources
		// These are used to build the legend labels
		String[] fcstSourceArray = settingsObj.getFcstSourceArray();

		// Convert 'NaN' values to 'hole' for JClass purposes for y-values
		// This allows the dwell (hover) labels to work properly
		for (int i=0;i<scoreCatStringArray.length;i++ ) { // #models
			for (int j=0;j<scoreCatStringArray[0].length;j++) { // #categories
				for (int k=0;k<scoreCatStringArray[0][0].length;k++) { // # dates/locations/bins
					// If a NaN value replace with 'hole'
					if (scoreCatStringArray[i][j][k].compareToIgnoreCase("NaN")==0) {
						scoreCatStringArray[i][j][k] = "hole";
					}
				}
			}
		}
		// Convert 'NaN' values to 'hole' for JClass purposes for y-values
		//aveFcstProbStringArray
		try {
			// Create a chart object
			Chart chart = new Chart(chartDataName,probabilityBinAxisLabelsStringArray,aveFcstProbStringArray,scoreCatStringArray,fcstSourceArray,categoryType,scoreType);
						// Call XML creator to create formatted XML for JClass
			XMLCreator xce = new XMLCreator(chart);
			// Perform function of creating the XML, pass argument for type of XML output
			// to format for ie., xce.createXML("chart"); will format for JClass chart
			xce.createXML("chart");
			logger.debug("Created chart var");
			// Set whether this document should contain a DOCTYPE header
			boolean containsDocType = true;
			// Call getString to build and write out the XML
			logger.debug("Before calling getString");
			formattedData = xce.getString(containsDocType, "Chart.dtd");
			logger.debug("Finished creating XML");
			outputFormatData = formattedData;
		}
		catch (Exception e) {
			Log.fatal("Could not create a reliability chart. Report a problem creating a reliability XML chart object.", "#errorPanelText");
		}

		return outputFormatData;

	} // End formatForJClassReliabilityDiagram

	/**
	  Returns a string of XML data of Stats object data formatted for a Google Earth/Map (KML).
	  This uses statistics data and settings data to create the formatted KML for
	  Google Earth/maps to use to display. This calls the XMLCreator class to build the XML.
	  XMLCreator uses level-2 DOM to format the XML.
	  <p>
	  @param resultsObj Results object that is loaded with statistics data
	  @param settingsObj Settings object that is loaded with settings data
	  @param iconArray 1-D array of String values that represents the icons of each value of score in a score array, which should be contained in the stats object.
	  @return String of XML(KML) formatted data that Spatial
	 */
	public static String formatForGoogleEarth (Results resultsObj, Settings settingsObj, String[] iconArray) {
		outputFormatData = null; // Default initial String
		logger.debug("Formatting for Google Earth");
		// GET ARRAYS FOR FORMATTING
		// Get score String
		String[][][] scoreCatStringArray = resultsObj.getStats().getScoreCatStringArray();
		String categoryType = settingsObj.getCategoryType();

		// Get first model of score data since spatial can only plot one set of model data for a display.
		// Get the score data for the category to be verified (first dimension of the first index
		// corresponds to the first and only model)
		String[] firstScoreCatStringArray = null;
		int categoryIndex = -1;
		if (categoryType.equals("total")) {
			firstScoreCatStringArray = scoreCatStringArray[0][0];
			categoryIndex=0;
		}
		else if (categoryType.equals("B")) {
			firstScoreCatStringArray = scoreCatStringArray[0][1];
			categoryIndex=1;
		}
		else if (categoryType.equals("N")) {
			firstScoreCatStringArray = scoreCatStringArray[0][2];
			categoryIndex=2;
		}
		else if (categoryType.equals("A")) {
			firstScoreCatStringArray = scoreCatStringArray[0][3];
			categoryIndex=3;
		}
		logger.trace("Score Cat String is " + Arrays.toString(firstScoreCatStringArray));

		// Get location name array
		String[] locationNameArray = resultsObj.getLocationNameArray();
		for (int i = 0; i<locationNameArray.length;i++) {
			logger.trace("locationNameArray : " + locationNameArray[i]);
		}

		// Get location lon array
		String[] locationLonArray = resultsObj.getLocationLonArray();

		// Get location lat array
		String[] locationLatArray = resultsObj.getLocationLatArray();

		logger.trace("Longitude values are : " + Arrays.toString(locationLonArray));
		logger.trace("1st model of float data  is : " + Arrays.toString(firstScoreCatStringArray));

		// Check to see if dimensions of all the arrays needed are the same.
		// Since the scoreCatStringArray, which is 3-d (for all models), have the
		// same # cols, just pass the first row (1st model) of data to check
		// for the # cols matching other arrays used in the XML
		logger.debug("Checking if all arrays are the same size");
		boolean isArraySizeSame = QCLibrary.isSameSize(scoreCatStringArray[0][categoryIndex], locationNameArray, locationLonArray, locationLatArray, iconArray);
		logger.debug("Are Array sizes the same size for KML creation?  : " + isArraySizeSame);
		logger.debug("size of score array: " + scoreCatStringArray[0][categoryIndex].length);

		// If the sizes of arrays are not the same return a null String value.
		// Something in the arrays is not correct.
		if (!isArraySizeSame) {
			outputFormatData = null;
		}
		// If arrays are the same size, create the XML
		else {
			try {
				// Create a GoogleEarth object to format for
				GoogleEarth googleEarth = new GoogleEarth(locationNameArray, iconArray, firstScoreCatStringArray, locationLonArray, locationLatArray);
				// Call XML creator to create formatted XML for JClass
				XMLCreator xce = new XMLCreator(googleEarth);
				// Call XML creator to create formatted XML
				// Perform function of creating the XML, pass argument for type of XML output
				// to format for ie., xce.createXML("chart"); will format for JClass chart
				xce.createXML("googleEarth");
				// Set whether this document should contain a DOCTYPE header
				boolean containsDocType = false;
				formattedData = xce.getString(containsDocType, null);
				logger.debug("Finished creating XML");
				outputFormatData = formattedData;
			}
			catch (Exception e) {
				Log.fatal("Could not create a map of results. Report a problem creating a GoogleEarth object.", "#errorPanelText");
			}
		}
		return outputFormatData;
	} // End formatForGoogleEarth.

	/**
	  Overloaded method to convert an array of floats or ints to an array of Strings
	  <p>
	  @param f 2-d array of float values to convert to a 2-d String array
	  @return 2-d array of String values
	 */
	public static String[] toStringArray(float[] f) {
		logger.debug("Converting float array to String array");
		int m=f.length;
		String[] s = new String[m];
		logger.trace("m = " + m );
		for (int i=0; i<m; i++) {
			s[i] = Float.toString(f[i]);
		}
		return s;
	}
	/**
	  Overloaded method to convert an array of floats or ints to an array of Strings
	  <p>
	  @param f 2-d array of float values to convert to a 2-d String array
	  @return 2-d array of String values
	 */
	public static String[][] toStringArray(float[][] f) {
		logger.debug("Converting 2d float array to String array");
		int m=f.length;         // num of models
		int c=f[0].length;      // num of pts
		String[][] s = new String[m][c];
		logger.debug("m = " + m + " and c = " + c);
		for (int i=0; i<m; i++) {
			for (int j=0; j<c; j++) {
				s[i][j] = Float.toString(f[i][j]);
			}
		}
		return s;
	}
	/**
	  Overloaded method to convert an array of floats or ints to an array of Strings
	  <p>
	  @param f 3-d array of float values to convert to a 3-d String array
	  @return 3-d array of String values
	 */
	public static String[][][] toStringArray(float[][][] f) {
		logger.debug("Converting 3d float array to String array");
		int m=f.length;         // num of models
		int c=f[0].length;      // num of pts
		int r=f[0][0].length;
		String[][][] s = new String[m][c][r];
		logger.debug("m = " + m + " and c = " + c + " and r = " + r);
		for (int i=0; i<m; i++) {
			for (int j=0; j<c; j++) {
				for (int k=0; k<r; k++) {
					s[i][j][k] = Float.toString(f[i][j][k]);
				}
			}
		}
		return s;
	}
	/**
	  Overloaded method to convert an array of floats or ints to an array of Strings
	  <p>
	  @param f 2-d array of integer values to convert to a 2-d String array
	  @return 2-d array of String values
	 */
	public static String[][] toStringArray(int[][] f) {
		logger.info("Converting int array to String array");
		int m=f.length;         // num of models
		int c=f[0].length;      // num of pts
		String[][] s = new String[m][c];
		for (int i=0; i<m; i++) {
			for (int j=0; j<c; j++) {
				s[i][j] = Integer.toString(f[i][j]);
			}
		}
		return s;
	}
	/**
	  Overloaded method to convert an array of floats or ints to an array of Strings
	  <p>
	  @param f 3-d array of integer values to convert to a 3-d String array
	  @return 3-d array of String values
	 */
	public static String[][][] toStringArray(int[][][] f) {
		logger.info("Converting int array to String array");
		int m=f.length;         // num of models
		int c=f[0].length;      // num of pts
		int r=f[0][0].length;
		String[][][] s = new String[m][c][r];
		for (int i=0; i<m; i++) {
			for (int j=0; j<c; j++) {
				for (int k=0; k<r; k++) {
					s[i][j][k] = Integer.toString(f[i][j][k]);
				}
			}
		}
		return s;
	}

	/**
	Overloaded method to convert a a formatted String to a 1-D String array, according to the passed String regex delimiter. This can just be a simple character value. This method is the same as doing the Java split function.
	<br>
	Example:
	<br>
	Pass String strValue of "01,06;2000,2006,2010;ENSO" and the passed consecutive strings,
	delim1 as ";", and delim2 as "," so the call is toStringArray("01,06;2000,2006,2010;ENSO",";")<br>
	This method will split the String by semi-colons, which will be the
	content in each row.<br>
	This method returns 1-D array:<br>
	[01,06][2000,2006][ENSO]<br>
	@param strValue String formatted list to parse. It is delimited by the passed delimiter.
	@param delim1 Regex formatted delimiter. For example, to do semi-colon delimiter parsing, pass this value as "[;]"
	@return 2-D assymetrical array. Each row can have a different number of columns.
	*/
	public static String[] toStringArray(String strValue,String delim1) {
			logger.trace("Converting passed String " + strValue + " to a 1-D String array");
			String[] splitArray = strValue.split(delim1);
		return splitArray;
	}

	/**
	Converts a formatted String to a 2-D String array, according to the passed String regex delimiters. These can just be simple character values. The parsing would be done in the order of the first delimiter, then second delimiter passed as listed in the passed argument. The array is not necessarily symmetrical, meaning that the 2-D array can have rows with different columns. Look up regular expressions for more ways on parsing.
	<br>
	Example:
	<br>
	Pass String strValue of "01,06;2000,2006,2010;ENSO" and the passed consecutive strings,
	delim1 as ";", and delim2 as "," so the call is to2DStringArray("01,06;2000,2006,2010;ENSO",";",",")<br>
	This method will first split the String by semi-colons, which will be the
	content in each row, then it will split by commas, creating the columns
	of each associated row.<br>
	This method returns 2-D array:<br>
	[01][06]<br>
	[2000][2006]<br>
	[ENSO]<br>
	Note that this is an assymetrical array because the number of columns in each row of the array is not the same.
	@param strValue String formatted list to parse. It is delimited by 2 types
	of delimiters. The first delimiter specifies the String content for each row of the returned 2-D array, the second delimiter specifies the String content to further split by and returns the individual columns of each
	row of content.
	@param delim1 String of delimiter to parse passed String by first.
	@param delim2 String of delimiter to parse passed String by second.
	@return 2-D assymetrical array. Each row can have a different number of columns.
	*/
	public static String[][] to2DStringArray(String strValue,String delim1,String delim2) {
			String[][] split2DArray;
			logger.trace("Converting passed String " + strValue + " to a 2-D String array");
			String[] result = strValue.split(delim1);
			split2DArray = new String[result.length][];
			for (int i=0;i<result.length;i++) {
				split2DArray[i] = result[i].split(delim2);
			}
		return split2DArray;
	}

	/**
	  Rounds a single float value to the specified number of decimal places.
	  <p>
	  @param val Float value to round
	  @param dec number of decimal places to round to
	  @return rounded Float value
	  <p>
NOTE :  This method does not work for zero decimal places and it ignores NaNs.
If zero is entered for number of decimal places it will output .0 as in 17.0
because method accepts and returns a float.
	 */
	public static float roundToDecimal(float val, int dec) {
		float f;
		if (! ( Float.isNaN(val) ) ) {
			float p = (float)Math.pow(10,dec);
			float v = val * p;
			float tmp = Math.round(v);
			f = tmp/p;
		}
		else {
			f = Float.NaN;
		}
		return f;
	}
	/**
	  Rounds a 1-d array of float values to the specified number of decimal places.
	  <p>
	  @param val float[] value to round
	  @param dec number of decimal places to round to
	  @return rounded float[] value
	  <p>
NOTE :  This method does not work for zero decimal places and it ignores NaNs.
If zero is entered for number of decimal places it will output .0 as in 17.0
because method accepts and returns a float.
	 */
	public static float[] roundToDecimal(float val[], int dec) {
		int r = val.length;
		float[] f = new float[r];
		float[] v = new float[r];
		for (int i=0; i<r; i++) {
			if (! ( Float.isNaN(val[i]) ) ) {
				float p = (float) Math.pow(10,dec);
				v[i] = val[i] * p;
				float tmp = Math.round(v[i]);
				f[i] = tmp/p;
			}
			else {
				f[i] = Float.NaN;
			}
		}
		return f;
	}
	/**
	  Rounds a 2-d array of float values to the specified number of decimal places.
	  <p>
	  @param val float[][] value to round
	  @param dec number of decimal places to round to
	  @return rounded float[][] value
	  <p>
NOTE :  This method does not work for zero decimal places and it ignores NaNs.
If zero is entered for number of decimal places it will output .0 as in 17.0
because method accepts and returns a float.
	 */
	public static float[][] roundToDecimal(float val[][], int dec) {
		int r = val.length;
		int c = val[0].length;
		float[][] f = new float[r][c];
		float[][] v = new float[r][c];
		for (int i=0; i<r; i++) {
			for (int j=0; j<c; j++) {
				if (! ( Float.isNaN(val[i][j]) ) ) {
					float p = (float) Math.pow(10,dec);
					v[i][j] = val[i][j] * p;
					float tmp = Math.round(v[i][j]);
					f[i][j] = tmp/p;
				}
				else {
					f[i][j] = Float.NaN;
				}
			}
		}
		return f;
	}

	/**
	  Rounds a 3-d array of float values to the specified number of decimal places.
	  <p>
	  @param val float[][][] value to round
	  @param dec number of decimal places to round to
	  @return rounded float[][][] value
	  <p>
NOTE :  This method does not work for zero decimal places and it ignores NaNs.
If zero is entered for number of decimal places it will output .0 as in 17.0
because method accepts and returns a float.
	 */
	public static float[][][] roundToDecimal(float val[][][], int dec) {
		int r = val.length;
		int c = val[0].length;
		int m = val[0][0].length;
		float[][][] f = new float[r][c][m];
		float[][][] v = new float[r][c][m];
		for (int i=0; i<r; i++) {
			for (int j=0; j<c; j++) {
				for (int k=0; k<m; k++) {
					if (! ( Float.isNaN(val[i][j][k]) ) ) {
						float p = (float) Math.pow(10,dec);
						v[i][j][k] = val[i][j][k] * p;
						float tmp = Math.round(v[i][j][k]);
						f[i][j][k] = tmp/p;
					}
					else {
						f[i][j][k] = Float.NaN;
					}
				}
			}
		}
		return f;
	}

	/**
	Generates the filename of the image output by the Verification System.
	The name depends on the various settings set in the Settings object.

	@param  settingsObj  Settings object
	@param  resultsObj   Results object
	@return Image filename
	<p>
	NOTE: Here isthe template of how the graphics file name is created based on
	settings used in the run. Also an example of a file name is below the template.
	<p>
	Template : <br> variable_source_lead_aveWindow_spatialType_scoreType_categoryType_outputDimension_datesValidType_datesValid.png
	Example: verif_temp_manual_0pt5m_01m_grid2deg_heidke_separateCats_time_selectMonthsYears_01-06_2001-2006.png
	<br>
	Where the datesValid section replaces commas in the datesValid setting with dashes ('-') and semi-colons with underscores ('_') to separate the date specifications. The dates valid are in the format submitted in the original settings, not the reformatted version that puts a dummy day in the date for
	monthly/seasonal settings. The above example represents All January and June months in the years 2001 and 2006 (the dashes do not represent a range of continuously occuring dates unless it is a dateRange datesValidType. This would mean 01/2001,01/2006,06/2001,06/2006.
	<br> 
	*/
	public static String getImageFileName(Settings settingsObj, Results resultsObj) throws Exception {
		logger.debug("In getimageFileName");
		// Get settings from the Settings object
		String variable          = settingsObj.getVariable();
		String[] fcstSourceArray = settingsObj.getFcstSourceArray();
		String leadTime          = settingsObj.getLeadTime();
		String regionType        = settingsObj.getRegionType();
		String regions           = settingsObj.getRegions();
		String spatialType       = settingsObj.getSpatialType();
		String aveWindow         = settingsObj.getAveWindow();
		String outputDimension   = settingsObj.getOutputDimension();
		String categoryType      = settingsObj.getCategoryType();
		String datesValidType    = settingsObj.getDatesValidType();
		String datesValidOriginalFormat = settingsObj.getDatesValidOriginalFormat();
		String scoreType         = settingsObj.getScoreType();
		String fcstSource        = null;
		String datesValidStr     = "";
		// Image settings
		String prefix = "verif";

		// Image filename will either contain the fcst source (if
		// there's a single source) or the word "multi" (if there are
		// multiple fcst sources).
		if (fcstSourceArray.length > 1) {
			fcstSource = "multi";
		} else {
			fcstSource = fcstSourceArray[0];
		}
		logger.debug("Fcst Source Array = " + Arrays.toString(fcstSourceArray) + " - length = " + fcstSourceArray.length);

		if(resultsObj == null) {
			logger.warn("Data object has not properly been set or passed to the FormatLibrary getImageFileName() method.");
			Log.error("Report a data object null issue in FormatLibrary call.","#errorPanelText");
		}

		// Get lead time unit using Sql labelled word, this is done since
		// it is a full descriptive word and the method exists to conver the character of lead unit to a word
		String leadTimeUnit = SettingsHashLibrary.getSqlTimeUnit(leadTime.substring(leadTime.length()-1)).toLowerCase();
		String fileName;
		try {
			String[][] datesValidArray = to2DStringArray(datesValidOriginalFormat,";",",");
			for (int i=0;i<datesValidArray.length;i++) {
				for (int j=0;j<datesValidArray[i].length;j++) {
					// Convert comma-delimited items to '-' delimited unless it is the last array value
					if (j > 0) {
						datesValidStr = datesValidStr  + "-" + datesValidArray[i][j];
					}
					else {
						datesValidStr =  datesValidStr + datesValidArray[i][j];
					}
				}
				// Convert semi-colon delimited items to have a '_' unless it is the last array value
				if (i < datesValidArray.length-1) {
					datesValidStr = datesValidStr + "_";
				}
			}
			logger.trace("Final datesValidStr = " + datesValidStr);
		} catch (Exception e) {
			logger.fatal("Cannot parse the dates valid array.");
			Log.fatal("Error trying to parse the dates valid.","#errorPanelText");
			throw e;
		}
		try {
			// If category type is 'separate' or 'total' use the term 'Cats' in file name
			if ((settingsObj.getCategoryType().compareToIgnoreCase("separate") == 0) || (settingsObj.getCategoryType().compareToIgnoreCase("total") == 0)) {
				fileName =  prefix + "_" + variable + "_" + fcstSource + "_" + leadTime + "_" + aveWindow + "_" + SettingsHashLibrary.getSpatialTypeTableName(spatialType) + "_" + scoreType + "_" + categoryType + "Cats" + "_" + outputDimension + "_" + datesValidType + "_" + datesValidStr + ".png";
			}
			// Else (ie individual categories) use the term 'Cat' in file name
			else {
			 	fileName =  prefix + "_" + variable + "_" + fcstSource + "_" + leadTime + "_" + aveWindow + "_" + SettingsHashLibrary.getSpatialTypeTableName(spatialType) + "_" + scoreType + "_" + categoryType + "Cat" + "_" + outputDimension + "_" + datesValidType + "_" + datesValidStr + ".png";
			 }
		} catch (Exception e) {
			logger.fatal("Cannot get the image file name");
			Log.fatal("Cannot get the image file name","#errorPanelText");
			throw e;
		}
		return fileName;
	} // End getImageFileName
	
	/**
	Generates the filename of the ascii output by the Verification System.
	The name depends on the various settings set in the Settings object.
	The naming convention for the database tables is followed as closely
	as possible.

	@param  settingsObj  Settings object
	@param  resultsObj   Results object
	@return Ascii filename
	<p>
	NOTE: Here isthe template of how the graphics file name is created based on
	settings used in the run. Also an example of a file name is below the template.
	<p>
	Template : <br> variable_source_lead_aveWindow_spatialType_scoreType_categoryType_outputDimension_datesValidType_datesValid.txt
	Example: verif_temp_manual_0pt5m_01m_grid2deg_heidke_separateCats_time_selectMonthsYears_01-06_2001-2006.txt
	<br>
	Where the datesValid section replaces commas in the datesValid setting with dashes ('-') and semi-colons with underscores ('_') to separate the date specifications. 
	The dates valid are in the format submitted in the original settings, not the reformatted version that puts a dummy day in the date for
	monthly/seasonal settings. The above example represents All January and June months in the years 2001 and 2006 (the dashes do not represent a range of continuously occuring dates unless it is a dateRange datesValidType. This would mean 01/2001,01/2006,06/2001,06/2006.
	*/
	public static String getAsciiFileName(Settings settingsObj, Results resultsObj) throws Exception {
		// Get settings from the Settings object
		String variable          = settingsObj.getVariable();
		String[] fcstSourceArray = settingsObj.getFcstSourceArray();
		String leadTime          = settingsObj.getLeadTime();
		String regionType        = settingsObj.getRegionType();
		String regions           = settingsObj.getRegions();
		String spatialType       = settingsObj.getSpatialType();
		String aveWindow         = settingsObj.getAveWindow();
		String scoreType         = settingsObj.getScoreType();
		String outputDimension   = settingsObj.getOutputDimension();
		String categoryType      = settingsObj.getCategoryType();
		String datesValidType    = settingsObj.getDatesValidType();
		String datesValidOriginalFormat = settingsObj.getDatesValidOriginalFormat();
		String fcstSource        = null;
		String datesValidStr     = "";
		// Ascii settings
		String prefix = "verif";

		// Ascii filename will either contain the fcst source (if
		// there's a single source) or the word "multi" (if there are
		// multiple fcst sources).
		if (fcstSourceArray.length > 1) {
			fcstSource = "multi";
		} else {
			fcstSource = fcstSourceArray[0];
		}
		logger.debug("Fcst Source Array = " + Arrays.toString(fcstSourceArray) + " - length = " + fcstSourceArray.length);

		if(resultsObj == null) {
			logger.warn("Results object has not properly been set or passed to the FormatLibrary getAsciiFileName() method.");
			Log.error("Report a results object null issue in FormatLibrary call.","#errorPanelText");
		}
		String leadTimeUnit = SettingsHashLibrary.getSqlTimeUnit(leadTime.substring(leadTime.length()-1)).toLowerCase();
		String fileName;
		// Format datesValid, convert commas to '-', semi-colons to '_'.
		try {
			String[][] datesValidArray = to2DStringArray(datesValidOriginalFormat,";",",");
			for (int i=0;i<datesValidArray.length;i++) {
				for (int j=0;j<datesValidArray[i].length;j++) {
					// Convert comma-delimited items to '-' delimited unless it is the last array value
					if (j > 0) {
						datesValidStr = datesValidStr  + "-" + datesValidArray[i][j];
					}
					else {
						datesValidStr =  datesValidStr + datesValidArray[i][j];
					}
				}
				// Convert semi-colon delimited items to have a '_' unless it is the last array value
				if (i < datesValidArray.length-1) {
					datesValidStr = datesValidStr + "_";
				}
			}
			logger.trace("Final datesValidStr = " + datesValidStr);
		} catch (Exception e) {
			logger.fatal("Cannot parse the dates valid array.");
			Log.fatal("Error trying to parse the dates valid.","#errorPanelText");
			throw e;
		}
		try {
			// If category type is 'separate' or 'total' use the term 'Cats' in file name
			if ((settingsObj.getCategoryType().compareToIgnoreCase("separate") == 0) || (settingsObj.getCategoryType().compareToIgnoreCase("total") == 0)) {
				fileName =  prefix + "_" + variable + "_" + fcstSource + "_" + leadTime + "_" + aveWindow + "_" + SettingsHashLibrary.getSpatialTypeTableName(spatialType) + "_" + scoreType + "_" + categoryType + "Cats" + "_" + outputDimension + "_" + datesValidType + "_" + datesValidStr + ".txt";
			}
			// Else (ie individual categories) use the term 'Cat' in file name
			else {
			 	fileName =  prefix + "_" + variable + "_" + fcstSource + "_" + leadTime + "_" + aveWindow + "_" + SettingsHashLibrary.getSpatialTypeTableName(spatialType) + "_" + scoreType + "_" + categoryType + "Cat" + "_" + outputDimension + "_" + datesValidType + "_" + datesValidStr + ".txt";
			 }
			// 
		} catch (Exception e) {
			logger.fatal("Cannot get the ascii file name");
			Log.fatal("Cannot get the ascii file name","#errorPanelText");
			throw e;
		}
		return fileName;
	} // End getAsciiFileName

	/**
	  Returns a String format of a 1-d array. Convert Array to ArrayString.
	  @param stringArray 1-d String array to convert to String.
	  @param delimiter String of delimiter to use to separate array values.
	 */
	public static String arrayToString(String[] stringArray, String delimiter){
		String str = " ";
		for (int i = 0; i < stringArray.length; i++) {
			// If it is not the last item, put a delimiter following the item
			if(i != stringArray.length - 1) {
				str = str + stringArray[i] + delimiter;
			}
			else {
				str = str + stringArray[i];
			}

		}
		return str;
	}

	/**
	  Return a String format of concatenated arrays comma and semi-colon delimited. The arrays are separated by semi-colons, and the individual items in these arrays are separated by commas. Accepts any number of String arrays.
	  @param stringArray any number of arrays of String type.
		@return A string array.
	  <p>
	  Usage example :
	  String stringValue = FormatLibrary.arraysToString(arrayStr1, arrayStr1);
	 */
	// Note : Delimiters were not allowed to be passed as arguments, because this was tested,
	// and you cannot pass more than the varArgs specificed as a specific type.
	public static String arraysToString(String[] ... stringArray) {
		String sTemp; // Temporary string
		String fullString = " "; // String that will contain all the items
		// For each string array
		int i = 0;
		for(String[] s : stringArray) {
			// Convert the String array to a comma delimited string
			sTemp = arrayToString(s,",");
			// For each string array, put a semi-colon at the end unless it is the last String array passed
			if(i != stringArray.length - 1) {
				fullString = fullString + sTemp + ";";
			}
			else {
				fullString = fullString + sTemp;
			}
			i++;
		}
		return fullString;
	}

	/**
	Converts a comma-delimited String into an array of Strings.
	<p>
	For example:
	<ul>
	    "TX, LA, MS" --> ['TX','LA','MS']
	</ul>

	@param str  Comma-delimited string to convert
	@return     Array of Strings
	*/
	public static String[] stringToArray(String str){
		String[] stringArray = null;
		if (str != null || !str.equalsIgnoreCase("")){
			stringArray = str.split("[\\s]*[,][\\s]*");
		}
		logger.trace("Finished stringToArray");
		return stringArray;
	}

	/**
	Returns a String array of unique occurrences of values from a passed String array.
	@param arrayToCount String array of values to create a unique array of values from.
	@return String array of unique values from the passed array. The order of the elements
	in the array should be according to the order in the passed array.
	*/
	public static String[] getUniqueArray(String[] arrayToCount) {
		String[] uniqueArray = null;
		// Convert array to list
		List<String> arrayAsList = Arrays.asList(arrayToCount);
		// New unique list to populate
		List<String> uniqueList = new ArrayList<String>();

		for(String item : arrayAsList) {
			// If item does not exist in the uniqueList, add to uniqueList
			if (!uniqueList.contains(item)) {
				uniqueList.add(item);
			}
		}
		uniqueArray = (String[]) uniqueList.toArray(new String[0]);
		return uniqueArray;
	}

}  // end formatLibrary class
