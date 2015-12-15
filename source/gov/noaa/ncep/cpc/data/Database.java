package gov.noaa.ncep.cpc.data;

//-------------------------------------------------------------------
// Import all packages needed
//-------------------------------------------------------------------
import gov.noaa.ncep.cpc.format.FormatLibrary;
import gov.noaa.ncep.cpc.qc.Log;
import gov.noaa.ncep.cpc.settings.Settings;
import gov.noaa.ncep.cpc.settings.SettingsHashLibrary;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import org.apache.commons.lang.WordUtils;
import org.apache.log4j.Logger;

/**
Provides methods dealing with the communication with the database. To
use these methods, one should create a Database object first.
*/
public class Database {
	//---------------------------------------------------------------
	// Initialize variables
	//---------------------------------------------------------------
	static Logger logger = Logger.getLogger(gov.noaa.ncep.cpc.data.Database.class);
	static float missingValue = -999; // Missing value flag in DB

	//---------------------------------------------------------------
	// Methods involving the result set of a database query
	// These were created to minimize the number of separate queries
	// to the database for efficiency.
	//---------------------------------------------------------------

	/**
	Returns a result set based on the passed sql query. To actually extract the results as a string, MUST call
	another method in this class that pulls results from the resultSet (after calling this method), such as getRSResults(). Those methods will
	properly set the row to retrieve results properly.
	@param sqlQuery Sql query ("SELECT .... FROM ..") that you want retrieve the result set for.
	@param dbConnection database connection to use for the database.
	@return result set based on query passed.
	*/
	public static ResultSet getResultSet(String sqlQuery, Connection dbConnection) throws Exception {
		ResultSet rs = null;
		ResultSet results = null;
		Statement stmt;
		try {
			stmt = dbConnection.createStatement();
			if (stmt.execute(sqlQuery)) {
           			rs = stmt.getResultSet();
			}
		} catch (Exception e) {
			// Handle errors
			logger.fatal("There was a problem retrieving the result set from the database: "+ e + " See Database.getResultSet() method.");
			Log.fatal("There was a problem retrieving the result set from the database", "#errorPanelText");
			throw e;
		}
		return rs;
	}

	/**
	Returns the number of rows in a result set.
	@param rs Result set from a database.
	@return The number of rows in the result set.
	*/
	public static int getNumRSRows(ResultSet rs) throws Exception {
		int numRows = 0;
		// Check for null result set
		try {
			// Get the size of the results
			rs.last();
			numRows = rs.getRow();
		// Reset to first row
			rs.beforeFirst();
		} catch (Exception e) {
			// Handle errors
			logger.fatal("There was a problem getting the number of rows from the result set" + e);
			Log.fatal("There was a problem getting the number of rows from the result set " , "#errorPanelText");
			throw e;
		}
		return numRows;
	}

	/**
	Returns the values of the result set of the passed column name. This column name needs
	to exist as a column in the passed result set in order to successfully pass information back.
	@param columnName The name of the column in the result set you want to return results for.
	@param rs The result set to retrieve data from.
	@return String array of results from the result set of the column name passed.
	*/
	public static String[] getRSResults(String columnName, ResultSet rs) throws Exception {
		// Reset to first row
		try {
			rs.beforeFirst();
		} catch (Exception e) {
			logger.fatal("Problem trying to reset result set row index to 0.");
			Log.fatal("Report problem trying to result setting row index to 0.","#errorPanelText");
			throw e;
		}
		// Get the number of rows
		int numRows = getNumRSRows(rs);
		logger.debug("Number of rows : " + numRows);
		String[] rsArray = new String[numRows];
		// Put results in array
		try {
			//rs.beforeFirst();
			for (int i=0;i<numRows;i++) {
				// Get the value from the ResultSet
				rs.next();
				rsArray[i] = rs.getString(columnName);
			}
		} catch (Exception e) {
			// Handle errors
			logger.fatal("There was a problem getting the column of data for " + columnName + " " + e);
			Log.fatal("There was a problem getting the column of data for " + columnName, "#errorPanelText");
			throw e;
		}
		return rsArray;
	}

	/**
	Returns an array of unique values of data in the passed result set of the passed
	column name. This column must exist in the passed result set or else an exception will be thrown.
	@param columnName Name of the column of data of the result set that you want to return results for.
	@param rs Result set to retrieve the column of data from.
	@return String array of unique values from the passed result set of the passed column name.
	The order in the returned array retains the order of the values in the result set.
	*/
	public static String[] getUniqueRSResults(String columnName, ResultSet rs) throws Exception {
		String[] resultsArray = null;
		// Reset to first row
		try {
			rs.beforeFirst();
		} catch (Exception e) {
			logger.fatal("Problem trying to reset result set row index to 0.");
			Log.fatal("Report problem trying to result setting row index to 0.","#errorPanelText");
			throw e;
		}
		try {
			// Get array of results
			resultsArray = getRSResults(columnName,rs);
		} catch (Exception e) {
			logger.fatal("The values for column " + rs + " could not be retrieved from the passed results set");
			throw e;
		}
		// Call method to get unique values of array
		String[] uniqueArray = FormatLibrary.getUniqueArray(resultsArray);
		return uniqueArray;
	}

