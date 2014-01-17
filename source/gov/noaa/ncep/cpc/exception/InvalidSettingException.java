package gov.noaa.ncep.cpc.exception;

/**
 * Prints a warning that the option is invalid.               
 */
public class InvalidSettingException extends Exception {
	// Constructor
	public InvalidSettingException(String s) {
		super(s);
	}
} 
