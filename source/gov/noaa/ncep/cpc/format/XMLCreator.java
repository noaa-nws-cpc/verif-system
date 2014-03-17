package gov.noaa.ncep.cpc.format;

import gov.noaa.ncep.cpc.qc.Log;
import gov.noaa.ncep.cpc.settings.SettingsHashLibrary;

import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.Logger;
import org.apache.xml.serialize.OutputFormat;
import org.apache.xml.serialize.XMLSerializer;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Text;

/**
Creates XML output from input data. Contains functions creating formatted XML of different schemas. Currently contains formatting functionality for a JClass line plot chart.
*/
public class XMLCreator {

	// Initialize variables
	//No generics
	List myData;
	Document dom;

	// A character stream that collects its output in a string buffer, which can then be used to construct a string.
	StringWriter writer = new StringWriter();
	static Logger logger = Logger.getLogger(gov.noaa.ncep.cpc.format.XMLCreator.class);

	// Overload constructor methods for different XML format types
	// Constructor method(s)
	// Pass an object with the values for a format type

	// ** TO ADD A FORMAT TYPE - Add an overloaded constructor method passing
	// the appropriate object of the format type

	/**
	Constructor for a chart formatted object
	*/
	public XMLCreator(Chart chart) {
		//create a list to hold the data
		myData = new ArrayList();
		// initialize the list
		myData.add(chart);
		// Get a DOM object
		createDocument();
	}

	/**
	Constructor for a GoogleEarth formatted object (not completed)
	*/
	public XMLCreator(GoogleEarth googleEarth) {
		//create a list to hold the data
		myData = new ArrayList();
		//initialize the list
		myData.add(googleEarth);
		//Get a DOM object
		createDocument();
	}


	/**
	Constructor for a table formatted object (not completed)
	*/
	public XMLCreator(Table table) {
		//create a list to hold the data
		myData = new ArrayList();
		//initialize the list
		myData.add(table);
		//Get a DOM object
		createDocument();
	}

	/**
	Creates XML formatted data by creating a DOM tree of XML for the specified format type desired.
	<p>
	@param formatType type of output to format for (Current options : "chart", "googleEarth")
	*/
	public void createXML(String formatType){
		// Create DOM Tree
		createDOMTree(formatType);

		logger.debug("Started creating XML for " + formatType);
		logger.debug("Generated file successfully");
	}

	/**
	Creates the XML document using DOM DocumentBuilderFactory.
	*/
	private void createDocument() {
		//get an instance of factory
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		try {
			//get an instance of builder
			DocumentBuilder db = dbf.newDocumentBuilder();
			//create an instance of DOM
			dom = db.newDocument();
		}catch(ParserConfigurationException pce) {
			logger.fatal("Error while trying to instantiate DocumentBuilder " + pce);
			Log.fatal("Error encountered while trying to create back-end formatted results. Report a DocumentBuilderFactory problem.", "#errorPanelText");
			System.exit(1);
		}
	}

	/**
	 * Main function that creates the DOM tree of XML. Called by the createXML(formatType) method.
	<p>
	@param formatType type of output to format for (ie. chart, table, etc.).
	 */
	private void createDOMTree(String formatType) {
		// ** TO ADD A FORMAT TYPE - Add a logic block for the format type
		// Print out format type
		logger.debug("Creating DOM Tree for type : " + formatType);
		//------------------------------------------
		// Create DOM Tree for chart type
		if (formatType.equals("chart")) {
			// Iterate over the data
			logger.debug("In createDOMTree() for type chart");
			Iterator it  = myData.iterator();
			while(it.hasNext()) {
				Chart chart = (Chart)it.next();
				//For each Chart object create a chart element in the Chart object.
				Element chartEle = null;
				if (!(chart.getScoreType().equals("reliability"))) {
					chartEle = createChartElementTimeseries(chart);
				}
				else {
					chartEle = createChartElementReliability(chart);
				}
				// Attach the chart element to the dom
				dom.appendChild(chartEle);
			}
		}
		// End createDOMTree for chart type
		//------------------------------------------

		//------------------------------------------
		// Create DOM Tree for googleEarth type
		else if (formatType.equals("googleEarth")) {
			//No enhanced for
			Iterator it  = myData.iterator();
			while(it.hasNext()) {
				GoogleEarth googleEarth = (GoogleEarth)it.next();
				//For each googleEarth object create google earth element
				Element googleEarthEle = createGoogleEarthElement(googleEarth);
				// Attach the googleEarth element to the dom
				dom.appendChild(googleEarthEle);
			}
		}
		// End createDOMTree for chart type
		//------------------------------------------

		//------------------------------------------
		// Create DOM Tree for table
		else if (formatType.equals("table")) {
			logger.info("Creating Table format: " + formatType);
		}
		// If a formatType was passed but no methods exist for this formatting,
		// display an error
		else {
			Log.fatal("Error encountered creating back-end formatted XML. Try selecting another result format (tabs at top)", "#errorPanelText");
			throw new RuntimeException("Invalid formatType submitted for createDOMTree in XMLCreator.class");
		}

	} // End createDOMTree()

