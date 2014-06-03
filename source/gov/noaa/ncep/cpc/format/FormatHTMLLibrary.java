package gov.noaa.ncep.cpc.format;

// Import needed packages
import gov.noaa.ncep.cpc.qc.Log;
import gov.noaa.ncep.cpc.settings.Settings;
import gov.noaa.ncep.cpc.stats.Stats;
import gov.noaa.ncep.cpc.settings.SettingsHashLibrary;

import org.apache.log4j.Logger;

/**
  Library of format functions related to HTML formatting.
 */
public class FormatHTMLLibrary {
	// Initialize variables
	static protected Logger logger; // log4j Logger


	/**
	  Returns a String of text formatted with HTML of the score statistics summary. This requires a 3-d array of selected score summary information (ie. min/max values, etc.) as well as a properly loaded settings object. For example, this method can be called to get text to display on a page.
	  <p>
	  Usage Notes :
	  <p>
	  To obtain summary statistics :
	  <p>
	  1) Call StatsLibrary.getScoreSummaryEachModel() from the stats package to get the array of score summaries that need to be passed to this method.
	  <p>
	  3) Call this method to format the score summary with settings information to build summary text formatted in HTML.

	  @param scoreSummaryArray -3-D array of model score information (obtained by calling StatsLibrary.getScoreSummaryArrayEachModel() in the stats package).
	  @param settingsObj - settings object containing settings.
	  @param referenceText - String used in HTML to associate the scores with reference information. For example, if the scoreSummaryArray contains associated dates with the score summary, the wording of displayed results should use "...${score} on ${date}. You would set referenceText as "on" in this case to get the proper HTML.
	  @return String of HTML formatted text with score summaries.
	  <p> Where the rows in scoreSummaryArray are for each model, the columns contain score summary information for the model.
	 */
	public static String getSummaryHTMLText(String[][][] scoreSummaryArray, Settings settingsObj, String referenceText) {

		logger = Logger.getLogger(FormatHTMLLibrary.class.getName()); // Get logger
		String text = null;
		// Check to see if the scoreSummaryArray or settings object is null
		if (scoreSummaryArray == null) {
			logger.warn("Error, HTML formatted score summary cannot be obtained. The score summary array is null. Make sure that you have loaded and obtained the score summary array properly. Make sure that you have correctly passed an array of scores.");
		}
		else {
			try {
				// Build the text of the summary based on information from the scoreSummaryArray
				// Note : In text below, do not end with closing the </html> tag.
				// If you put this in, the concat of other text will not work
				int numSources = scoreSummaryArray.length;
				logger.debug("# rows in scoreSummaryArray is : " + numSources);
				//---------------------------------------------------
				// Parse string of forecast sources into a String array
				//---------------------------------------------------
				String fcstSources = settingsObj.getFcstSources();
				logger.debug("String of long forecast sources is : " + fcstSources);
				String delims = "[,]"; // Syntax that denotes separate items
				String[] fcstSourcesArray = fcstSources.split(delims);
				// Check to see if the # rows in scoreSummaryArray is the same as the # fcst sources
				if (fcstSourcesArray.length != scoreSummaryArray.length) {
					logger.warn("# of forecast sources (" + fcstSourcesArray.length + ")" + " is NOT the same as the number of rows in the score summary array (" + scoreSummaryArray.length + "). Therefore results will only display for all available forecast sources.");
				}
				// Print summary heading
				text = "<h3>Summary of results</h3>";

				// Create text associated with each of the categories to use in the info panel text
				// The number of elements should be identical to the category array size
				String[] categoryText = {"<font color=\"blue\">including all categories</font>","the <font color=\"blue\">below normal category</font>","the <font color=\"blue\">normal category</font>", "the <font color=\"blue\">above normal category</font>"};
				// Determine the categories to print score info for
				logger.debug("categoryType is " + settingsObj.getCategoryType());
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
				logger.debug("Printing score info for categories from " + startIndex + " to " + endIndex);
				// Dimensions of scoreSummaryArray are 
				//[model][category][max|max reference points|min|min reference points|ave|# values making up ave|# values making up max| # values making up min]
				//---------------------------------------------------
				// Print the average scores
				//---------------------------------------------------
				// Loop over categories
				for (int j=startIndex;j<(endIndex+1);j++) {
					text = text.concat("<font>The <i>average</i> " + settingsObj.getScoreType() + " score(s) for "+ categoryText[j] +" for the : </font>");
					text = text.concat("<ul>");
					// Loop over forecasts
					for (int i=0; i<fcstSourcesArray.length; i++) {
						// If
						text = text.concat("<li><font>" + fcstSourcesArray[i] + " forecast is <font color=\"red\">" + scoreSummaryArray[i][j][4] + "</font> " + " with " + scoreSummaryArray[i][j][5] + " values</font></li>");

					}
					text = text.concat("</ul>");
// 					// Print a line to separate the text output for each category
// 					if (settingsObj.getOutputType().equals("chart") && settingsObj.getCategoryType().equals("separate") && j<endIndex) {
// 						text = text.concat("<hr>");
// 					}
				} // End category loop
				text = text.concat("<hr>");
				//---------------------------------------------------
				// Print the highest scores
				//---------------------------------------------------
				// Loop over categories
				for (int j=startIndex;j<(endIndex+1);j++) {
					text = text.concat("The <i>highest</i> " + settingsObj.getScoreType() + " score(s) for "+ categoryText[j] +"  for the :");
					text = text.concat("<ul>");
					// Loop over forecasts
					for (int i=0; i<fcstSourcesArray.length; i++) {
						// If spatialType is 'gridded' display the # of locations instead of list
						// The referenceText is replaced with "at" in this situation.
						if (settingsObj.getSpatialType().compareToIgnoreCase("gridded")==0) {
							text = text.concat("<li>" + fcstSourcesArray[i] + " forecast is <font color=\"red\">" + scoreSummaryArray[i][j][0] + "</font> " + "at " + scoreSummaryArray[i][j][6] + " location(s) </li>");
						}
						else {
							text = text.concat("<li>" + fcstSourcesArray[i] + " forecast is <font color=\"red\">" + scoreSummaryArray[i][j][0] + "</font> " + referenceText + " " +  scoreSummaryArray[i][j][1] + " </li>");
						}
					}
					text = text.concat("</ul>");
				} // End category loop
				text = text.concat("<hr>");
				//---------------------------------------------------
				// Print the lowest scores
				//---------------------------------------------------
				// Loop over categories
				for (int j=startIndex;j<(endIndex+1);j++) {
					text = text.concat("The <i>lowest</i> " + settingsObj.getScoreType() + " score(s) for "+ categoryText[j] +"  for the :");
					text = text.concat("<ul>");
					// Loop over forecasts
					for (int i=0; i<fcstSourcesArray.length; i++) {
						// If spatialType is 'gridded' display the # of locations instead of list
						// The referenceText is replaced with "at" in this situation.
						if (settingsObj.getSpatialType().compareToIgnoreCase("gridded")==0) {
							text = text.concat("<li>" + fcstSourcesArray[i] + " forecast is <font color=\"red\">" + scoreSummaryArray[i][j][2] + "</font> " + "at " + scoreSummaryArray[i][j][7] + " location(s) </li>");
						}
						else {
							text = text.concat("<li>" + fcstSourcesArray[i] + " forecast is <font color=\"red\">" + scoreSummaryArray[i][j][2] + "</font> " + referenceText + " " + scoreSummaryArray[i][j][3] + " </li>");
						}
					}
					text = text.concat("</ul>");
				} // End category loop
				text = text.concat("<hr>");
				logger.trace("Return HTML Text : " + text);
			} // End try
			catch (Exception e) {
				logger.warn("Could not return HTML formatted score summary. Check that the scoreSummaryArray and settings object was properly loaded.");
				Log.error("Could not return a score summary. Report score summary loading/creation problem.","#errorPanelText");
			}
		}
		return text;
	}

