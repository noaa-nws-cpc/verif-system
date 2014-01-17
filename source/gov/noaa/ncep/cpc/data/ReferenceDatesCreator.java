package gov.noaa.ncep.cpc.data;
import gov.noaa.ncep.cpc.qc.Log;
import gov.noaa.ncep.cpc.settings.Settings;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.apache.log4j.Logger;
/**
**DEPRECATED Library of functions that manipulates and creates reference dates
based on passed date settings.
<br>
New method is in QCLibrary.java. This is kept in case database method of creating reference
dates takes too long during process time and this class will have to be used instead.
*/
public class ReferenceDatesCreator {

	static protected Logger logger; // Initialize logger
	/**
	Returns the string array of reference dates based on passed settings information.
	@param settingsObj Loaded settings object.  This is needed to access settings information
	to create the reference string array of dates, including the datesValid, datesValidType,
	information to build the database table name (in some cases), etc.
	@return 1-D String array of reference dates, which could be used for the x-axis of a timeseries chart.
	*/
	public static String[] getReferenceDateArray(Settings settingsObj) {
		// Initialize logger
		logger = Logger.getLogger(ReferenceDatesCreator.class.getName());
		String startDate;
		String endDate;
		String[] dateRangeArray = null;
		int numDays = 0;
		String[] dateStringArray = null;
		String datesValidType = null;
		// Check if settingsObj null. Other problems during run-time could occur
		// if necessary values do not exist. Warnings should be returned if
		// a specific necessary settingsObj value does not exist.
		if (settingsObj == null) {
			logger.fatal("Passed settings object is null. Cannot create reference dates");
		}
		// Get numDays and the dateStringArray
		Calendar cal = Calendar.getInstance(); // Get an instance of the cal
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd"); // Format for date parse
		Calendar startCal = Calendar.getInstance(); // Initialize start cal
		try{
			// Get the start and end dates by parsing the datesValidType by a "," delimeter
			String dateRange = settingsObj.getDatesValid();
			// Split the date range for start and end date
			dateRangeArray = dateRange.split(",");
			startDate = dateRangeArray[0];
			endDate = dateRangeArray[1];
			startCal.setTime(format.parse(startDate));  // Set start cal time
			Calendar endCal = Calendar.getInstance();   // Initialize end cal
			endCal.setTime(format.parse(endDate));      // Set end cal time
			numDays = getDaysBetween(startCal, endCal) + 1;
			logger.debug("numDays = " + numDays);
			cal.setTime(format.parse(startDate));
		}
		catch (Exception e) {
		}
		// Initialize dateStringArray
		dateStringArray = new String[numDays];
		try { // Try/catch for date parsing
			for (int i=0; i<numDays; i++) { // Loop over all days and incremenet cal
				dateStringArray[i] = (cal.get(Calendar.MONTH)+1) + "/" + cal.get(Calendar.DAY_OF_MONTH) + "/" + cal.get(Calendar.YEAR);
				cal.add(Calendar.DAY_OF_MONTH, 1);
			}
		}
		catch (Exception e) {
			Log.fatal("There's a problem with the format of one of your dates, make sure to use the YYYYMMDD format for Extended Range Forecasts.", "#errorPanelText");
			logger.fatal("There's a problem with the date format(s): " + e + " - Make sure to use the YYYYMMDD format for Extended Range Forecasts.");
		}
		return dateStringArray;
	}

/**
	Calculates the number of days between two calendar days in a manner
	which is independent of the Calendar type used.

	@param d1    The first date.
	@param d2    The second date.

	@return      The number of days between the two dates.  Zero is
	             returned if the dates are the same, one if the dates are
	             adjacent, etc.  The order of the dates
	             does not matter, the value returned is always >= 0.
	             If Calendar types of d1 and d2
	             are different, the result may not be accurate.

	@see <a href="http://www.jguru.com/forums/view.jsp?EID=512872">Origin of the getDaysBetween method</a>
	*/
	public static int getDaysBetween (java.util.Calendar d1, java.util.Calendar d2) {
		if (d1.after(d2)) {  // swap dates so that d1 is start and d2 is end
			java.util.Calendar swap = d1;
			d1 = d2;
			d2 = swap;
		}
		int days = d2.get(java.util.Calendar.DAY_OF_YEAR) -
			d1.get(java.util.Calendar.DAY_OF_YEAR);
		int y2 = d2.get(java.util.Calendar.YEAR);
		if (d1.get(java.util.Calendar.YEAR) != y2) {
			d1 = (java.util.Calendar) d1.clone();
			do {
				days += d1.getActualMaximum(java.util.Calendar.DAY_OF_YEAR);
				d1.add(java.util.Calendar.YEAR, 1);
			} while (d1.get(java.util.Calendar.YEAR) != y2);
		}
		return days;
	}

}