	//------------------------------------------
	// Create DOM Tree(s) for various format types
	// ** TO ADD A FORMAT TYPE - Add a method to create the element(s) to
	// add to the root element
	//------------------------------------------
	/**
	 * Helper method which creates a XML element <Chart>
	 * @param chart The chart for which we need to create an xml representation
	 * @return XML element snippet representing a chart
	 */

	//------------------------------------------
	// Create googleEarth element(s)
	//------------------------------------------
	/**
	Creates chart elements in appropriate XML structure.
	**/
	private Element createGoogleEarthElement(GoogleEarth googleEarth){
		Element kmlEle = dom.createElement("kml");
		kmlEle.setAttribute("xmlns","http://www.opengis.net/kml/2.2");

		// Create <document> element
		Element googleEarthEle = dom.createElement("Document");

		// Get needed arrays of data
		String[] locationNameArray = googleEarth.getLocationNameArray();
		String[] styleArray = googleEarth.getStyleArray();
		String[] descriptionArray = googleEarth.getDescriptionArray();
		String[] lonArray = googleEarth.getLonArray();
		String[] latArray = googleEarth.getLatArray();

		// For each locationName index, create a <Placemark> and nested tags
		for (int i=0; i<locationNameArray.length; i++) {
			// Create <Placemark> element
			Element placemarkEle = dom.createElement("Placemark");
			// Location name
			Element nameEle = dom.createElement("Name");
			Text nameText = dom.createTextNode(locationNameArray[i]);
			nameEle.appendChild(nameText);
			placemarkEle.appendChild(nameEle);
			// styleURL
			Element styleEle = dom.createElement("StyleURL");
			Text styleText = dom.createTextNode(styleArray[i]);
			styleEle.appendChild(styleText);
			placemarkEle.appendChild(styleEle);
			// Description
			Element descriptionEle = dom.createElement("Description");
			Text descriptionText = dom.createTextNode(descriptionArray[i]);
			descriptionEle.appendChild(descriptionText);
			placemarkEle.appendChild(descriptionEle);
			//Point (commented out for verification specific KML)
// 			Element pointEle = dom.createElement("point");
			// Point - longitude
			Element lonEle = dom.createElement("Lon");
			Text lonText = dom.createTextNode(lonArray[i]);
			lonEle.appendChild(lonText);
			placemarkEle.appendChild(lonEle);
// 			pointEle.appendChild(lonEle);
			// Point - latitude
			Element latEle = dom.createElement("Lat");
			Text latText = dom.createTextNode(latArray[i]);
			latEle.appendChild(latText);
			placemarkEle.appendChild(latEle);
			//pointEle.appendChild(latEle);
			// Append point to placemark
// 			placemarkEle.appendChild(pointEle);
			// Attach placemarks to doc
			googleEarthEle.appendChild(placemarkEle);
			kmlEle.appendChild(googleEarthEle);
		}
		return kmlEle;

	}
	//------------------------------------------
	// Create chart element(s)
	//------------------------------------------
	/**
	Creates chart elements in appropriate XML structure for a timeseries (score types other than reliability).
	Puts data for JClass in array format (one single set of x values for all sets of y values).
	**/
	private Element createChartElementTimeseries(Chart chart){
		String categoryLabel;
		Matcher matcher;
		Pattern pattern;
		//rootEle.setAttribute("name",chart.getChartName());
		logger.trace("In createChartElementTimeseries(chart)");	
		String[] category = SettingsHashLibrary.getCategoryNames();
		// Set chart name
		Element chartEle = dom.createElement("chart-data");
		chartEle.setAttribute("name", chart.getChartName());

		// Get array of point (reference) values (the dates)
		String[] referenceArray = chart.getChartReferenceArray();

		// Get size of reference array
		int numDateCols = referenceArray.length;

		//------------------------------------------
		// Create xml data point labels (values are dates)
		//------------------------------------------
		for (int i=0;i<referenceArray.length;i++) {
			Element dataPointLabelEle = dom.createElement("data-point-label");
			Text dataPointLabelText = dom.createTextNode(referenceArray[i]);
			dataPointLabelEle.appendChild(dataPointLabelText);
			chartEle.appendChild(dataPointLabelEle);
		}

		// Get array of data labels (forecast sources)
		String[] fcstSourceArray = chart.getFcstSourceArray();
		// Get array of score values
		String[][][] scoreArray = chart.getScoreArray();
		// Get number of dates
		int numDataCols = scoreArray[0][0].length;
		// Get the number of categories
		int numCats = scoreArray[0].length;
		// Get the number of models
		int numDataRows = scoreArray.length;
		logger.debug("Number of dates of data is " + numDataCols);
		logger.debug("Number of cats of data is " + numCats);
		logger.debug("Number of models of data is " + numDataRows);

		// Determine categories to create xml for
		logger.debug("categoryType = " + chart.getCategoryType());
		logger.debug("scoreType = " + chart.getScoreType());
		int startIndex = 0;
		int endIndex = 0;
		// If categoryType is "separate", include all categories
		if (chart.getCategoryType().equals("separate")) {
			startIndex = 1;
			endIndex = 3;
		}
		// if categoryType is "total", just do the total score (index 0)
		else if (chart.getCategoryType().equals("total")) {
			startIndex = 0;
			endIndex = 0;
		}
		// if categoryType is "B", just do the total score (index 1)
		else if (chart.getCategoryType().equals("B")) {
			startIndex = 1;
			endIndex = 1;
		}
		// if categoryType is "N", just do the total score (index 2)
		else if (chart.getCategoryType().equals("N")) {
			startIndex = 2;
			endIndex = 2;
		}
		// if categoryType is "A", just do the total score (index 3)
		else if (chart.getCategoryType().equals("A")) {
			startIndex = 3;
			endIndex = 3;
		}
		logger.debug("Creating xml for first model for categories from " + startIndex + " to " + endIndex);

        // Use a counter to determine the dataset number since only
		// the first dataset needs an xAxis-series element
		int datasetNumber = 0;


		// Create xml data-series elements for each chart dataset
        // Loop over each model
		for (int indexDataset=0;indexDataset<numDataRows;indexDataset++) {
			// Loop over categories
			for (int j=startIndex;j<(endIndex+1);j++) {
				datasetNumber = datasetNumber + 1;

				// Create data-series value element
				Element dataSeriesEle = dom.createElement("data-series");

				//------------------------------------------
				// Create children for the data-series
				//------------------------------------------
				// Create data-series label
				Element dataSeriesLabelEle = dom.createElement("data-series-label");
				// Create label text based on model and category
				String dataSeriesLabel = null;
				// Build the array into a string separate by pipes for the regex
				// Get list of possible units
				String[] possibleCategoryUnits = SettingsHashLibrary.getPossibleCategoryUnitsArray();
				String possibleCategoryUnitsList="";
				for (int i=0; i<possibleCategoryUnits.length; i++) {
					if (i==0) {
						possibleCategoryUnitsList = possibleCategoryUnits[indexDataset];
					}
					else {
						possibleCategoryUnitsList = possibleCategoryUnitsList + "|" + possibleCategoryUnits[i];
					}
				}

				try {
				logger.trace("Get legend info");
				// Use pattern matcher to see if there are thresholds listed in the forecast source name
					pattern = Pattern.compile(".*(" + possibleCategoryUnitsList + ")([0-9pt]+)and([0-9pt]+)_.*",Pattern.CASE_INSENSITIVE);
					matcher = pattern.matcher(fcstSourceArray[indexDataset]);
					matcher.find();
					// If there is a valid threshold unit found for categories in the forecast source
					if (matcher.matches() == true) {
						logger.trace("Creating legend for asymmetric categories for forecast source " + fcstSourceArray[indexDataset]);
						// Remove snippet with category threshold info = 
						//String testPattern = "(" + possibleCategoryUnitsList + ")([0-9pt]+)and([0-9pt]+)";
						logger.trace("Removing any forecast source name snippet with regex pattern: " + "(" + possibleCategoryUnitsList + ")([0-9pt]+)and([0-9pt]+)");
						dataSeriesLabel = fcstSourceArray[indexDataset].replaceAll("(" + possibleCategoryUnitsList + ")([0-9pt]+)and([0-9pt]+)","");
					}
					else {
						logger.trace("Creating legend for symmetric categories for forecast source " + fcstSourceArray[indexDataset]);
						dataSeriesLabel = fcstSourceArray[indexDataset];
					}
				} // End try
				catch (Exception e) {
					logger.fatal("Could not create legend labels from the forecast source: " + fcstSourceArray[indexDataset] + " , " + e);
				}
				
				// Get category individually
				categoryLabel = SettingsHashLibrary.getCategoryLabel(category[j],chart.getFcstSourceArray()[indexDataset]);
				dataSeriesLabel = dataSeriesLabel.concat(" " + categoryLabel);
				
				Text dataSeriesLabelText = dom.createTextNode(dataSeriesLabel);
				dataSeriesLabelEle.appendChild(dataSeriesLabelText); // Append text to label element

				// Append the data series label as a child of the data series element
				dataSeriesEle.appendChild(dataSeriesLabelEle);

				//------------------------------------------
				// Create a xAxis-series element <x-data> that corresponds to each line plot dataset
				// Only do this if it is the first set of data since only one set of x-data 
				// is necessary for a timeseries. These values are integers number 1 to length of
				// timeseries.
				//------------------------------------------
				if (datasetNumber == 1) {
					// Get array consecutive point values for <x-data> 
					String[] intXdataValuesArray = chart.getIntXdataValuesArray();
					// Print out referenceArray values
					logger.debug("Size of reference array is " + numDateCols);
					// Loop over columns to create the x-data XML
					// Create point labels
					for (int i=0;i<intXdataValuesArray.length;i++) {
						Element intXdataEle = dom.createElement("x-data");
						Text intXdataText = dom.createTextNode(intXdataValuesArray[i]);
						intXdataEle.appendChild(intXdataText);
						dataSeriesEle.appendChild(intXdataEle);
					}
				}

				//------------------------------------------
				// Create the y-data series for the current dataset (the scores)
				//------------------------------------------
				// Loop over each date or bin
				for (int i=0;i<numDataCols;i++) {
					Element scoreArrayEle = dom.createElement("y-data");
					Text scoreArrayText = dom.createTextNode(scoreArray[indexDataset][j][i]);
					scoreArrayEle.appendChild(scoreArrayText); // Append text to element
					// Append y-data to data-series element
					dataSeriesEle.appendChild(scoreArrayEle);
				} // end for

				chartEle.appendChild(dataSeriesEle);
			} // End loop through category
		} // End model loop
		return chartEle;
	}

