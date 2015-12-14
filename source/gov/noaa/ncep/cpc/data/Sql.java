package gov.noaa.ncep.cpc.data;

import gov.noaa.ncep.cpc.qc.Log;
import gov.noaa.ncep.cpc.settings.SettingsHashLibrary;
import org.apache.log4j.Logger;
import java.util.regex.*;

/**
Provides methods dealing with the creation and manipulation of SQL commands
*/
public class Sql {

	// Initialize logger
	static Logger logger = Logger.getLogger(gov.noaa.ncep.cpc.data.Sql.class);

	/**
	Default constructor. All methods in this class are static, so
	we really don't use a constructor. The way it's declared here
	should hide it from Javadoc.
	*/
	Sql() {

	}

	/**
	Returns a comma-delimited list of regions for the full SQL command.
	This method basically inserts single-quotes around each region
	of the String, making a comma-delimited list of Strings. This will
	later be part of the full SQL command that extracts the data from
	the database.
	<p>
	For example:
	<ul>
	    "TX, LA, MS" --> "'TX','LA','MS'"
	</ul>
	@param  oldList  A String containing regions, separated by commas
	@return          A String containing regions, separated by commas,
	                 with each region surrounded by single-quotes
	*/
	public static String addQuotesToList(String oldList) {
		// Initialize an empty String
		String newList = "";
		// Loop over all pieces of the oldList (after splitting)
		for (String listElement : oldList.split(",")) {
			newList = newList + "'" + listElement + "',";
		}
		// Chop off the extra ',' at the end
		newList = newList.substring(0,newList.length()-1);
		return newList;
	}

	/**
	Returns a pipe-delimited list of regions for the full SQL command.
	This method prepares the regions for regex in the MySQL command.
	This will later be part of the full SQL command that extracts the
	data from the database.
	<p>
	For example:
	<ul>
	    "TX, LA, MS" --> "TX|LA|MS"
	</ul>
	@param  oldList  A String containing regions, separated by commas
	@return          A String containing regions, separated by |'s
	*/
	public static String regionsToRegex(String oldList, String regionType) {
		String CONUSClimateRegions = "HP|MW|NE|S|SE|W";
		String CONUSClimateDivisions = "1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62|63|64|65|66|67|68|69|70|71|72|73|74|75|76|77|78|79|80|81|82|83|84|85|86|87|88|89|90|91|92|93|94|95|96|97|98|99|100|101|102";
		String CONUSStates = "AL|AS|AZ|AR|CA|CO|CT|DE|DC|FL|GA|GU|ID|IL|IN|IA|KS|KY|LA|ME|MD|MH|MA|MI|FM|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|MP|OH|OK|OR|PW|PA|PR|RI|SC|SD|TN|TX|UT|VT|VA|VI|WA|WV|WI|WY";
		if (oldList.matches("(?i)CONUS")) {
			if (regionType.compareToIgnoreCase("climateRegion") == 0) {
				return CONUSClimateRegions;
			} else if (regionType.compareToIgnoreCase("climateDivision") == 0) { 
				return CONUSClimateDivisions;
			} else if (regionType.compareToIgnoreCase("state") == 0) {
				return CONUSStates;
			} else {
				return ".*";
			}
		} else if (oldList.matches("(?i)all")) {
			if (regionType.compareToIgnoreCase("climateRegion") == 0) {
				return CONUSClimateRegions+"|AK";
			} else if (regionType.compareToIgnoreCase("climateDivision") == 0) { 
				return CONUSClimateDivisions+"|103";
			} else if (regionType.compareToIgnoreCase("state") == 0) {
				return CONUSStates+"|AK";
			} else {
				return ".*";
			}
		} else {
			return "^" + oldList.replaceAll("\\s*,\\s*",Matcher.quoteReplacement("$")+"|^") + "$";
		}
	}

	/**
	Returns a version of the date in SQL format. The database utilizes
	the YYYY-MM-DD format for the date, whereas the VWT utilizes the
	YYYYMMDD format (see the settings form).
	@param  oldDate  The date in the YYYYMMDD format
	@return          A date in the YYYY-MM-DD SQL format
	*/
	public static String toSqlDate(String oldDate) {
		String newDate = null;
		// YYYYMMDD
		if (oldDate.length() == 8) {
			newDate = oldDate.substring(0,4) + "-" + oldDate.substring(4,6) + "-" + oldDate.substring(6,8);
		} else {
			// Throw an exception
		}
		return newDate;
	}

