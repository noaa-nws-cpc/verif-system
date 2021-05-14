package gov.noaa.ncep.cpc.services;

import gov.noaa.ncep.cpc.data.Data;
import gov.noaa.ncep.cpc.driver.VerificationDriver;
import gov.noaa.ncep.cpc.resources.Resources;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Date;

import org.apache.commons.lang.StringEscapeUtils;

import org.apache.log4j.Logger;
import org.ini4j.Wini;

public class VerificationSystemServices
{
  static protected Logger logger = Logger.getLogger(VerificationSystemServices.class.getName());

  //
  //
  // TODO: At some point look into passing in the Settings object, but since we
  //       will be essentially using the VerificationDriver just use the settings
  //       array.
  //
  //
  public Results getResults(String[] settings)
  {
    //
    //
    // TODO: Note!! Double check that we are handling the db
    //       connections correctly.
    //
    //

    Results results = new Results();

    Date date = new Date();
    results.setTimestamp(date.getTime());
    boolean webFlag = true; // Sets flag specifying that run-time is initiated by web services.

    try {
    	// Load the MySQL driver
	    Class.forName("com.mysql.jdbc.Driver");

      Connection dbConnection = null;
      try {
    	  // Load database preferences from a config file
    	  Wini ini = null;
    	  try {
    		  ini = new Wini(Resources.getURL("verif.conf"));
    	  } catch (Exception e) {
    		  logger.fatal("Cannot open configuration file verif.conf. Did you create a verif_server.conf file in the input directory?");
    		  throw(e);
    	  }
    	  // Get DB preferences
    	  String dbHost     = ini.get("mysql","host");
    	  String dbUser     = ini.get("mysql","public_user");
    	  String dbPassword = ini.get("mysql","public_password");
    	  String dateFormat = ini.get("mysql","dateFormat");

    	  // Make connection
          String dbURL = "jdbc:mysql://"+dbHost+"/?user="+dbUser+"&password="+dbPassword+"&characterEncoding=utf8";
    	  logger.info("Connecting to database with URL jdbc:mysql://"+dbHost+"/?user="+dbUser);
    	  dbConnection = DriverManager.getConnection(dbURL);

        Data dataObj = new Data();
        dataObj.setDbConnection(dbConnection);
        dataObj.setSdfSourceFormat(dateFormat);

        VerificationDriver driverObj = new VerificationDriver();
        driverObj.setDbConnection(dbConnection);

        // Sanitize strings in the Settings object to avoid SQL injection
        int i = 0;
        while (i < settings.length) {
            settings[i] = StringEscapeUtils.escapeXml(settings[i]);
            settings[i] = settings[i].replaceAll("[-*\'\"]","");
            i++;
        }

        driverObj.runDriver(settings,webFlag);
        results = driverObj.getResultsObj();

      } catch (Exception e) {
        // handle any errors
        results.setResultType(Results.RESULT_TYPE_ERROR);
        results.setErrorMessage(e.getMessage());
      }
      finally
      {
        try {
          if (dbConnection != null)
          {
            dbConnection.close();
          }
        } catch (SQLException e) {
          // handle any errors
          logger.fatal("SQLException: " + e.getMessage());
          logger.fatal("SQLState: " + e.getSQLState());
          logger.fatal("VendorError: " + e.getErrorCode());
        }
      }
    } catch (Exception e)
    {
      logger.error(e);
      results.setResultType(Results.RESULT_TYPE_ERROR);
      results.setErrorMessage(e.getMessage());
    }


    return results;
  }
}
