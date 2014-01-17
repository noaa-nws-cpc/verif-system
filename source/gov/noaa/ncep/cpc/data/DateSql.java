package gov.noaa.ncep.cpc.data;

import gov.noaa.ncep.cpc.format.FormatLibrary;
import gov.noaa.ncep.cpc.qc.Log;
import gov.noaa.ncep.cpc.settings.SettingsHashLibrary;

import org.apache.log4j.Logger;
/**
Library of functions that create Sql syntax for specific date selections.
These methods to specific pieces of the date sql, not the entire line. It creates the range, or included months, years, etc. depending on the method.
*/
public class DateSql {
	static String sqlString = null;
	static Logger logger = Logger.getLogger(gov.noaa.ncep.cpc.data.DateSql.class);

	//////////////////////////////////////////
	// FORECAST SQL METHODS
	//////////////////////////////////////////

	/**
	Returns Sql syntax for date filter portion of days of forecast date issued between the dates specified in the passed String datesValid. This should be formatted as a comma delimited datesValid. Note that this can be used with multiple types of ranges, not just days, a default "01" is the convention assigned to monthly or seasonal forecast values of dates issued and valid. Therefore, in this method, the leadTimeNumberFormat will be used, including the value and associated time unit (ie. for a long-lead forecast with a lead time of 3 months, leadTimeNumberFormat = "03m", this method will use 3 months lead to find the forecasts with the appropriate date issued values and will create Sql to return values that occur in the passed date range.)
	@param datesValid Comma delimited date range in the format 'YYYYmmdd,YYYYmmdd', ie. '20010101,20090620'
	@param leadTimeNumberFormat lead time string with a numeric value and character representing the time unit of the lead to create Sql for the issued date. For example "08d" for 8 day lead forecasts, "03m" for 3 month lead forecasts. Only Integer or decimal formatted values allowed in the String.<br>
	Developers note: This method calls Settings.getSqlTimeUnit to get the appropriate Sql syntax of the time unit represented by the character representing the time unit of the passed leadTimeNumberFormat value.<br>
	This value <b>must</b> be a numeric value, ie. a decimal value needs to have a decimal in the string, not a 'pt' or other string representing the value. This value is used in the Sql query for date manipulation and is rounded to the next integer.
	<br>
	Also, the time unit character of the passed lead time must be 1 character long and the last character in the leadTimeNumberFormat String.
	@param dateIssuedCol Name of column in database of date issued
	@return Sql String portion for the date filter for a day range
	*/
	public static String getDayRangeIssuedSql(String datesValid, String leadTimeNumberFormat, String dateIssuedCol) throws Exception {
		// Get the numeric value of lead time
		String leadTimeValue = leadTimeNumberFormat.substring(0,leadTimeNumberFormat.length()-1);
		// Get the time unit associated with lead time
		// Get the index of the last character in leadTime
		// Use the Settings class to get the proper Sql syntax for the lead time unit character
		String leadTimeUnit = SettingsHashLibrary.getSqlTimeUnit(leadTimeNumberFormat.substring(leadTimeNumberFormat.length()-1));
		logger.debug("LeadTimeNumberFormat : " + leadTimeNumberFormat + " LeadTimeValue = " + leadTimeValue + " unit is : " + leadTimeUnit);
		// Get start and end dates
		String[] dates;
		String startDate;
		String endDate;
		// Parse the dates valid into an array of 2 values, a start and end date
		dates = FormatLibrary.toStringArray(datesValid,",");
		if (dates.length !=2) {
			logger.fatal("Cannot create Sql syntax for date ranges, incorrect formatting of datesValid, pass 2 dates comma delimited");
			Log.fatal("Report incorrect back-end formatting of date range for valid forecast dates", "#errorPanelText");
			throw new Exception("Cannot create Sql syntax for date ranges, incorrect formatting of dateRange, pass 2 dates comma delimited");
		}
		else {
			try {
				startDate = dates[0];
				endDate = dates[1];
				sqlString = dateIssuedCol + " BETWEEN DATE_SUB('" + Sql.toSqlDate(startDate) + "', INTERVAL " +  leadTimeValue + " " + leadTimeUnit + ") AND DATE_SUB('" + Sql.toSqlDate(endDate) + "', INTERVAL " + leadTimeValue + " " + leadTimeUnit + ")";
			}
			catch (Exception e) {
				logger.fatal("Fatal error trying to create a date range issued sql syntax. Possible problem with dates submitted as the dates valid. Make sure the datesValid is formatted as 'yyyyMMdd,yyyyMMdd' ");
				Log.fatal("Cannot create a date range", "#errorPanelText");
				throw e;
			}
		}
		return sqlString;
	}