    /**
	Returns a String of text formatted with HTML of the number of forecasts for each bin for the reliability diagram. This requires a properly loaded stats and settings object. For example, this method can be called to get text to display on a page.
	*/
    public static String getSummaryHTMLTextReliability(Stats statsObj, Settings settingsObj) {
		logger = Logger.getLogger(FormatHTMLLibrary.class.getName()); // Get logger
	    String text = null;
		String[][][] goodDataCount = statsObj.getGoodDataCountStringArray();
		String[] probabilityBinLabels = statsObj.getProbabilityBinLabels();
		String[] category = SettingsHashLibrary.getCategoryNames();

		// Parse string of forecast sources into a String array
		String fcstSources = settingsObj.getFcstSources();
        logger.debug("String of long forecast sources is : " + fcstSources);
		String delims = "[,]"; // Syntax that denotes separate items
		String[] fcstSourcesArray = fcstSources.split(delims);

        // Determine the categories to print score info for
		logger.debug("categoryType is " + settingsObj.getCategoryType());
		int startIndex = 0;
		int endIndex = 0;
		if (settingsObj.getCategoryType().equals("separate")) {
			startIndex = 1;
			endIndex = 3;
		}

		// Print summary heading
		text = "<h3>Summary of results</h3>";

		// Dimensions of goodDataCount are [model][category][bin]
	    // Loop over categories
		if (settingsObj.getCategoryType().equals("separate")) {
			text = text.concat("<h4><font>The number of forecasts per forecast probability bin:</font></h4>");
		}
		//text = text.concat("<br>");
	    for (int j=startIndex;j<(endIndex+1);j++) {
            if (category[j].equals("B")) {
				text = text.concat("<font>Forecast category : <font color=\"blue\"> Below Normal </font></font>");
			}
			else if (category[j].equals("A")) {
				text = text.concat("<font>Forecast category : <font color=\"blue\"> Above Normal </font></font>");
			}
			else if (category[j].equals("N")){
				text = text.concat("<font>Forecast category : <font color=\"blue\"> Normal </font></font>");
			}
			else {
				//text = text.concat("<font size=\"3.5\">All forecast categories together" + "</font>");
				text = text.concat("<h4><font>The number of forecasts per forecast probability bin for all categories together:</font></h4>");
			}
			if (settingsObj.getCategoryType().equals("separate")) {
				text = text.concat("<br>");
			}
			text = text.concat("<div class='wrapper'><table cellspacing=\"0\" cellpadding=\"6\" border=\"1\">");
			// Create title for row of probabilities
			text = text.concat("<tr>");
			text = text.concat("<th></th>");
			text = text.concat("<th colspan=\"" + probabilityBinLabels.length + "\" style=\"text-align: center;\">Forecast probability bins" + "</th>");
			text = text.concat("</tr>");
			// Next level of headers
			text = text.concat("<tr>");
			text = text.concat("<th style=\"text-align: center;\">Forecast</th>");
			// Create row of header columns with probability bin labels
			for (int k=0; k<probabilityBinLabels.length; k++) {
				text = text.concat("<th style=\"text-align: center;\"><font>" + probabilityBinLabels[k] + "</font></th>");
			}
			text = text.concat("</tr>");
			// For each forecast, write the forecast source on the first column, followed by the counts
			// in the following columns in the same row
			for (int i=0; i<fcstSourcesArray.length; i++) {
				text = text.concat("<tr>");
				text = text.concat("<td style=\"text-align: center;\"><b><font>" + fcstSourcesArray[i] + "</font></b></td>");
				//text = text.concat("<ul>");
				for (int k=0; k<probabilityBinLabels.length; k++) {
					text = text.concat("<td style=\"text-align: center;\"><font>" + goodDataCount[i][j][k] + "</font></td>");
				}
				//text = text.concat("</ul>");
				text = text.concat("</tr>");
			}
			//text = text.concat("</tr>");
			text = text.concat("</table></div>");
			text = text.concat("<br>");
		}
		logger.trace("Return HTML Text : " + text);
		return text;
	}

} // End FormatHTMLLibrary