	/**
	Returns the count of unique number of occurrences of the column in the result set of the passed
	column name. This column must exist in the passed result set or else an exception will be thrown.
	@param columnName Name of the column of data of the result set that you want to return results for.
	@param rs Result set to retrieve the column of data from.
	@return Integer value representing the count of the unique occurrences of values in the result set
	for the passed column name.
	*/
	public static int getUniqueRSCount(String columnName, ResultSet rs) throws Exception {
		String[] uniqueArray = null;
		// Reset to first row
		try {
			rs.beforeFirst();
		} catch (Exception e) {
			logger.fatal("Problem trying to reset result set row index to 0.");
			Log.fatal("Report problem trying to result setting row index to 0.","#errorPanelText");
			throw e;
		}
		int numUniqueValues = -1;
		try {
			// Get array of results
			uniqueArray = getUniqueRSResults(columnName,rs);
		} catch (Exception e) {
			logger.fatal("Could not retrieve a unique array results from the passed result set and column name. Therefore the count could not be returned.");
			throw e;
		}
		numUniqueValues = uniqueArray.length;
		return numUniqueValues;
	}

	/**
	Returns an array of 2 values representing the first and last values of the result set, respectively based on the passed column name.
	@param columnName Name of the column of data of the result set that you want to return results for.
	@param rs Result set to retrieve the column of data from.
	@param fcstSource Forecast source this ResultSet applies to (used to inform the user what model failed, if necessary)
	@return String array of unique values from the passed result set of the passed column name.
	The order in the returned array retains the order of the values in the result set.
	*/
	public static String[] getFirstAndLastResults(String columnName, ResultSet rs, String fcstSource) throws Exception {
		String[] resultsArray = null;
		// Reset to first row
		try {
			rs.beforeFirst();
		} catch (Exception e) {
			logger.fatal("Problem trying to reset result set row index to 0.");
			Log.fatal("Report problem trying to result setting row index to 0.","#errorPanelText");
			throw e;
		}
		try {
			// Get array of results
			resultsArray = getRSResults(columnName,rs);
		} catch (Exception e) {
			logger.fatal("The values for column " + rs + " could not be retrieved from the passed results set");
			throw e;
		}
		// If there are zero results, then fail with an appropriate message to the user. Most likely
		// none of the models have data during the period provided
		if (resultsArray.length <= 0) {
			logger.fatal(fcstSource+" has no data during the selected period (some models are fairly recent). Most likely the selected period is not recent enough. Please select a different period.");
			throw new Exception(fcstSource+" has no data during the selected period (some models are fairly recent). Most likely the selected period is not recent enough. Please select a different period.");
		} 
		// Get the first and last value
		try {
			rs.first(); // Go to first result
			resultsArray[0] = rs.getString(columnName);
			rs.last(); // Go to last result
			resultsArray[1] = rs.getString(columnName);
			rs.beforeFirst(); // Rewind for default
		} catch (Exception e) {
			logger.fatal("Problem trying to retrieve first and last values or going to default row of result set of "+fcstSource+".");
			Log.fatal("Report problem trying to retrieve first and last results of "+fcstSource+".","#errorPanelText");
			throw e;
		}
		return resultsArray;
	}

	/**
	Returns a 3-dimensional array of forecast probability values from the passed result set. These column
	names must exist in the passed result set or else an exception will be thrown :<br>
	"prob_below","prob_normal","prob_above"<br>
	<br>
	The dimensions are numDays, numLocations, forecast category index (float[numDays][numLocations][# forecast categories] . The last dimension is set to 3 forecast categories for below, normal, and above in that respective order.
	<br>
	This method assumes that you know the number of days and locations associated with the result set.
	You can retrieve these pieces of information by calling getUniqueRSCount() in this class and passing the column names representing the locations and dates to that method.
	@param numDays       Number of days to expect data for (helps to shape arrays correctly)
	@param numLocations  Number of locations to expect data for (helps to shape arrays correctly)
	@param rs Result set from the database with the forecast data.
	@return 3-dimensional float array of forecast data in the structure of float[numDays][numLocations][# forecast categories] where the last dimension of forecast categories contains the below normal forecast probabilities (index 0), normal category probabilities (index 1), and above normal category probabilities (index 2).
	*/
	public static float[][][] retrieveFcstProbs(int numDays, int numLocations,ResultSet rs) throws Exception {
		float[][][] fcstProb = new float[numDays][numLocations][3];
		// Reset to first row
		try {
			rs.beforeFirst();
		} catch (Exception e) {
			logger.fatal("Problem trying to reset result set row index to 0.");
			Log.fatal("Report problem trying to result setting row index to 0.","#errorPanelText");
			throw e;
		}
		try {
			//-------------------------------------------------------
			// Extract data from ResultSet
			//-------------------------------------------------------
			// Loop over all days
			for (int d = 0; d < numDays; d++) {
				// Loop over all locations
				for (int l = 0; l < numLocations; l++) {
					// Go to the next ResultSet line
					//logger.trace("In ResultSet loop, I'm at ("+d+","+l+")");
					rs.next();
					// Get probabilites, then set them to NULL if they were NULL in the DB
					fcstProb[d][l][0] = rs.getFloat("prob_below");
					if (rs.wasNull() || fcstProb[d][l][0] == missingValue) {fcstProb[d][l][0] = Float.NaN;}
					fcstProb[d][l][1] = rs.getFloat("prob_normal");
					if (rs.wasNull() || fcstProb[d][l][0] == missingValue) {fcstProb[d][l][1] = Float.NaN;}
					fcstProb[d][l][2] = rs.getFloat("prob_above");
					if (rs.wasNull() || fcstProb[d][l][0] == missingValue) {fcstProb[d][l][2] = Float.NaN;}
				}
			}
		} catch (Exception e) {
			// handle any errors
			logger.fatal("# of days passed for fcst array is : " + numDays + " , # locations for fcst array is : " + numLocations); 
			logger.fatal("There was a problem extracting forecast data from the result set passed. Make sure the column name for the 3 categories of forecast are correct, especially if the syntax involves a joins table that has different column names. Exception : " + e);
			Log.fatal("Report problem extracting forecast data from the result set.", "#errorPanelText");
			throw e;
		}
		return fcstProb;
	}