	/**
	Returns the forecast SQL table name corresponding to the given settings.
	The database stores all forecast data in tables, named according to the
	following convention:
	<p>
	<ul>
		<div style="font-family: monospace">
			vvvv_ssss_llu1_wwu2_ttt<br><br>
				where:<br>
				<ul>
					vvvv &nbsp;&nbsp; variable in question (temp, prcp)<br>
					ssss &nbsp;&nbsp; source of the information (off, auto, klein...)<br>
					ll &nbsp;&nbsp;&nbsp;&nbsp; lead time (08, 11...)<br>
					ww &nbsp;&nbsp;&nbsp;&nbsp; averaging window (01, 05, 07...)<br>
					u1 &nbsp;&nbsp;&nbsp;&nbsp; units of lead time (d, m...)<br>
					u2 &nbsp;&nbsp;&nbsp;&nbsp; units of averaging window (d, m...)<br>
					ttt &nbsp;&nbsp;&nbsp; type of data value (cd, stn...)<br>
				</ul>
		</div>
	</ul>
	@param variable     Variable to verify (temp, precip...)
	@param fcstSource   What produced the forecast (off, auto...)
	@param leadTime     Time to the center of the valid period (08d, 11d, 01m...)
	@param spatialType  How each datapoint is stored spatially (chart, map, table)
	@param aveWindow    Width of valid period (08d, 11d, 01m...)
	@return             Database table name
	*/
	public static String getDataTableName(String variable, String fcstSource, String leadTime, String aveWindow, String spatialType) throws Exception {
		try {
			return (variable + "_" + fcstSource + "_" + leadTime + "_" + aveWindow + "_" + SettingsHashLibrary.getSpatialTypeTableName(spatialType));
		} catch (Exception e) {
			logger.fatal("Cannot get the data table name");
			Log.fatal("Cannot get the data table name","#errorPanelText");
			throw e;
		}
	}

	/**
	Returns the observation SQL table name corresponding to the given settings.
	The database stores observation data in tables, named according to the
	following convention:
	<p>
	<i>Observations:</i>
	<ul>
		<div style="font-family: monospace">
			vvvv_wwu_ttt<br><br>
				where:<br>
				<ul>
					vvvv &nbsp;&nbsp; variable in question (temp, prcp)<br>
					ww &nbsp;&nbsp;&nbsp;&nbsp; averaging window (01, 05, 07...)<br>
					u &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; units of averaging window (d, m...)<br>
					ttt &nbsp;&nbsp;&nbsp; type of data value (cd, stn...)<br>
				</ul>
		</div>
	</ul>
	@param variable     Variable to verify (temp, precip...)
	@param aveWindow    Width of valid period (08d, 11d, 01m...)
	@param spatialType  How each datapoint is stored spatially (station,climate division, gridded)
	@return             Database table name
	*/
	public static String getDataTableName(String variable, String aveWindow, String spatialType) throws Exception {
		try {
			return (variable + "_" + aveWindow + "_" + SettingsHashLibrary.getSpatialTypeTableName(spatialType));
		} catch (Exception e) {
			logger.fatal("Cannot get the data table name");
			Log.fatal("Cannot get the data table name","#errorPanelText");
			throw e;
		}
	}

	/**
	Returns the climatology SQL table name corresponding to the given settings.
	The database stores climatology data in tables, named according to the
	following convention:
	<p>
	<i>Climatologies:</i>
	<ul>
		<div style="font-family: monospace">
			vvvv_wwu_yyyy1_yyyy2_ttt<br><br>
				where:<br>
				<ul>
					vvvv &nbsp;&nbsp; variable in question (temp, prcp)
					ww &nbsp;&nbsp;&nbsp;&nbsp;averaging window (01, 05, 07...)
					u &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; units of averaging window (d, m...)
					yyyy1 &nbsp; Beginning year of climatology
					yyyy2 &nbsp; Ending year of climatology
					ttt &nbsp;&nbsp;&nbsp; type of data value (cd, stn...)
				</ul>
		</div>
	</ul>
	@param variable     Variable to verify (temp, precip...)
	@param aveWindow    Width of valid period (08d, 11d, 01m...)
	@param years        Years the climatology is valid over (1971-2000, 1981-2010)
	@param spatialType  How each datapoint is stored spatially (station,climate division, gridded)
	@return             Database table name
	*/
	public static String getDataTableName(String variable, String aveWindow, String years, String spatialType) throws Exception {
		try {
			years = years.replaceAll("-","_");
			return (variable + "_" + aveWindow + "_" + years + "_" + SettingsHashLibrary.getSpatialTypeTableName(spatialType));
		} catch (Exception e) {
			logger.fatal("Cannot get the data table name");
			Log.fatal("Cannot get the data table name","#errorPanelText");
			throw e;
		}
	}

