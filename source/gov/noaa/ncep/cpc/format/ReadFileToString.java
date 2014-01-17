package gov.noaa.ncep.cpc.format;


// Import classes to utilize files
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;

/**
Reads a file and converts it to a string. 
*/
public class ReadFileToString
{
	// Initialize logger
	static Logger logger = Logger.getLogger(ReadFileToString.class.getName());

	// Initialize all variables
	static String content;

/**
Returns a string of HTML formatted text from the passed name of the path and file to read the HTML from.

@param fileName Name of the path and file to read the HTML from
@return string of HTML
*/
	public static String getFileToString(File fileName) {

	logger.info("Name of the file is " + fileName);
	// Use FileUtils class from Apache
	// Commons IO (commons.io) to read the content of a
	// file. FileUtils have two static methods called
	// readFileToString(File file) and readFileToString(
	// File file, String encoding) that we can user.
	try {
		// Read the entire contents of sample.txt
		//content = FileUtils.readFileToString(fileName);
		content = readFromJARFile("/input/" + fileName);
		// For shake of this example we show the file content here.
		logger.info("File content: " + content);
		} catch (IOException e)
		{
			e.printStackTrace();
			logger.fatal("Cannot find file for display : " + "/input/" + fileName + "\n Make sure that this file exists and is in the /input sub-directory of the verification.jar file used");
		}
	return content;
	}

	public static String readFromJARFile(String filename)
	throws IOException {
		InputStream is = FileUtils.class.getResourceAsStream(filename);
		InputStreamReader isr = new InputStreamReader(is);
		BufferedReader br = new BufferedReader(isr);
		StringBuffer sb = new StringBuffer();
		String line;
		while ((line = br.readLine()) != null) 
		{
			sb.append(line);
		}
		br.close();
		isr.close();
		is.close();
		return sb.toString();
	}


}                                                                  