	/**
	Converts a ResultSet into a 2-d float array. The column name must exist in the passed
	result set or else an exception will be thrown.
	<br>
	The dimensions of the resulting array are numDays by numLocations (float[numDays][numLocations]).
	<br>
	This method assumes that you know the number of days and locations associated with the result set.
	You can retrieve these pieces of information by calling getUniqueRSCount() in this class and passing the column names representing the locations and dates to that method.
	@param numDays       Number of days to expect data for (helps to shape arrays correctly)
	@param numLocations  Number of locations to expect data for (helps to shape arrays correctly)
	@param column        Column from the ResultSet that will be placed in a 2-d array
	@param rs Result set from the database with the forecast data.

	@return 2-dimensional float array of the provided column name in the structure of float[numDays][numLocations].
	*/
	public static float[][] resultSetTo2DFloatArray(int numDays, int numLocations, String column, ResultSet rs) throws Exception {
		//---------------------------------------------------------------
		// Initialize variables
		//---------------------------------------------------------------
		float[][] array = new float[numDays][numLocations];
		// Reset to first row
		try {
			rs.beforeFirst();
		} catch (Exception e) {
			logger.fatal("Problem trying to reset result set row index to 0.");
			Log.fatal("Report problem trying to result setting row index to 0.","#errorPanelText");
			throw e;
		}
		// Execute the query
		try {
			//-------------------------------------------------------
			// Extract data from ResultSet
			//-------------------------------------------------------
			// Loop over all days
			for (int d = 0; d < numDays; d++) {
				// Loop over all locations
				for (int l = 0; l < numLocations; l++) {
					// Go to the next ResultSet line
					rs.next();
					// Get category, then set it to NULL if it was NULL in the DB
					array[d][l] = rs.getFloat(column);
					//logger.trace("Observation category : " + array[d][l]);
					if (rs.wasNull()) {array[d][l] = Float.NaN;}
				}
			}
		} catch (Exception e) {
			// handle any errors
			logger.fatal("Couldn't extract the "+column+"variable from the given ResultSet");
			Log.fatal("Encountered an error, the database is probably missing some data.", "#errorPanelText");
			throw e;
		}
		return array;
	}

	//---------------------------------------------------------------
	// Most of the methods below are no longer typically used by the verification process
	// due to the slowness of making multiple queries to the database
	// but are kept in to use for debugging or general use
	//---------------------------------------------------------------

	/**
	Returns an integer value of the number of unique occurences of the passed column name (colName) as specified in the passed sqlQuery. For example, you can pass a sqlQuery String that is used to obtain forecast data from the database, and pass 'date_issued' as the colName. This would return all the unique occurences of dates issued where the query is true. This would avoid the repeated dates associated with multiple locations in the database with forecast data.
	@param colName column name in the database to return the count for unique occurences of these values.
	@param sqlQuery Sql query ("SELECT .... FROM..") that you want to use to get the count for.
	@param dbConnection database connection to use for the database.
	@return integer value of the count found of unique occurences of the column of value colName in the passed Sql query.
	*/
	public static int getUniqueCount(String colName, String sqlQuery, Connection dbConnection) throws Exception {
		logger.debug("Getting unique count for " + colName);
		// Initialize variables
		ResultSet rs = null;
		int numPoints  = 0;
		// Concatenate Sql for unique counts to the passed query.
		String countSqlQuery = "SELECT COUNT(DISTINCT " + colName + ") AS count FROM (" + sqlQuery + ") AS results;";
		logger.debug("Count query is : " + countSqlQuery);
		try {
			rs = dbConnection.createStatement().executeQuery(countSqlQuery);
			// Get the value from the ResultSet
			rs.next();
			numPoints = rs.getInt("count");
		} catch (Exception e) {
			// Handle errors
			logger.fatal("There was a problem getting the number of unique occurrences from the database column " + colName + ": " + e);
			Log.fatal("There was a problem getting the number of unique occurrences from the database column " + colName, "#errorPanelText");
			throw e;
		}
		return numPoints ;
	}