	/**
	Returns Sql syntax for date filter portion of days of forecast date issued in the months specified in the passed String datesValid. This should be formatted as a comma or comma and semi-colon delimited datesValid. The datesValid value could look like '01,06' (all years for months Jan and Jun) or '01,06;2001,2009' (Jan and Jun months in 2001 or 2009). Only the months information would be used by this method.
	@param datesValid Comma or comma and semi-colon delimited date valid specification in the format 'mm,mm,etc.' or 'mm,mm,etc.;YYYY,YYYY,etc.'(ie. '01,06' or '01','06';'2001','2009')
	@param leadTimeNumberFormat lead time string with a numeric value and character representing the time unit of the lead to create Sql for the issued date. For example "08d" for 8 day lead forecasts, "03m" for 3 month lead forecasts. Only Integer or decimal formatted values allowed in the String.<br>
	Developers note: This method calls Settings.getSqlTimeUnit to get the appropriate Sql syntax of the time unit represented by the character representing the time unit of the passed leadTimeNumberFormat value.<br>
	This value <b>must</b> be a numeric value, ie. a decimal value needs to have a decimal in the string, not a 'pt' or other string representing the value. This value is used in the Sql query for date manipulation and is rounded to the next integer.
	<br>
	Also, the time unit character of the passed lead time must be 1 character long and the last character in the leadTimeNumberFormat String.
	@param dateIssuedCol Name of column in database of date issued
	@return Sql String portion for the date filter for a set of months
	*/
	public static String getMonthsIssuedSql(String datesValid, String leadTimeNumberFormat,String dateIssuedCol) {
		String[] months; // array of months
		// Create string buffer
		StringBuffer strBuff = new StringBuffer();
		String strDate;
				logger.debug("Lead time passed is " + leadTimeNumberFormat);
		// Get the numeric value of lead time
		String leadTimeValue = leadTimeNumberFormat.substring(0,leadTimeNumberFormat.length()-1);
		// Get the time unit associated with lead time
		// Get the index of the last character in leadTime
		// Use the Settings class to get the proper Sql syntax for the lead time unit character
		String leadTimeUnit = SettingsHashLibrary.getSqlTimeUnit(leadTimeNumberFormat.substring(leadTimeNumberFormat.length()-1));
		logger.trace("LeadTimeValue = " + leadTimeValue + " unit is : " + leadTimeUnit);
		// Get the months from dates Valid
		String[][] datesValidArray = FormatLibrary.to2DStringArray(datesValid,";",",");
		logger.trace("Number of months selected are : " + datesValidArray[0].length);
		strBuff.append("MONTH(DATE_ADD("+dateIssuedCol + ", INTERVAL " +  leadTimeValue + " " + leadTimeUnit + ")) IN (" );
		// For each of the months in the dates valid array append months in interval
		for (int i=0;i<datesValidArray[0].length;i++) {
			logger.trace("Month is : " + datesValidArray[0][i]);
			strBuff.append("MONTH('");
			// Add dummy year and day to format for Sql syntax
			strDate = "2000"+datesValidArray[0][i]+"15";
			strBuff.append(Sql.toSqlDate(strDate)); // Put in Sql date format with format YYYY-mm-dd
			strBuff.append("')");
			// Append a comma after this syntax unless it is the last value of months to append
			if (i != datesValidArray[0].length-1) {
				strBuff.append(",");
			}
		}
		strBuff.append(")");
		sqlString = strBuff.toString();
		logger.trace("The mysql date string is " + sqlString);
		return sqlString;
	}