    /**
	Creates chart elements in appropriate XML structure for a reliability diagram.
	Puts data for JClass in general format (a unique set of x values for each set of y values).
	**/
	private Element createChartElementReliability(Chart chart){
		String categoryLabel;
		Pattern pattern;
		Matcher matcher;

	        logger.trace("In createChartElementReliability(chart)");
		String[] category = SettingsHashLibrary.getCategoryNames();
			// Set chart name
			Element chartEle = dom.createElement("chart-data");	
			chartEle.setAttribute("name", chart.getChartName());

	        // Get array of point (reference) values (the prob bins)
			String[] referenceArray = chart.getChartReferenceArray();

	        // Get size of reference array
			int numDateCols = referenceArray.length;
			
	        //------------------------------------------
	        // Create xml data point labels (values are probability bins)
		//------------------------------------------
		for (int i=0;i<referenceArray.length;i++) {
	    	Element dataPointLabelEle = dom.createElement("data-point-label");
			Text dataPointLabelText = dom.createTextNode(referenceArray[i]);
			dataPointLabelEle.appendChild(dataPointLabelText);
			chartEle.appendChild(dataPointLabelEle);
		}

        	// Get array of data labels (forecast sources)
		String[] fcstSourceArray = chart.getFcstSourceArray();
		// Get array of score values
		String[][][] scoreArray = chart.getScoreArray();
		// Get array of ave fcst per bin
		String[][][] xdataScoreArray = chart.getXdataScoreArray();
		// Get number of probability bins
		int numDataCols = scoreArray[0][0].length;
		// Get the number of categories
		int numCats = scoreArray[0].length;
		// Get the number of models
		int numDataRows = scoreArray.length;
		logger.debug("Number of bins of data is " + numDataCols);
		logger.debug("Number of cats of data is " + numCats);
		logger.debug("Number of models of data is " + numDataRows);

        // Determine categories to create xml for
		logger.debug("categoryType = " + chart.getCategoryType());
		logger.debug("scoreType = " + chart.getScoreType());
		int startIndex = 0;
		int startIndexOrig = 0;
		int endIndex = 0;
		
		// If categoryType is "separate", include all categories
		if (chart.getCategoryType().equals("separate")) {
			startIndex = 1;
			startIndexOrig = startIndex;
			endIndex = 3;
		}
		// if categoryType is "total", just do the total score (index 0)
		else if (chart.getCategoryType().equals("total")) {
			startIndex = 0;
			startIndexOrig = startIndex;
			endIndex = 0;
		}
		// if categoryType is "B", just do the total score (index 1)
		else if (chart.getCategoryType().equals("B")) {
			startIndex = 1;
			startIndexOrig = startIndex;
			endIndex = 1;
		}
		// if categoryType is "N", just do the total score (index 2)
		else if (chart.getCategoryType().equals("N")) {
			startIndex = 2;
			startIndexOrig = startIndex;
			endIndex = 2;
		}
		// if categoryType is "A", just do the total score (index 3)
		else if (chart.getCategoryType().equals("A")) {
			startIndex = 3;
			startIndexOrig = startIndex;
			endIndex = 3;
		}
		
		// An extra loop is needed to create xml for the reference line
		// The category loop for the first model will start at one value lower to include
		// xml for the reference line.
		startIndex = startIndex - 1;

		logger.debug("Creating xml for first model for categories from " + startIndex + " to " + endIndex);
		logger.debug("Creating xml for other models for categories from " + startIndexOrig + " to " + endIndex);

        // Use a counter to determine the dataset number since only 
		// the first datasets needs xml for the reference line
		int datasetNumber = 0;

        // Create xml data-series elements for each chart dataset
        // Loop over each model
        for (int indexDataset=0;indexDataset<numDataRows;indexDataset++) {
        	// Loop over categories
            for (int j=startIndex;j<(endIndex+1);j++) {
				datasetNumber = datasetNumber + 1;
				logger.trace("datasetNumber " + datasetNumber);
            	// Create data-series value element
            	Element dataSeriesEle = dom.createElement("data-series");

            	//------------------------------------------
            	// Create children for the score data-series
            	//------------------------------------------
            	// Create data-series label
            	Element dataSeriesLabelEle = dom.createElement("data-series-label");
            	// Create label text based on model and category
            	String dataSeriesLabel=null;
			if (datasetNumber == 1) {
				dataSeriesLabel = "Reference";
			}
			// If there are thresholds found in the forecast source name, shorten data series label snippet with forecast source to pieces without the thresholds since the category label would capture it. If there is any pattern match to a known threshold, listed in SettingsHashLibrary.getPossibleCategoryUnitsArray(), then remove the snippet of threshold.
			else {
			// Build the array into a string separate by pipes for the regex
			// Get list of possible units
				String[] possibleCategoryUnits = SettingsHashLibrary.getPossibleCategoryUnitsArray();
				String possibleCategoryUnitsList="";
				for (int i=0; i<possibleCategoryUnits.length; i++) {
					if (i==0) {
						possibleCategoryUnitsList = possibleCategoryUnits[indexDataset];
					}
					else {
						possibleCategoryUnitsList = possibleCategoryUnitsList + "|" + possibleCategoryUnits[i];
					}
				}

				try {
				logger.trace("Get legend info");
				// Use pattern matcher to see if there are thresholds listed in the forecast source name
					pattern = Pattern.compile(".*(" + possibleCategoryUnitsList + ")([0-9pt]+)and([0-9pt]+)_.*",Pattern.CASE_INSENSITIVE);
					matcher = pattern.matcher(fcstSourceArray[indexDataset]);
					matcher.find();
					// If there is a valid threshold unit found for categories in the forecast source
					if (matcher.matches() == true) {
						logger.trace("Creating legend for asymmetric categories for forecast source " + fcstSourceArray[indexDataset]);
						// Remove snippet with category threshold info = 
						//String testPattern = "(" + possibleCategoryUnitsList + ")([0-9pt]+)and([0-9pt]+)";
						logger.trace("Removing any forecast source name snippet with regex pattern: " + "(" + possibleCategoryUnitsList + ")([0-9pt]+)and([0-9pt]+)");
						dataSeriesLabel = fcstSourceArray[indexDataset].replaceAll("(" + possibleCategoryUnitsList + ")([0-9pt]+)and([0-9pt]+)","");
					}
					else {
						logger.trace("Creating legend for symmetric categories for forecast source " + fcstSourceArray[indexDataset]);
						dataSeriesLabel = fcstSourceArray[indexDataset];
					}
				} // End try
				catch (Exception e) {
					logger.fatal("Could not create legend labels from the forecast source: " + fcstSourceArray[indexDataset] + " , " + e);
				}
				
				// Get category individually
				categoryLabel = SettingsHashLibrary.getCategoryLabel(category[j],chart.getFcstSourceArray()[indexDataset]);
				dataSeriesLabel = dataSeriesLabel.concat(" " + categoryLabel);
			} // End else not first dataset
			Text dataSeriesLabelText = dom.createTextNode(dataSeriesLabel);
			dataSeriesLabelEle.appendChild(dataSeriesLabelText); // Append text to label element

        	// Append the data series label as a child of the data series element
			dataSeriesEle.appendChild(dataSeriesLabelEle);

            	//------------------------------------------
            	// Create the x-data series 
            	//------------------------------------------
				String[] xdataValuesArray = null;
				// For the first dataset use the reference values
				if (datasetNumber == 1) {
					// Get array of point labels
					xdataValuesArray = chart.getChartReferenceArray();
				}
				// For other datasets use aveFcstProb values to plot 
				// each dataset at the correct x values
				else {
					xdataValuesArray = xdataScoreArray[indexDataset][j];	
				}
				// Loop over columns to create x-data xml and create point labels
				for (int i=0;i<xdataValuesArray.length;i++) {
					Element xdataEle = dom.createElement("x-data");
					Text xdataText = dom.createTextNode(xdataValuesArray[i]);
					xdataEle.appendChild(xdataText);
					dataSeriesEle.appendChild(xdataEle);
				}

            	//------------------------------------------
				// Create the y-data series for the current dataset (the score)
				//------------------------------------------
				// Loop over each bin
				for (int i=0;i<numDataCols;i++) {
					Element scoreArrayEle = dom.createElement("y-data");
					Text scoreArrayText = null;
					// Insert the scores
					// For the first dataset insert values to make a diagonal line
					if (datasetNumber == 1 ) {
						scoreArrayText = dom.createTextNode(referenceArray[i]);
					}
					else {
						scoreArrayText = dom.createTextNode(scoreArray[indexDataset][j][i]);
					}
					scoreArrayEle.appendChild(scoreArrayText); // Append text to element
					// Append y-data to data-series element
					dataSeriesEle.appendChild(scoreArrayEle);
				} // end for

				// Create the last y-data series element for the reference line.
				// This reference value corresponds to the last axis label since there
				// is one mroe value than there is actual score data.
				if (datasetNumber == 1) {
					Element scoreArrayEle = dom.createElement("y-data");
					Text scoreArrayText = null;
					// This is a single value added once
					scoreArrayText = dom.createTextNode(referenceArray[numDataCols]);
					scoreArrayEle.appendChild(scoreArrayText); 
					// Append y-data to data-series element
					dataSeriesEle.appendChild(scoreArrayEle);
				}
		chartEle.appendChild(dataSeriesEle);			
        	} // End loop through category

			// after first loop for ref line, return to normal looping
			startIndex = startIndexOrig; 
		} // end model loop
		// Add a second version of the reference line in XML for plotting legend/line correctly later on
            	// Create data-series label
          	String dataSeriesLabel;
		dataSeriesLabel = "Reference";
           	// Create data-series value element
            	Element dataSeriesEle = dom.createElement("data-series");
		Text dataSeriesLabelText = dom.createTextNode(dataSeriesLabel);
		dataSeriesLabelText = dom.createTextNode(dataSeriesLabel);
         	Element dataSeriesLabelEle = dom.createElement("data-series-label");
		dataSeriesLabelEle.appendChild(dataSeriesLabelText); // Append text to label element
		dataSeriesEle.appendChild(dataSeriesLabelEle);
            	// Append the data series label as a child of the data series element
		dataSeriesEle.appendChild(dataSeriesLabelEle);
		String[] refDataValuesArray = chart.getChartReferenceArray();
		for (int i=0;i<refDataValuesArray.length;i++) {
			Element refDataEle = dom.createElement("x-data");
			Text refDataText = dom.createTextNode(refDataValuesArray[i]);
			refDataEle.appendChild(refDataText);
			dataSeriesEle.appendChild(refDataEle);
		}
		for (int i=0;i<refDataValuesArray.length;i++) {
			Element refDataEle = dom.createElement("y-data");
			Text refDataText = dom.createTextNode(refDataValuesArray[i]);
			refDataEle.appendChild(refDataText);
			dataSeriesEle.appendChild(refDataEle);
					
		}
		chartEle.appendChild(dataSeriesEle);			
		//------------------------------------------
		return chartEle;
	}