	/**
	Returns the number of rows of results by querying the database by passed sqlQuery for the passed column name. This returns the number of results for the query.
	@param colName Column name of database used in sqlQuery
	@param sqlQuery Sql query to use for database request
	@param dbConnection Database connection
	@return number of rows from sqlQuery for colName
	*/
	public static int getNumRows(String colName, String sqlQuery, Connection dbConnection) throws Exception {
		logger.debug("Getting # rows for " + colName);
		// Initialize variables
		ResultSet rs = null;
		int numPoints  = 0;
		// Concatenate Sql for unique counts to the passed query.
		String countSqlQuery = "SELECT COUNT(" + colName + ") AS count FROM (" + sqlQuery + ") AS results;";
		logger.trace("Count query is : " + countSqlQuery);
		try {
			rs = dbConnection.createStatement().executeQuery(countSqlQuery);
			// Get the value from the ResultSet
			rs.next();
			numPoints   = rs.getInt("count");
		} catch (Exception e) {
			// Handle errors
			logger.fatal("Encountered a database error when attempting to retrieve the number of rows of db column " + colName + ": " + e);
			Log.fatal("Report database error when attempting to retrieve the number of rows of db column " + colName, "#errorPanelText");
			throw e;
		}
		return numPoints ;
	}

	/**
	Returns a string array of results from the database of the passed columm name (colName) for the passed sqlQuery. <br>
	Note : This method calls another method to calculate the number of rows
	of results in order to allocate space for the returned array.
	@param colName column name to return results for
	@param sqlQuery Sql query to use to get results from the database
	@param dbConnection Database connection
	@return String array of results from the database
	*/
	public static String[] getColResults(String colName, String sqlQuery, Connection dbConnection) throws Exception {
		// Initialize variables
		ResultSet rs = null;
		String [] rsArray = null;
		int numValues = 0;
		logger.trace("Getting count of results of column " + colName + " so can allocate space to array with returned results");
		// Get the size of results to allocate space to String array of results
		try {
			numValues = getNumRows(colName,sqlQuery,dbConnection);
			rsArray = new String[numValues];
			logger.debug("Number of rows for results are : " + numValues);
		}
		catch(Exception e) {
			logger.warn("Getting size of results by calling getNumRows("+colName+") did not run successfully. Therefore can't return a String array of results.");
		}
		// Concatenate Sql to get results for the passed query and colName
		String resultsSqlQuery =  "SELECT " + colName + " AS data FROM (" + sqlQuery + ") AS results;";
		logger.trace("QUERY IS " + resultsSqlQuery);
		try {
			rs = dbConnection.createStatement().executeQuery(resultsSqlQuery);
			logger.trace("Completed getting column resuls");
			for (int i=0;i<numValues;i++) {
				// Get the value from the ResultSet
				rs.next();
				rsArray[i] = rs.getString("data");
			}
		}
		catch (Exception e) {
			// Handle errors
			logger.fatal("Encounted a database error when attempting to retrieve the results from db column " + colName);
			Log.fatal("Encounted a database error when attempting to retrieve the results from the database","#errorPanelText");
			throw e;
		}
		return rsArray;
	}
	
	/**
	Returns a string array of results from the database of the passed column name (colName) for the passed sqlQuery. <br>
	Note : This is an overloaded method, this method accepts a ResultSet that has already been retrieved
	from the database, the other method accepts an SQL string and retrieves the ResultSet first before
	retrieving the column.

	@param colName column name to return results for
	@param rs Result set containing data
	@return String array of results from the database
	*/
	public static String[] getColResults(String colName, ResultSet rs) throws Exception {
		// Initialize variables
		String [] outArray = null;
		int numValues = 0;
		// Get the size of results to allocate space to String array of results
		try {
			numValues = getNumRSRows(rs);
			outArray = new String[numValues];
			logger.debug("Number of rows for results are : " + numValues);
		}
		catch(Exception e) {
			logger.warn("Getting size of results by calling getNumRows("+colName+") did not run successfully. Therefore can't return a String array of results.");
		}
		// Loop over ResultSet and extract the specified column
		try {
			for (int i=0;i<numValues;i++) {
				// Get the value from the ResultSet
				rs.next();
				outArray[i] = rs.getString(colName);
			}
		}
		catch (Exception e) {
			// Handle errors
			logger.fatal("Encounted a database error when attempting to retrieve the " + colName + " column from the ResultSet");
			Log.fatal("Encounted a database error when attempting to retrieve the " + colName + " column from the ResultSet", "#errorPanelText");
			throw e;
		}
		return outArray;
	}