	/**
	Returns Sql syntax for date filter portion of years of forecast date issued in the years specified in the passed String datesValid. This should be formatted as a comma or comma and semi-colon delimited datesValid. The datesValid value could look like '01,06;2001,2009' (Jan and Jun months in 2001 or 2009). Only the years information would be used by this method.
	@param datesValid Comma or comma and semi-colon delimited date valid specification in the format 'mm,mm,etc.;YYYY,YYYY,etc.' (ie. '01','06';'2001','2009')
	@param leadTimeNumberFormat lead time string with a numeric value and character representing the time unit of the lead to create Sql for the issued date. For example "08d" for 8 day lead forecasts, "03m" for 3 month lead forecasts. Only Integer or decimal formatted values allowed in the String.<br>
	Developers note: This method calls Settings.getSqlTimeUnit to get the appropriate Sql syntax of the time unit represented by the character representing the time unit of the passed leadTimeNumberFormat value.<br>
	This value <b>must</b> be a numeric value, ie. a decimal value needs to have a decimal in the string, not a 'pt' or other string representing the value. This value is used in the Sql query for date manipulation and is rounded to the next integer.
	<br>
	Also, the time unit character of the passed lead time must be 1 character long and the last character in the leadTimeNumberFormat String.
	@param dateIssuedCol Name of column in database of date issued
	@return Sql String portion for the date filter for a set of months
	*/
	public static String getYearsIssuedSql(String datesValid, String leadTimeNumberFormat,String dateIssuedCol) {
		String[] years; // array of months
		// Create string buffer
		StringBuffer strBuff = new StringBuffer();
		String strDate;
				logger.debug("Lead time passed is " + leadTimeNumberFormat);
		// Get the numeric value of lead time
		String leadTimeValue = leadTimeNumberFormat.substring(0,leadTimeNumberFormat.length()-1);
		// Get the time unit associated with lead time
		// Get the index of the last character in leadTime
		// Use the Settings class to get the proper Sql syntax for the lead time unit character
		String leadTimeUnit = SettingsHashLibrary.getSqlTimeUnit(leadTimeNumberFormat.substring(leadTimeNumberFormat.length()-1));
		logger.trace("LeadTimeValue = " + leadTimeValue + " unit is : " + leadTimeUnit);
		// Get the months from dates Valid
		String[][] datesValidArray = FormatLibrary.to2DStringArray(datesValid,";",",");
		logger.trace("Number of months selected are : " + datesValidArray[0].length);
		strBuff.append("YEAR(DATE_ADD("+dateIssuedCol + ", INTERVAL " +  leadTimeValue + " " + leadTimeUnit + ")) IN (" );
		// For each of the months in the dates valid array append months in interval
		for (int i=0;i<datesValidArray[1].length;i++) {
			logger.trace("Year is : " + datesValidArray[1][i]);
			strBuff.append("YEAR('");
			// Add dummy month and day to format for Sql syntax
			strDate = datesValidArray[1][i]+"01"+"15";
			strBuff.append(Sql.toSqlDate(strDate)); // Put in Sql date format with format YYYY-mm-dd
			strBuff.append("')");
			// Append a comma after this syntax unless it is the last value of months to append
			if (i != datesValidArray[1].length-1) {
				strBuff.append(",");
			}
		}
		strBuff.append(")");
		sqlString = strBuff.toString();
		logger.trace("The mysql date string is " + sqlString);
		return sqlString;
	}

	//////////////////////////////////////////
	// OBSERVATION SQL METHODS
	//////////////////////////////////////////

