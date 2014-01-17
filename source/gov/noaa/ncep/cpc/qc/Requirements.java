package gov.noaa.ncep.cpc.qc;

// Import required packages
import java.io.File;

import org.apache.log4j.Logger;


/**
Provides methods that check for anything necessary for the Verification System to run.
*/
public class Requirements {
	// Initialize all global variables
	static Logger logger;

	/**
	Checks for all paths required under the home directory.
	
	@param homeDir  Home directory of the Verification System
	*/
	public static boolean checkForRequiredPaths(String homeDir) {
		// Initialize logger
        logger = Logger.getLogger(Requirements.class.getName());
		logger.info("Checking for required paths under " + homeDir + ":");
		// Make an array of the required paths
		String[] paths = {"build.xml","classes","docs","input","library","logs","output","scripts","source","web","work"};
		// Loop over paths
		for (String path : paths) {
			if ( (new File(homeDir + "/" + path)).exists() == false ) {
				logger.fatal("Path \"" + path + "\" does not exist!");
				return false;
			}
		}
		logger.info("All required paths were found!");
		return true;
	}

	/**
	Tests whether a file or directory exists.
	
	@param path  File or directory to check for existance
	
	@return  True or false for the existance of the file or directory
	*/
	public static boolean pathExists (String path) {
		// If String is null, return false
		if (path == null) {
			return false;
		}
		// Convert into a File
		File javaFile = new File(path);
		// See if it exists
		if (javaFile.exists()) {
			return true;
		} else {
			return false;
		}
	}
}