	/**
	Returns a string array of unique results from the database of the passed columm name (colName) for the passed sqlQuery. <br>
	Note : This method calls another method to calculate the number of rows
	of results in order to allocate space for the returned array.
	@param colName column name to return results for
	@param sqlQuery Sql query to use to get results from the database
	@param dbConnection Database connection
	@return String array of results from the database
	*/
	public static String[] getUniqueColResults(String colName, String sqlQuery, Connection dbConnection) throws Exception {
		// Initialize variables
		ResultSet rs = null;
		String [] rsArray = null;
		int numValues = 0;
		logger.trace("Getting count of results of column " + colName + " so can allocate space to array with returned results");
		// Get the size of results to allocate space to String array of results
		try {
			numValues = getUniqueCount(colName,sqlQuery,dbConnection);
			rsArray = new String[numValues];
			logger.debug("Number of rows for results are : " + numValues);
		}
		catch(Exception e) {
			logger.warn("Getting size of results by calling getUniqueCount("+colName+") did not run successfully. Therefore can't return a String array of results.");
		}
		// Concatenate Sql to get results for the passed query and colName
		String resultsSqlQuery =  "SELECT DISTINCT " + colName + " AS data FROM (" + sqlQuery + ") AS results;";
		logger.trace("QUERY IS " + resultsSqlQuery);
		try {
			rs = dbConnection.createStatement().executeQuery(resultsSqlQuery);
			logger.trace("Completed getting column resuls");
			for (int i=0;i<numValues;i++) {
				// Get the value from the ResultSet
				rs.next();
				rsArray[i] = rs.getString("data");
			}
		}
		catch (Exception e) {
			// Handle errors
			logger.fatal("Encounted a database error when attempting to retrieve the results from db column " + colName);
			Log.fatal("Encounted a database error when attempting to retrieve the results from db column " + colName + ": " + e, "#errorPanelText");
			throw e;
		}
		return rsArray;
	}

	/**
	Returns the first available valid date of the forecast of the database results. This method assumes that the forecaset database is getting queried, which is why the column name of the date issued is passed. The lead time is passed to figure out the valid time based on the issued time. The value returned is the valid date calculated from the date issued value in the forecast database.
	@param dateIssuedCol Name of the column of the date issued
	@param leadTimeNumberFormat time with the value of lead and a character representing the time unit, ie. "08d" for an 8-day lead forecast. This will be used to create the proper valid date applied to the forecast date issued values. This must be either an integer or decimal formatted leadTime, for example, '0pt5m' cannot be passed, '0.5m' should be passed. To get this formatted leadTime, see the Settings.getLeadTimeNumberFormat() method in the settings package.
	@param sqlQuery Sql query to find first row of results for. An example of passed query would be :<br>
	sqlQuery = "SELECT " + columns + " FROM " + fcstDBName + "." + dataTableName + " AS data, (SELECT id FROM cpc_reference." + refTableName + " WHERE " + regionType + " IN (" + regionList + ")) AS locationList WHERE " + dateFilter + " AND data.id=locationList.id ORDER BY " + dateName;<br>
	where columns must include at least the dateIssuedCol.
	@param dbConnection Database connection
	@return First available valid date of the forecast using the Sql query passed
	*/
	public static String getFirstValidDate(String dateIssuedCol, String leadTimeNumberFormat, String sqlQuery, Connection dbConnection) throws Exception {
		// Initialize variables
		ResultSet rs = null;
		String rsStr = null;
		String leadTimeValue = leadTimeNumberFormat.substring(0,leadTimeNumberFormat.length()-1);
		logger.debug("LeadTimeValue = " + leadTimeValue);
		// Get the time unit associated with lead time
		// Get the index of the last character in leadTime
		// Use the Settings class to get the proper Sql syntax for the lead time unit character
		String leadTimeUnit = SettingsHashLibrary.getSqlTimeUnit(leadTimeNumberFormat.substring(leadTimeNumberFormat.length()-1));
		String resultsSqlQuery = "SELECT DATE_ADD(" + dateIssuedCol + ", INTERVAL " + leadTimeValue + " " + leadTimeUnit + ") AS data FROM (" + sqlQuery + " LIMIT 1) AS results;";
		logger.debug("Query to get first row of column " + dateIssuedCol + " : " + resultsSqlQuery);
		try {
			rs = dbConnection.createStatement().executeQuery(resultsSqlQuery);
			rs.next();
			rsStr = rs.getString("data");
		}
		catch (Exception e) {
			// Handle errors
			logger.fatal("Encountered a database error when attempting to retrieve the first row results from db column " + dateIssuedCol + ". Make sure Sql query is valid. Possible problems could be incorrectly formatted information in the query: " + e);
			Log.fatal("Encountered a database error when attempting to retrieve the first row results from db column " + dateIssuedCol, "#errorPanelText");
			throw e;
		}
		return rsStr;
	}

