package gov.noaa.ncep.cpc.format;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.apache.log4j.Logger;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

/**
Performs function of counting the number of times an XML element occurs in an XML document
*/
public class XMLCounter {
	// Initialize variables
	// element name, reset to qName for each instance of startElement()
	protected static String eleName; 

		
	// Initialize index counter for row of returned array of settings
	protected static int indexMatch = 0;
	protected static int numMatches;
	protected static String elementCheck;
	static Logger logger = Logger.getLogger(gov.noaa.ncep.cpc.format.XMLCounter.class);
	//protected static boolean boolMatch = false; // Set default booleam match

	/** Returns the number of times that a specified element occurs in an XML document, which is specified as parameters. ie. this can search for element <element> and return the number of times that this is encountered.
	@return Number of occurences that a specified XML element is encountered in an XML file.
	*/
	public static int countElementOccurences(String xmlFileName, String element) {
		elementCheck = element;
	try {
		SAXParserFactory factory = SAXParserFactory.newInstance();
		SAXParser saxParser = factory.newSAXParser();
	
		DefaultHandler handler = new DefaultHandler() {

		public void startElement(String uri, String localName,
			String qName, Attributes attributes)
			throws SAXException {
			
			logger.trace("(Start Element): " + qName);
	
		} // End startElement
	
		public void endElement(String uri, String localName,
			String qName)
			throws SAXException {
			logger.trace("End Element :" + qName);

			// If the qName is settings, write the values to the 2-d array to return
			if (qName.compareToIgnoreCase(elementCheck) == 0) {
				numMatches++;
				logger.trace("(endElement) FOUND ELEMENT !!" + elementCheck + " Occurence # " + numMatches);
			}
		}
	
		public void characters(char ch[], int start, int length)
				throws SAXException {
		} // end characters()
	
		}; // End defaultHandler
			saxParser.parse(xmlFileName, handler);
	
		} catch (Exception e) {
			e.printStackTrace();
		}

		return numMatches;
	} // End readXMLFile()
	
}
