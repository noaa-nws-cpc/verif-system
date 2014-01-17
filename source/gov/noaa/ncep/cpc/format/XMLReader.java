package gov.noaa.ncep.cpc.format;

import java.util.Arrays;
import java.util.HashMap;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.apache.log4j.Logger;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

/**
Reads and parses an XML file with the settings parameters using SAX.
*/
public class XMLReader {
	// Initialize variables

	protected static String eleName; // element name, reset to qName for each instance of startElement()
	protected static HashMap<String , String > valueHash = new HashMap();
	protected static HashMap<String, Boolean> boolHash = new HashMap<String, Boolean>();
		
	protected static String characterData;
	// The below list of elements MUST be in the order that the settings object accepts settings in the settingsArray
	protected static String[] orderedEleArray = {"variable","fcstSources","leadTime","aveWindow","datesValidType","datesValid","regionType","regions","spatialType","outputType","outputDimension","scoreType","categoryType","ECType"}; // Ordered array according to the order of the list that the settings object requires
	protected static String elementMatch;
	protected static int numElements = orderedEleArray.length;
	protected static String[] sortedArray  = new String[numElements]; // Sorted array (alphabetically)
	// Initialize index counter for row of returned array of settings
	protected static int indexRow = 0;
	//Cheat temporarily, hardwire the 2-d settings allocation. Make this an ArrayList eventually
	protected static String[][] orderedSettingsArray;// Array of values with associated ordered settings elements in orderedEleArray(). This is the returned array
	protected static boolean boolSettings = false;	
	static Logger logger = Logger.getLogger(gov.noaa.ncep.cpc.format.XMLReader.class);

/**
Returns a 2-d array of settings, where each row is a set of settings. Reads and parses an XML file containing settings for verification runs. For each occurence of specified parameter settingsSeparator, create a row in a 2-d array 
with the set of settings. Each row in the returned 2-d array represents a set of 
settings that can be used to load a Settings object. Utilizes the SAX method of reading and parsing the XML file.
<p>
@param xmlFileName File name of the XML file containing settings to use in running
the verification driver for.
@param settingsSeparator String of element name that separates each set of settings.
@return 2-d array of settings, where each row is a set of settings.
*/
	public static String[][] readXMLFile(String xmlFileName, String settingsSeparator) {
		// Set the element tag that flags a new set of settings.
		elementMatch = settingsSeparator; 
		// Find the # of occurences of a specific element
		int numMatchesFound = XMLCounter.countElementOccurences(xmlFileName, elementMatch);
		logger.trace("Found " + numMatchesFound + " occurences of the element " + elementMatch + " in the XML file " + xmlFileName);
		orderedSettingsArray = new String[numMatchesFound][numElements];
		// **NOTE: The binary search algorithm requires an ordered array so first sort algorithm
		// Otherwise, binary search function won't work properly
		// This sorts these alphabetically. Therefore, the indices used for searching for
		// a value in the array reflects the alphabetically sorted version of the array
		// Create a copy of the element array
		for ( int idx = 0 ; idx < numElements; ++idx ) {
			sortedArray = (String[])orderedEleArray.clone();
		}
		// sort the cloned array
		Arrays.sort(sortedArray);

		// Initialize boolean values to false for default
		for (int i=0;i < sortedArray.length; i++) {
			boolHash.put(sortedArray[i],false);
		}

		try {
			SAXParserFactory factory = SAXParserFactory.newInstance();
			SAXParser saxParser = factory.newSAXParser();
		
			DefaultHandler handler = new DefaultHandler() {
	
				public void startElement(String uri, String localName,
					String qName, Attributes attributes)
					throws SAXException {
					
					logger.trace("Start Element:" + qName);
					// Search for a value in the element array
					// Negative return value indicates element is NOT in the list
					// However, actual return value can be used to find the index
					// of the array the value is found in (value of 0 or greater). 
					// **NOTE: indexEleArray is not the index of qName in the original orderedEleArray
					// it is of an alphabetically sorted list, so a value in the array beginning with
					// "a" will be returned as the 0th index, even if it is set as the last value 
					// in the array. This is used just for checking for existence.
					int indexEleArray = Arrays.binarySearch(sortedArray,qName);
		
					logger.trace("In startElement, index of search for element in the SORTED element : " +  qName + " in SORTED ARRAY sortedArray is : " + indexEleArray);
					
					// If the element is in the list of the eleArray, set the eleName variable and set bool to true
					if ((indexEleArray >= 0) || (qName.compareToIgnoreCase("settings") == 0 ) ) {
						logger.trace("----- Element :: " + qName + " exists  : " + indexEleArray);
						eleName = qName; // Make current element variable visible to whole class
						boolHash.put(eleName,true);
						logger.trace("NOW boolHash is  : " + boolHash);
					}
				} // End startElement
			
				public void endElement(String uri, String localName,
					String qName) throws SAXException {
					logger.trace("End Element :" + qName);
		
					// If the qName is settings, write the values to the 2-d array to return
					if (qName.compareToIgnoreCase("settings") == 0) {
						logger.trace("(endElement)] FOUND SETTINGS ELEMENT!!");
						for (int i=0;i<orderedEleArray.length;i++) {
							logger.trace("In orderedEleArray loop, index is :: " + i);
							// Perform for all columns (all elements)
							orderedSettingsArray[indexRow][i] = valueHash.get(orderedEleArray[i]);
							logger.trace("Creating orderedSettingsArray :  " + orderedSettingsArray[indexRow][i] + " For Row : " + indexRow);
						}
						indexRow++;
						boolSettings = false;
					}
				}
			
				public void characters(char ch[], int start, int length)
					throws SAXException {
					logger.trace("(characters) **** IN CHARACTERS ****");
		
					// If the eleName is null, don't process any text, otherwise process text
					if (eleName == null) {
						logger.trace("(characters) The element is NULL : " + eleName);
					}
					else if (eleName.compareToIgnoreCase("settings") == 0) {
						boolSettings = true;
					}
					else {
						// If the element exists in the sortedArray
						int indexEleArrayCharacters = Arrays.binarySearch(sortedArray,eleName);
						if ((indexEleArrayCharacters >= 0) &&  (boolHash.get(eleName) == true)) {
							logger.trace("(characters) FOUND :  " + eleName + " in the sortedArray");
							characterData = (new String(ch, start, length)).trim();
							valueHash.put(eleName,characterData);
							String retValue = valueHash.get(eleName);
							logger.trace("value put into valueHash array is : " + retValue);
							boolHash.put(eleName,false);
						}
					}  // End else
				} // end characters()
			}; // End defaultHandler
			saxParser.parse(xmlFileName, handler);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return orderedSettingsArray;
	} // End readXMLFile()
}