	/**
	Returns the last available valid date of the forecast of the database results. This method assumes that the forecaset database is getting queried, which is why the column name of the date issued is passed. The lead time is passed to figure out the valid time based on the issued time. The value returned is the valid date calculated from the date issued value in the forecast database.
	@param dateIssuedCol Name of the column of the date issued
	@param leadTime time with the value of lead and a character representing the time unit, ie. "08d" for an 8-day lead forecast. This will be used to create the proper valid date applied to the forecast date issued values.
	@param sqlQuery Sql query to find first row of results for. An example of passed query would be :<br>
	sqlQuery = "SELECT " + columns + " FROM " + fcstDBName + "." + dataTableName + " AS data, (SELECT id FROM cpc_reference." + refTableName + " WHERE " + regionType + " IN (" + regionList + ")) AS locationList WHERE " + dateFilter + " AND data.id=locationList.id ORDER BY " + dateName;<br>
	where columns must include at least the dateIssuedCol.
	@param dbConnection Database connection
	@return Last available valid date of the forecast using the Sql query passed
	*/
	public static String getLastValidDate(String dateIssuedCol, String leadTime, String sqlQuery, Connection dbConnection) throws Exception {
		// Initialize variables
		ResultSet rs = null;
		String rsStr = null;
		String leadTimeValue = leadTime.substring(0,leadTime.length()-1);
		logger.trace("LeadTimeValue = " + leadTimeValue);
		// Get the time unit associated with lead time
		// Get the index of the last character in leadTime
		// Use the Settings class to get the proper Sql syntax for the lead time unit character
		String leadTimeUnit = SettingsHashLibrary.getSqlTimeUnit(leadTime.substring(leadTime.length()-1));
		String resultsSqlQuery = "SELECT DATE_ADD(" + dateIssuedCol + ", INTERVAL " + leadTimeValue + " " + leadTimeUnit + ") AS data FROM (" + sqlQuery  + " DESC LIMIT 1) AS results;";
		logger.debug("Query to get the last row of column " + dateIssuedCol + " : " + resultsSqlQuery);
		try {
			rs = dbConnection.createStatement().executeQuery(resultsSqlQuery);
			rs.next();
			rsStr = rs.getString("data");
		}
		catch (Exception e) {
			// Handle errors
			logger.fatal("Encountered a database error when attempting to retrieve the last row results from db column " + dateIssuedCol + ". Make sure Sql query is valid. Possible problems could be incorrectly formatted information in the query: " + e);
			Log.fatal("Encountered a database error when attempting to retrieve the last row results from db column " + dateIssuedCol + ". Make sure Sql query is valid. Possible problems could be incorrectly formatted information in the query.", "#errorPanelText");
			throw e;
		}
		return rsStr;
	}
	//---------------------------------------------------------------
	// End of unpreferred operational methods
	//---------------------------------------------------------------

	/**
	Returns the number of locations in the verification region(s)
    @param settingsObj  Settings object from which to retrieve the settings
	@param dbConnection Database connection to retrieve this information from
	@return             Number of locations
	*/
	public static int getNumLocations(Settings settingsObj, Connection dbConnection) throws Exception {
		// Initialize variables
		String regions     = settingsObj.getRegions();
		String spatialType = settingsObj.getSpatialType();
		String regionType  = settingsObj.getRegionType();
		String refDBName   = settingsObj.getRefDBName();
		ResultSet rs = null;
		int numLocations = 0;
		String regionList;
		String spatialTypeStr;
		logger.info("regions     : " + regions);
		logger.info("spatialType : " + spatialType);
		logger.info("regionType  : " + regionType);
		// Convert the regions to a comma-separated list of strings,
		// each surrounded by single quotes (eg. 'TX','LA','MS')

		regionList = Sql.regionsToRegex(regions, regionType);

		// Determine the number of dates and locations
		try {
			// Execute a query that will return the number of locations
			// that went into the full SQL query
			rs = dbConnection.createStatement().executeQuery("SELECT COUNT(id) AS numLocations FROM " + refDBName + "." + Sql.getRefTableName(spatialType) + " WHERE " + refDBName + "." + Sql.getRefTableName(spatialType) + "." + regionType + " RLIKE '(" + regionList + ")'");
			// Get the value from the ResultSet
			rs.next();
			numLocations = rs.getInt("numLocations");
		} catch (Exception e) {
			// Handle errors
			Log.fatal("Encountered a database error when attempting to retrieve the number of locations", "#errorPanelText");
			logger.fatal("Encountered a database error when attempting to retrieve the number of locations: " + e);
			throw e;
		}
		return numLocations;
	}