	/**
	Returns the reference SQL table name corresponding to the given spatialType setting. The database stores reference information in tables about that spatial
	type, named according to the following convention:
	<p>
	Abbreviated name of the spatial type as set as hash arrays inside the settings
	package class SettingsHashLibrary.java in method getSpatialTypeTableName. Currently no other Strings are concatenated in this
	method to build the name of the reference tables. This can be done in this
	method in the future if the convention is changed.
	<p>
	For example : "stn" would be the name of the stations reference table, which is set
	in the SettingsHashLibrary.java method getSpatialTypeTableName().
	@param spatialType  How each datapoint is stored spatially (station,climate division, gridded)
	@return Reference table name
	*/
	public static String getRefTableName(String spatialType) throws Exception {
		try {
			return SettingsHashLibrary.getSpatialTypeTableName(spatialType);
		} catch (Exception e) {
			logger.fatal("Cannot get the reference table name");
			Log.fatal("Cannot get the reference table name","#errorPanelText");
			throw e;
		}
	}

	/**
	Returns the date filter portion of an SQL query for retrieving forecast data.This Sql syntax is based on passed information such as the type of filtering, date information to use in the filter, lead time, and name of the column in database of the date issued.<br>
	If it is a range of dates submitted, dates must be formatted as YYYYmmdd. Based on the value of passed datesValidType, this method will call the appropriate methods in DateSql.java to build the Sql for the datesValidType.
	@param datesValidType Type of date to filter. Current values of this are "dateRange".<br>
	Current available values:<br>
	<ul>
	<li>"dateRange" - Forecast issued date in a range of valid dates
	</ul>
	@param datesValid Formatted string with commas or commas and semi-colons for date filtering
	@param leadTimeNumberFormat lead time string with a numeric value and character representing the time unit of the lead to create Sql for the issued date. For example "08d" for 8 day lead forecasts, "03m" for 3 month lead forecasts. Only Integer or decimal formatted values allowed in the String.<br>
	Developers note: This method calls Settings.getSqlTimeUnit to get the appropriate Sql syntax of the time unit represented by the character representing the time unit of the passed leadTimeNumberFormat value.<br>
	This value <b>must</b> be a numeric value, ie. a decimal value needs to have a decimal in the string, not a 'pt' or other string representing the value. This value is used in the Sql query for date manipulation and is rounded to the next integer.
	@param dateIssuedCol Name of database column of dates issued
	@return Sql syntax portion of date filter for retrieving forecast data from the database.
	*/
	public static String getFcstDateFilter(String datesValidType, String datesValid, String leadTimeNumberFormat, String dateIssuedCol) throws Exception {
		String sqlFcstStr = null;
		// If statements based on datesValidType

		// If the datesValidType is 'dateRange', create appropriate syntax for days in range
		if (datesValidType.compareToIgnoreCase("dateRange") == 0) {
			try {
				sqlFcstStr = DateSql.getDayRangeIssuedSql(datesValid,leadTimeNumberFormat,dateIssuedCol);
			}
			catch (Exception e) {
				logger.fatal("Sql.createFcstDateFilter() method failed to run. Check to make sure that the datesValid string has 'YYYYmmdd' formatted dates.");
				Log.fatal("Report problem creating the forecast date filter. Possible problem with the back-end formatting of the selected dates.", "#errorPanelText");
				throw e;
			}
		}
		// Else If the datesValidType is 'selectMonths', create appropriate syntax for days in range
		else if (datesValidType.compareToIgnoreCase("selectMonths") == 0) {
			try {
				sqlFcstStr = DateSql.getMonthsIssuedSql(datesValid,leadTimeNumberFormat,dateIssuedCol);
			}
			catch (Exception e) {
				logger.fatal("Sql.createFcstDateFilter() method failed to run. Check to make sure that the datesValid string has 'YYYYmmdd' formatted dates.");
				Log.fatal("Report problem creating the forecast date filter. Possible problem with the back-end formatting of the selected dates.", "#errorPanelText");
			}
		}
		// Else If the datesValidType is 'selectMonthsYears', create appropriate syntax for days in range
		else if (datesValidType.compareToIgnoreCase("selectMonthsYears") == 0) {
			try {
				sqlFcstStr = DateSql.getMonthsIssuedSql(datesValid,leadTimeNumberFormat,dateIssuedCol) + " AND " + DateSql.getYearsIssuedSql(datesValid,leadTimeNumberFormat,dateIssuedCol);
			}
			catch (Exception e) {
				logger.fatal("Sql.createFcstDateFilter() method failed to run. Check to make sure that the datesValid string has 'YYYYmmdd' formatted dates.");
				Log.fatal("Report problem creating the forecast date filter. Possible problem with the back-end formatting of the selected dates.", "#errorPanelText");
			}
		}
		else {
			logger.fatal("Could not create appropriate fcst date filter part of Sql syntax");
			Log.fatal("Could not create appropriate fcst date filter", "#errorPanelText");
			throw new Exception ("Could not create appropriate fcst date filter part of Sql syntax");
		}
		return sqlFcstStr;
	}


