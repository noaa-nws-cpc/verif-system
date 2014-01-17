package gov.noaa.ncep.cpc.utils;

//-----------------------------------------------------------------------------
// Import packages
//-----------------------------------------------------------------------------
import java.util.Calendar;
import java.text.SimpleDateFormat;
import java.util.*;
import org.apache.log4j.Logger;

public class Date {
	// Initialize logger
	static protected Logger logger;

	/**
	* Returns the number of weekdays in a given array of date strings. Expects
	* the date to be formatted as MM/DD/YYYY
	*
	* @param dates String array of dates
	*
	* @return Number of weekdays in the given array of date strings
	*/
	public static int numWeekdays(String[] dates) {
		// Get the logger
		logger = Logger.getLogger(Date.class.getName());
		// Create a new instance of the Calendar object
		Calendar calendar = Calendar.getInstance();
		// Initialize counter
		int count = 0;
		// Loop over all dates in the dates array
		for (String date : dates) {
			// Split the date into year, month, and day.
			String[] splitDate = date.split("/");
			int month = Integer.parseInt(splitDate[0]) - 1; // 0 = January
			int day   = Integer.parseInt(splitDate[1]);
			int year  = Integer.parseInt(splitDate[2]);
			// Set the calendar instance date
			calendar.set(year, month, day);
			// Get the day of the week
			int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
			// Count as a weekday only if dayOfWeek is 2, 3, 4, 5, or 6
			if (dayOfWeek >= 2 && dayOfWeek <= 6) {
				count++;
			}
		}
		return count;
	}

	/**
	* Returns the climatology period(s) spanned by the given valid date range.
	* Expects the dates to be formatted as YYYY-MM-DD.
	*
	* @param startDate First date of the valid period
	* @param endDate   Last date of the valid period
	*
	* @return String array of climatology period(s) (YYYY-YYYY)
	*/
	public static String[] climPeriods(String startDate, String endDate) {
		// Initialize variables
		List<String> climPeriodList = new ArrayList<String>();
		// Get the logger
		logger = Logger.getLogger(Date.class.getName());
		// Create a calendar for the iteration date
		Calendar cal = Calendar.getInstance();
		String[] dateParts = startDate.split("-"); // Get year, month, day from YYYY-MM-DD string
		cal.set(Integer.parseInt(dateParts[0]),Integer.parseInt(dateParts[1])-1,Integer.parseInt(dateParts[2])); // Must subtract 1 from month (Jan=0)
		// Create a calendar for the end date
		Calendar endCal = Calendar.getInstance();
		dateParts = endDate.split("-"); // Get year, month, day from YYYY-MM-DD string
		endCal.set(Integer.parseInt(dateParts[0]),Integer.parseInt(dateParts[1])-1,Integer.parseInt(dateParts[2])); // Must subtract 1 from month (Jan=0)
		// Loop over all dates
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
		logger.info("Looping over dates from "+startDate+" to "+endDate+"...");
		while(! cal.after(endCal)) {
			logger.info("Date in climPeriods(): " + sdf.format(cal.getTime()));
			// Determine the clim period for this date

//			if (climPeriodList.contains()) {
				
//			}
			cal.add(Calendar.DATE,1);
		}
		return climPeriodList.toArray(new String[0]);
	}
}