	/**
	Returns Sql syntax for dates of observation date valid between the dates specified in the passed String datesValid. This should be formatted as a comma delimited datesValid.
	@param datesValid Comma delimited date range in the format 'YYYYmmdd,YYYYmmdd', ie. '20010101,20090620'
	@param dateValidCol Name of database column with dates valid
	@return Sql String portion for a date range filter
	*/
	public static String getDayRangeValidSql(String datesValid,String dateValidCol) throws Exception {
		// Get start and end dates
		String[] dates;
		dates = FormatLibrary.toStringArray(datesValid,",");
		if (dates.length !=2) {
			logger.fatal("Cannot create Sql syntax for date ranges, incorrect formatting of datesValid, pass 2 dates comma delimited");
			Log.fatal("Report incorrect back-end formatting of date range for valid forecast dates", "#errorPanelText");
			throw new Exception("Cannot create Sql syntax for date ranges, incorrect formatting of dateRange, pass 2 dates comma delimited");
		}
		else {
			String startDate = dates[0];
			String endDate = dates[1];
			sqlString = dateValidCol + " BETWEEN '" + Sql.toSqlDate(startDate) + "' AND '" + Sql.toSqlDate(endDate) + "'";
		}
		return sqlString;
	}

	/**
	Returns Sql syntax for dates of observation date valid in the set of months passed by datesValid. This should be formatted as a comma or comma/semi-colon delimited datesValid.
	@param datesValid Comma or comma and semi-colon delimited date valid specification in the format 'mm,mm,etc.' or 'mm,mm,etc.;YYYY,YYYY,etc.' (ie. '01','06';'2001','2009')
	@param dateValidCol Name of database column with dates valid
	@return Sql String portion for a date range filter
	*/
	public static String getMonthsValidSql(String datesValid,String dateValidCol) {
		String[] months; // array of months
		// Create string buffer
		StringBuffer strBuff = new StringBuffer();
		String strDate;
		// Get the months from dates Valid
		String[][] datesValidArray = FormatLibrary.to2DStringArray(datesValid,";",",");
		logger.trace("Number of months selected are : " + datesValidArray[0].length);
		strBuff.append("MONTH("+dateValidCol + ") IN (" );
		// For each of the months in the dates valid array append months in interval
		for (int i=0;i<datesValidArray[0].length;i++) {
			logger.trace("Month is : " + datesValidArray[0][i]);
			strBuff.append("MONTH('");
			// Add dummy year and day to format for Sql syntax
			strDate = "2000"+datesValidArray[0][i]+"15";
			strBuff.append(Sql.toSqlDate(strDate)); // Put in Sql date format with format YYYY-mm-dd
			strBuff.append("')");
			// Append a comma after this syntax unless it is the last value of months to append
			if (i != datesValidArray[0].length-1) {
				strBuff.append(",");
			}
		}
		strBuff.append(")");
		sqlString = strBuff.toString();
		logger.trace("The mysql date string is " + sqlString);
		return sqlString;
	}

	/**
	Returns Sql syntax for dates of observation date valid in the set of years passed by datesValid. This should be formatted as a comma or comma/semi-colon delimited datesValid.
	@param datesValid Comma or comma and semi-colon delimited date valid specification in the format 'mm,mm,etc.;YYYY,YYYY,etc.' (ie. '01','06';'2001','2009')
	@param dateValidCol Name of database column with dates valid
	@return Sql String portion for a date range filter
	*/
	public static String getYearsValidSql(String datesValid,String dateValidCol) {
		String[] months; // array of months
		// Create string buffer
		StringBuffer strBuff = new StringBuffer();
		String strDate;
		// Get the months from dates Valid
		String[][] datesValidArray = FormatLibrary.to2DStringArray(datesValid,";",",");
		logger.trace("Number of months selected are : " + datesValidArray[1].length);
		strBuff.append("YEAR("+dateValidCol + ") IN (" );
		// For each of the months in the dates valid array append months in interval
		for (int i=0;i<datesValidArray[1].length;i++) {
			logger.trace("Year is : " + datesValidArray[1][i]);
			strBuff.append("YEAR('");
			// Add dummy year and day to format for Sql syntax
			strDate = datesValidArray[1][i]+"01"+"15";
			strBuff.append(Sql.toSqlDate(strDate)); // Put in Sql date format with format YYYY-mm-dd
			strBuff.append("')");
			// Append a comma after this syntax unless it is the last value of months to append
			if (i != datesValidArray[1].length-1) {
				strBuff.append(",");
			}
		}
		strBuff.append(")");
		sqlString = strBuff.toString();
		logger.trace("The mysql date string is " + sqlString);
		return sqlString;
	}