	/**
	Returns the date filter portion of an SQL query for retrieving obs data.This Sql syntax is based on passed information such as the type of filtering, date information to use in the filter, lead time, and name of the column in database of the date issued.<br>
	@param datesValidType String representing the type of date filtering to perform
	Current available values:<br>
	<ul>
	<li>"dateRange" - Observation valid date in a range of valid dates
	</ul>
	@param datesValid Formatted string with commas or commas and semi-colons for date filtering
	@param dateValidCol Name of database column of dates valid
	@return Sql syntax portion of date filter for retrieving observation data from the database
	*/
	public static String getObsDateFilter(String datesValidType, String datesValid, String dateValidCol) throws Exception {
		String sqlObsStr = null;
		//return "date_valid BETWEEN '" + toSqlDate(startDate) + "' AND '" + toSqlDate(endDate) + "'";
		if (datesValidType.compareToIgnoreCase("dateRange") == 0) {
			sqlObsStr = DateSql.getDayRangeValidSql(datesValid, dateValidCol);
		}
		// Else If the datesValidType is 'selectMonths', create appropriate syntax for days in range
		else if (datesValidType.compareToIgnoreCase("selectMonths") == 0) {
			try {
				sqlObsStr = DateSql.getMonthsValidSql(datesValid,dateValidCol);
			}
			catch (Exception e) {
				logger.fatal("Sql.createObsDateFilter() method failed to run. Check to make sure that the datesValid string has 'YYYYmmdd' formatted dates.");
				Log.fatal("Report problem creating the observation data date filter. Possible problem with the back-end formatting of the selected dates.","#errorPanelText");
			}
		}
		// Else If the datesValidType is 'selectMonthsYears', create appropriate syntax for days in range
		else if (datesValidType.compareToIgnoreCase("selectMonthsYears") == 0) {
			try {
				sqlObsStr = DateSql.getMonthsValidSql(datesValid,dateValidCol) + " AND " + DateSql.getYearsValidSql(datesValid,dateValidCol);
			}
			catch (Exception e) {
				logger.fatal("Sql.createObsDateFilter() method failed to run. Check to make sure that the datesValid string has 'YYYYmmdd' formatted dates.");
				Log.fatal("Report problem creating the observation data date filter. Possible problem with the back-end formatting of the selected dates.","#errorPanelText");
			}
		}
		else {
			logger.fatal("Could not create appropriate obs date filter part of Sql syntax");
			Log.fatal("Could not create appropriate obs date filter", "#errorPanelText");
			throw new Exception ("Could not create appropriate obs date filter part of Sql syntax");
		}
		return sqlObsStr;
	}

}