	/**
	Returns an array of the data in the 'id' column of a spatial reference table associated with the passed arguments for select regions, spatial type (stn,CD,gridded), and regionType(climateDivision,climateRegion). This can be an array of WMO number (station table), grid point number (gridded table), and climate division number (climate division table), etc.
    @param settingsObj  Settings object from which to retrieve the settings
	@param dbConnection Database connection to retrieve this information from
	@return  Array of location names
	*/
	public static String[] getIdArray(Settings settingsObj, Connection dbConnection) throws Exception {
		// Initialize variables
		String regions     = settingsObj.getRegions();
		String spatialType = settingsObj.getSpatialType();
		String regionType  = settingsObj.getRegionType();
		String refDBName   = settingsObj.getRefDBName();
		ResultSet rs = null;
		String spatialTypeStr = null;
		String regionList = null;
		String[] locationIdArray = null;
		String sqlQuery = null;
		// Convert the regions to a comma-separated list of strings,
		// each surrounded by single quotes (eg. 'TX','LA','MS')
		regionList = Sql.regionsToRegex(regions, regionType);

		// Try to execute an SQL query
		try {
			// For ClimateDivisions, use the id column in the WHERE clause
			if (spatialType.compareToIgnoreCase("climateDivision") == 0) {
				sqlQuery = "SELECT id AS locationId FROM " + refDBName + "." + Sql.getRefTableName(spatialType) + " WHERE id RLIKE '(" + regionList + ")'";
			// For station or gridded, use the column specified by the regionType variable
			} else {
				sqlQuery = "SELECT id AS locationId FROM " + refDBName + "." + Sql.getRefTableName(spatialType) + " WHERE " + regionType + " RLIKE '(" + regionList + ")'";
			}
			logger.debug("Query to retrieve the location ID array: " + sqlQuery);
			rs = dbConnection.createStatement().executeQuery(sqlQuery);
			// Determine the total number of rows
			rs.last();
			int numRows = rs.getRow();
			logger.debug("NUMROWS = " + numRows);
			rs.beforeFirst();
			// Allocate space for array
			locationIdArray = new String[numRows];
			// Get the value from the ResultSet
			for (int i=0; i<numRows; i++) {
				rs.next();
				locationIdArray[i] = rs.getString("locationId");
			}
		} catch (Exception e) {
			// handle any errors
			Log.fatal("Encountered an error when attempting to retrieve the IDs of all requested verification regions", "#errorPanelText");
			logger.fatal("Encountered an error when attempting to retrieve the IDs of all requested verification regions: " + e);
			throw e;
		}
		return locationIdArray;
	}

	/**
	Returns an array of the names of locations to be verified. This can be an array of
	station names, climate division names, etc.
    @param settingsObj  Settings object from which to retrieve the settings
	@param dbConnection Database connection to retrieve this information from
	@return  Array of location names
	*/
	public static String[] getLocationNameArray(Settings settingsObj, Connection dbConnection) throws Exception {
		// Initialize variables
		String regions     = settingsObj.getRegions();
		String spatialType = settingsObj.getSpatialType();
		String regionType  = settingsObj.getRegionType();
		String refDBName   = settingsObj.getRefDBName();
		ResultSet rs = null;
		String spatialTypeStr = null;
		String regionList = null;
		String[] locationNameArray = null;
		String sqlQuery = null;
		// Convert the regions to a comma-separated list of strings,
		// each surrounded by single quotes (eg. 'TX','LA','MS')
		regionList = Sql.regionsToRegex(regions, regionType);
		// Try to execute an SQL query
		try {
			sqlQuery = "SELECT name AS locationName FROM " + refDBName + "." + Sql.getRefTableName(spatialType) + " WHERE " + refDBName + "." + Sql.getRefTableName(spatialType) + "." + regionType + " RLIKE '(" + regionList + ")'";
			logger.debug("Query to retrieve the location name array: " + sqlQuery);
			rs = dbConnection.createStatement().executeQuery(sqlQuery);
			// Determine the total number of rows
			rs.last();
			int numRows = rs.getRow();
			rs.beforeFirst();
			// Allocate space for array
			locationNameArray = new String[numRows];
			// Get the value from the ResultSet
			for (int i=0; i<numRows; i++) {
				rs.next();
				char delims[] = {'/', ' '};
				locationNameArray[i] = WordUtils.capitalizeFully(rs.getString("locationName"), delims);
			}
		} catch (Exception e) {
			// handle any errors
			Log.fatal("Encountered an error when attempting to retrieve the names of all requested verification regions", "#errorPanelText");
			logger.fatal("Encountered an error when attempting to retrieve the names of all requested verification regions: " + e);
			throw e;
		}
		return locationNameArray;
	}