	/**
	Returns Sql query syntax that matches the month + year of a date issued of a forecast in a DB table with the month + year of a date valid in another reference table. This can be used for either two database/tables or two new tables created from a database 'joins' command. It should be noted that the term 'reference table' just refers to another database table, it doesn't necessasrily need to be a table of reference data. The only requirement is that this table used has a date valid column. Therefore, an observation database table could be used to return the same valid month and year as the forecast table used.
	<br>
	For 2 different database/tables :<br>
	Pass the name of the fcst database and fcst table<br>
	For 2 new temporary tables from a database joins command:<br>
	Pass an empty argument for database names (for fcst and reference) and pass the variable used as the new temporary table data (following the "AS $variable" in the joins command used to retrieve data).
 <br>
	<b>Example of returned syntax when a joins table is used: </b><br>
	MONTH(DATE_ADD(dbJoinsDataRS.date_issued, INTERVAL 02 MONTH))=MONTH(seasonalSignalRS.date_valid) AND YEAR(DATE_ADD(dbJoinsDataRS.date_issued, INTERVAL 02 MONTH))=YEAR(seasonalSignalRS.date_valid) ;
	<br>
	where the passed parameters to the method were:<br>
	<ul>
	<li> fcstDB - ""
	<li> fcstTable - "dbJoinsRS"
	<li> fcstDateIssuedColName - "date_issued"
	<li> leadTimeNumberFormat - "02"
	<li> refDB - ""
	<li> refTable "seasonalSignalRS"
	<li> refDateValidColName - "date_valid"
	</ul>
	Notes :
	<ul>
	<li>MONTH and YEAR are hard-wired in the syntax in this method to return matching month/year combinations.
	</ul>
	@param fcstDB Name of database that contains the forecast table used to build the syntax
	@param fcstTable Name of table that contains forecast data used to build the syntax (or variable assigned to a new joined table in the "AS" in the sql query (ie. (SELECT * FROM .. WHERE ...) AS dbJoinsDataRS)
	@param fcstDateIssuedColName Name of column in the forecast table of the date issued
	@param leadTimeNumberFormat lead time string with a numeric value and character representing the time unit of the lead to create Sql for the issued date. For example "08d" for 8 day lead forecasts, "03m" for 3 month lead forecasts. Only Integer or decimal formatted values allowed in the String.<br>
	Developers note: This method calls Settings.getSqlTimeUnit to get the appropriate Sql syntax of the time unit represented by the character representing the time unit of the passed leadTimeNumberFormat value.<br>
	This value <b>must</b> be a numeric value, ie. a decimal value needs to have a decimal in the string, not a 'pt' or other string representing the value. This value is used in the Sql query for date manipulation and is rounded to the next integer.
	@param refDB Name of database that contains the reference table used to build the syntax (or variable assigned to a new joined table in the "AS" in the sql query (ie. (SELECT * FROM .. WHERE ...) AS seasonalSignalRS)
	@param refTable Name of table that contains reference data used to build the syntax
	@param refDateValidColName Name of column in the reference table of the date valid.
	@return String piece of Sql syntax that matches the valid date month and year (paired) of a forecast and other reference database table.
	*/
	public static String getSameMonthYearFcstSql(String fcstDB,String fcstTable,String fcstDateIssuedColName,String leadTimeNumberFormat,String refDB, String refTable,String refDateValidColName) {
		// Get the numeric value of lead time
		String leadTimeValue = leadTimeNumberFormat.substring(0,leadTimeNumberFormat.length()-1);
		// Get the time unit associated with lead time
		// Get the index of the last character in leadTime
		// Use the Settings class to get the proper Sql syntax for the lead time unit character
		String leadTimeUnit = SettingsHashLibrary.getSqlTimeUnit(leadTimeNumberFormat.substring(leadTimeNumberFormat.length()-1));
		logger.trace("LeadTimeValue = " + leadTimeValue + " unit is : " + leadTimeUnit);

		// If there is a DB passed for the forecast, put a "." after to append to table
		if (fcstDB != "") {
			fcstDB = fcstDB + ".";
		}
		// If there is a DB passed for the reference, put a "." after to append to table
		if (refDB != "") {
			refDB = refDB + ".";
		}
		// Put Sql pieces together
		String sqlString = "MONTH(DATE_ADD(" + fcstDB + fcstTable + "." + fcstDateIssuedColName + ", INTERVAL " + leadTimeValue + " " + leadTimeUnit + "))=MONTH(" + refDB + refTable + "." + refDateValidColName + ") AND YEAR(DATE_ADD(" + fcstDB + fcstTable + "." + fcstDateIssuedColName +", INTERVAL " + leadTimeValue + " " + leadTimeUnit + "))=YEAR(" + refDB + refTable + "." + refDateValidColName + ")";
		// Return Sql syntax string
		return sqlString;
	}


