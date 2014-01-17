package gov.noaa.ncep.cpc.format;

//---------------------------------------------------------
// Import all packages needed
//---------------------------------------------------------
import gov.noaa.ncep.cpc.qc.Log;
import gov.noaa.ncep.cpc.services.Results;
import gov.noaa.ncep.cpc.settings.Settings;

import java.util.Arrays;

import org.apache.log4j.Logger;
/**
Peforms formatting functions for Stats objects.
*/
public class Format {

	// Get logger
	static Logger logger = Logger.getLogger(gov.noaa.ncep.cpc.format.Format.class);

	public static String getFormattedData(Results results, Settings settings) {
	  Format formatObj = new Format();
	  
	// Call the formatData() method, which accepts statsObj (for now - not sure where all the other variables needed in Format class are being declared, can change to just passing the specific vars later)
	// and outputType as its input, determines what kind
    	// of formatted data to output (chart, map, table), then calls the appropriate method(s).
    	logger.info("Formatting the data for output...");
    	try {
      		formatObj.formatData(results, settings);
    	} catch (Exception e) {
      		logger.fatal("Cannot format data to properly display results. Problem calling formatObj.formatData(statsObj, settingsObj). This may be because the type of output (outputType) does not use a method called by the format object. For example, ASCII output requires that WriteLibrary class methods be used, and called seprately than this.");
    	}
    	logger.debug("Finished formatting the data for output...");
    
    	return formatObj.getFormattedData();
	} // End getFormattedData
	
	
	//-----------------------------------------------------
	// Initialize variables
	//-----------------------------------------------------
	// Currently this program allows formatting only for a string.
	// This includes a string of formatted XML for JClass charts
	// or a single value.
	private String formattedOutputData = null ;  // score data after it is reformatted

	/**
	Constructor, creates a Format object
	*/
	public Format() {
	}

	/**
	Formats a Stats object depending on the output type set by the settings object.
	Determines what method to call in the FormatLibrary depending on the output type.
	The settings object should contain the outputType variable, a String representing
	the type of output to format for.
	<p>
	Included formatting functions :
	<ul>
	<li>chart - the settings object would have outputType = "chart"
	<li>map - the settings object would have outputType = "map"
	</ul>
	<p>
	@param resultsObj Results object. This must have all the appropriate stats content loaded into it.
	@param settingsObj Settings Ojbect. This must have all the appropriate settings
	loaded into it.
	*/
	public void formatData(Results resultsObj, Settings settingsObj) {
		// Get logger
		logger = Logger.getLogger(Format.class.getName());
		String scoreType = null;
		String categoryType = null;
		logger.trace("In method formatData");
		// Info from settings object is used to call appropriate methods to format and plot the output.  These methods are based on the type of plot (chart, map, table).

		if (settingsObj.getOutputType().equals("chart")) {
			// If scoreType is heidke, rpss, or brier
			if ( !(settingsObj.getScoreType().equals("reliability")) ) {
				logger.debug("Formatting output for JClass line plot chart!");
				// Get series labels, this is the label associated with each row of data
				// in scoreArray, ie. model labels. This is used to identify the type of lines
				// displayed in the legend

				// Call format method
				formattedOutputData = FormatLibrary.formatForJClassLinePlot(resultsObj, settingsObj);
			}
			else if (settingsObj.getScoreType().equals("reliability")) {
				logger.debug("Formatting for JClass reliability diagram!");
				formattedOutputData = FormatLibrary.formatForJClassReliabilityDiagram(resultsObj.getStats(), settingsObj);
			}
		}

		else if (settingsObj.getOutputType().equals("map")) {
// 			try {
				// Get score type
				scoreType = settingsObj.getScoreType();
				categoryType = settingsObj.getCategoryType();
				float[][][] scoreCatFloatArray = resultsObj.getStats().getScoreCatFloatArray();
				// If the selected scoreType is one of the available scores to get the icon map for, get the icon map. To see if a score is included or available for icon mapping, check the arrays listed in IconMap.java in the format package.
				if (scoreType.compareToIgnoreCase("heidke")  == 0 || scoreType.compareToIgnoreCase("brier")  == 0 || scoreType.compareToIgnoreCase("rpss")  == 0 ) {
					// Get icon map, associated icons for each score value
					String[] iconArray = null;
					// Determine which category is being verified to pass scores for that category to icon method
					// Use the first index of the first dimension of score array. Spatial map should only
					// contain one model of data.
					if (categoryType.equals("total")) {
						iconArray = IconMap.getIconMap(scoreType, scoreCatFloatArray[0][0]);
					}
					else if (categoryType.equals("B")) {
						iconArray = IconMap.getIconMap(scoreType, scoreCatFloatArray[0][1]);
					}
					else if (categoryType.equals("N")) {
						iconArray = IconMap.getIconMap(scoreType, scoreCatFloatArray[0][2]);
					}
					else if (categoryType.equals("A")) {
						iconArray = IconMap.getIconMap(scoreType, scoreCatFloatArray[0][3]);
					}
					logger.trace("Icon array is : " + Arrays.toString(iconArray));
					// Call format method
					formattedOutputData = FormatLibrary.formatForGoogleEarth(resultsObj, settingsObj, iconArray);
					logger.trace("Formatted data is : " + formattedOutputData);
				} //End if
// 			} // End try
// 			catch (Throwable e) {
// 				logger.fatal("Exception thrown, could not format for spatial type " + scoreType);
// 			}
		}
		// If the output type is "ascii", formatting is done in WriteLibrary
		// no separate formatting is done, so just call the WriteLibrary.writeToAscii in the initation driver calling this
		else if (settingsObj.getOutputType().equals("ascii")) {
			logger.info("Output type selected is 'ascii'. No formatting is needed, so this formatData() call will not do anything. The initiation driver (ie. StaticRunDriver.java) should call WriteLibrary.writeToAscii() in the format package.");
		}
		else if (settingsObj.getOutputType().equals("table")) {
			logger.fatal("Code to format for a table does not exist yet.");
		}
		else {
			logger.warn("Not a valid output type to format for : " + settingsObj.getOutputType());
			Log.fatal(settingsObj.getOutputType() + " is not a valid output type. Try selecting another tab format at the top (ie. chart or map.)", "#errorPanelText");
		}
	} // end formatData

	/**
	Gets the formatted output data. This formatted data can be retrieved after performing
	formatData. This retrieves the results of the formatData method.
	*/
	public String getFormattedData() {
		return formattedOutputData;
	}


}