	/**
	Returns an array of the lon,lat values of locations to be verified.
    @param settingsObj  Settings object from which to retrieve the settings
	@param dbConnection Database connection to retrieve this information from
	@return  Array of location (lat,lon)
	*/
	public static String[] getLocationLonLatArray(Settings settingsObj, Connection dbConnection) throws Exception {
		// Initialize variables
		String regions     = settingsObj.getRegions();
		String spatialType = settingsObj.getSpatialType();
		String regionType  = settingsObj.getRegionType();
		String refDBName   = settingsObj.getRefDBName();
		ResultSet rs = null;
		String spatialTypeStr = null;
		String regionList = null;
		String[] locationLonLatArray = null;
		// Convert the regions to a comma-separated list of strings,
		// each surrounded by single quotes (eg. 'TX','LA','MS')
		regionList = Sql.regionsToRegex(regions, regionType);

		// Try to execute an SQL query
		try {
			rs = dbConnection.createStatement().executeQuery("SELECT lon,lat FROM " + refDBName + "." + Sql.getRefTableName(spatialType) + " WHERE " + refDBName + "." + Sql.getRefTableName(spatialType) + "." + regionType + " RLIKE '(" + regionList + ")'");
			// Determine the total number of rows
			rs.last();
			int numRows = rs.getRow();
			rs.beforeFirst();
			// Allocate space for array
			locationLonLatArray = new String[numRows];
			// Get the value from the ResultSet
			for (int i=0; i<numRows; i++) {
				rs.next();
				char delims[] = {'/', ' '};
				locationLonLatArray[i] = rs.getString("lon") + "," + rs.getString("lat");
			}
		} catch (Exception e) {
			// handle any errors
			Log.fatal("Encountered an error when attempting to retrieve the lat/lon of all requested verification regions", "#errorPanelText");
			logger.fatal("Encountered an error when attempting to retrieve the lat/lon of all requested verification regions: " + e);
			throw e;
		}
		return locationLonLatArray;
	}
	/**
	Returns an array of the lon values of locations to be verified.
    @param settingsObj  Settings object from which to retrieve the settings
	@param dbConnection Database connection to retrieve this information from
	@return  Array of location (lon)
	*/
	public static String[] getLocationLonArray(Settings settingsObj, Connection dbConnection) throws Exception {
		// Initialize variables
		String regions     = settingsObj.getRegions();
		String spatialType = settingsObj.getSpatialType();
		String regionType  = settingsObj.getRegionType();
		String refDBName   = settingsObj.getRefDBName();
		ResultSet rs = null;
		String spatialTypeStr = null;
		String regionList = null;
		String[] locationLonArray = null;
		// Convert the regions to a comma-separated list of strings,
		// each surrounded by single quotes (eg. 'TX','LA','MS')
		regionList = Sql.regionsToRegex(regions, regionType);

		// Try to execute an SQL query
		try {
			rs = dbConnection.createStatement().executeQuery("SELECT lon FROM " + refDBName + "." + Sql.getRefTableName(spatialType) + " WHERE " + refDBName + "." + Sql.getRefTableName(spatialType) + "." + regionType + " RLIKE '(" + regionList + ")'");
			// Determine the total number of rows
			rs.last();
			int numRows = rs.getRow();
			rs.beforeFirst();
			// Allocate space for array
			locationLonArray = new String[numRows];
			// Get the value from the ResultSet
			for (int i=0; i<numRows; i++) {
				rs.next();
				char delims[] = {'/', ' '};
				locationLonArray[i] = rs.getString("lon");
			}
		} catch (Exception e) {
			// handle any errors
			Log.fatal("Encountered an error when attempting to retrieve the lon of all requested verification regions", "#errorPanelText");
			logger.fatal("Encountered an error when attempting to retrieve the lon of all requested verification regions: " + e);
			throw e;
		}
		return locationLonArray;
	}

	/**
	Returns an array of the lat values of locations to be verified.
    @param settingsObj  Settings object from which to retrieve the settings
	@param dbConnection Database connection to retrieve this information from
	@return  Array of location (lat)
	*/
	public static String[] getLocationLatArray(Settings settingsObj, Connection dbConnection) throws Exception {
		// Initialize variables
		String regions     = settingsObj.getRegions();
		String spatialType = settingsObj.getSpatialType();
		String regionType  = settingsObj.getRegionType();
		String refDBName   = settingsObj.getRefDBName();
		ResultSet rs = null;
		String spatialTypeStr = null;
		String regionList = null;
		String[] locationLatArray = null;
		// Convert the regions to a comma-separated list of strings,
		// each surrounded by single quotes (eg. 'TX','LA','MS')
		regionList = Sql.regionsToRegex(regions, regionType);

		// Try to execute an SQL query
		try {
			rs = dbConnection.createStatement().executeQuery("SELECT lat FROM " + refDBName + "." + Sql.getRefTableName(spatialType) + " WHERE " + refDBName + "." + Sql.getRefTableName(spatialType) + "." + regionType + " RLIKE '(" + regionList + ")'");
			// Determine the total number of rows
			rs.last();
			int numRows = rs.getRow();
			rs.beforeFirst();
			// Allocate space for array
			locationLatArray = new String[numRows];
			// Get the value from the ResultSet
			for (int i=0; i<numRows; i++) {
				rs.next();
				char delims[] = {'/', ' '};
				locationLatArray[i] = rs.getString("lat");
			}
		} catch (Exception e) {
			// handle any errors
			Log.fatal("Encountered an error when attempting to retrieve the lat of all requested verification regions", "#errorPanelText");
			logger.fatal("Encountered an error when attempting to retrieve the lat of all requested verification regions: " + e);
			throw e;
		}
		return locationLatArray;
	}
}
