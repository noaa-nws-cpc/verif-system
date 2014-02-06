package gov.noaa.ncep.cpc.services;

import gov.noaa.ncep.cpc.stats.Stats;

/*
 * This class is meant to encapsulate all the data needed by the verification system
 * tools applets when presenting the results to the user.
 */
public class Results
{
  public static int RESULT_TYPE_SUCCESS = 1;
  public static int RESULT_TYPE_ERROR = 2;

  private int resultType;
  private String errorMessage;
  private String[] warningMessages = {};
  private long timestamp;

  //
  //
  // TODO: double check that there is not more data needed to send accross
  //
  //
  private String[] referenceArray;
  private int   numUniqueFcstDates;
  private String[] formattedReferenceDatesArray;
  private String[] locationNameArray;
  private String[] locationLonArray;
  private String[] locationLatArray;
  private String[] fcstDateValidBounds;
  private Stats stats;

  public int getResultType()
  {
    return resultType;
  }
  public void setResultType(int resultType)
  {
    this.resultType = resultType;
  }
  public String getErrorMessage()
  {
    return errorMessage;
  }
  public void setErrorMessage(String errorMessage)
  {
    this.errorMessage = errorMessage;
  }
  public String[] getWarningMessages()
  {
    return warningMessages;
  }
  public void setWarningMessages(String[] warningMessages)
  {
    this.warningMessages = warningMessages;
  }
  public long getTimestamp()
  {
    return timestamp;
  }
  public void setTimestamp(long timestamp)
  {
    this.timestamp = timestamp;
  }
  public String[] getReferenceArray()
  {
    return referenceArray;
  }
  public void setReferenceArray(String[] referenceArray)
  {
    this.referenceArray = referenceArray;
  }
  public int getNumUniqueFcstDates()
  {
    return numUniqueFcstDates;
  }
  public void setNumUniqueFcstDates(int numUniqueFcstDates)
  {
    this.numUniqueFcstDates = numUniqueFcstDates;
  }
  public String[] getFormattedReferenceDatesArray()
  {
    return formattedReferenceDatesArray;
  }
  public void setFormattedReferenceDatesArray(String[] formattedReferenceDatesArray)
  {
    this.formattedReferenceDatesArray = formattedReferenceDatesArray;
  }
  public String[] getLocationNameArray()
  {
    return locationNameArray;
  }
  public void setLocationNameArray(String[] locationNameArray)
  {
    this.locationNameArray = locationNameArray;
  }
  public String[] getLocationLonArray()
  {
    return locationLonArray;
  }
  public void setLocationLonArray(String[] locationLonArray)
  {
    this.locationLonArray = locationLonArray;
  }
  public String[] getLocationLatArray()
  {
    return locationLatArray;
  }
  public void setLocationLatArray(String[] locationLatArray)
  {
    this.locationLatArray = locationLatArray;
  }
  public String[] getFcstDateValidBounds()
  {
    return fcstDateValidBounds;
  }
  public void setFcstDateValidBounds(String[] fcstDateValidBounds)
  {
    this.fcstDateValidBounds = fcstDateValidBounds;
  }
  public Stats getStats()
  {
    return stats;
  }
  public void setStats(Stats stats)
  {
    this.stats = stats;
  }

}