	//------------------------------------------
	// Create table element(s)
	//------------------------------------------


	/**
	 * Returns a String of XML formatted data of the supplied input data. This method uses Xerces specific classes to write the formatted data.
	<p>
	@return String of formatted XML data.
	<p>
	NOTE : The option to write to an XML file is commented out and can be uncommented for usage.
     */
	public String getString(boolean containsDocType, String docType){
		StringBuffer buffer = null;
		//OutputStream out = null;
		try {
			// Utilize OutputFormat method to create a formatted dom
			// This method is deprecated, there are newer software methods
			OutputFormat format = new OutputFormat(dom);
			// Set indenting
			format.setIndenting(true);

			// Set DOCTYPE (if applicable)
			format.setDoctype(null,docType);

			// Create serializer object
			XMLSerializer serializer = new XMLSerializer(writer, format);
			//to generate output to console use this serializer
			//XMLSerializer serializer = new XMLSerializer(new OutputStream(), format);

			//to generate a file output use fileoutputstream instead of system.out
			//XMLSerializer serializer = new XMLSerializer(new FileOutputStream(new File("book.xml")), format);

			// Serialize
			serializer.serialize(dom);
			// Note : String concatenation is faster with string buffers than regular strings
			// Not sure about this case with performance, but using the string buffer
			// String string = writer.toString();
			buffer = writer.getBuffer();

			//Print out buffer of results
 			logger.trace(buffer);

		} catch(IOException ie) {
			logger.fatal("[XMLCreator.java] Error - exception " + ie);
		    ie.printStackTrace();
			Log.fatal("Error encountered trying to format back-end results. Report an error serializing resluts and returning them.", "#errorPanelText");
		}
		return buffer.toString();
	} // End getString
} // End public class XMLCreator