	/**
	Returns Sql query syntax that matches the month + year of a date valid of an observation dataset in a DB table with the month + year of a date valid in another reference table. This can be used for either two database/tables or two new tables created from a database 'joins' command. It should be noted that the term 'reference table' just refers to another database table, it doesn't necessasrily need to be a table of reference data. The only requirement is that this table used has a date valid column. Therefore, another observation database table could be used to return the same valid month and year as the first observation table used.
	<br>
	For 2 different database/tables :<br>
	Pass the name of the fcst database and fcst table<br>
	For 2 new temporary tables from a database joins command:<br>
	Pass an empty argument for database names (for fcst and reference) and pass the variable used as the new temporary table data (following the "AS $variable" in the joins command used to retrieve data).
 <br>
	<b>Example of returned syntax when a joins table is used: </b><br>
	MONTH(DATE_ADD(dbJoinsDataRS.date_valid, INTERVAL 02 MONTH))=MONTH(seasonalSignalRS.date_valid) AND YEAR(DATE_ADD(dbJoinsDataRS.date_valid, INTERVAL 02 MONTH))=YEAR(seasonalSignalRS.date_valid) ;
	<br>
	where the passed parameters to the method were:<br>
	<ul>
	<li> obsDB - ""
	<li> obsTable - "dbJoinsRS"
	<li> obsDateValidColName - "date_issued"
	<li> refDB - ""
	<li> refTable "seasonalSignalRS"
	<li> refDateValidColName - "date_valid"
	</ul>
	@param obsDB Name of database that contains the observation table used to build the syntax
	@param obsTable Name of the observation table that contains observation data used to build the syntax (or variable assigned to a new joined table in the "AS" in the sql query (ie. (SELECT * FROM .. WHERE ...) AS dbJoinsDataRS)
	@param obsDateValidColName Name of column in the observation table of the date valid
	@param refDB Name of database that contains the reference table used to build the syntax
	@param refTable Name of table that contains reference data used to build the syntax
	@param refDateValidColName Name of column in the reference table of the date valid.
	@return String piece of Sql syntax that matches the valid date month and year (paired) of an observation table and other reference database table.
	*/
	public static String getSameMonthYearObsSql(String obsDB,String obsTable,String obsDateValidColName,String refDB, String refTable,String refDateValidColName) {

		// If there is a DB passed for the observation, put a "." after to append to table
		if (obsDB != "") {
			obsDB = obsDB + ".";
		}
		// If there is a DB passed for the reference, put a "." after to append to table
		if (refDB != "") {
			refDB = refDB + ".";
		}
		// Put Sql pieces together
		String sqlString = "MONTH(" + obsDB + obsTable + "." + obsDateValidColName + ")=MONTH(" + refDB + refTable + "." + refDateValidColName + ") AND YEAR(" + obsDB + obsTable + "." + obsDateValidColName + ")=YEAR(" + refDB + refTable + "." + refDateValidColName + ")";
		// Return Sql syntax string
		return sqlString;
	}
}
