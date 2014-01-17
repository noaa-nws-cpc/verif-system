package gov.noaa.ncep.cpc.format;

/**
Constructs a Google Earth object. This contains the various attributes that a Google Earth object would have, specifically to create KML formatted for Google Earth. Typically lat and lons are together in one string <coordinates> but in the current ability of the dynamic parsing of KML in the verification project, these
are used separately.
*/

public class GoogleEarth {

//---------------------------------------------------------------------------
// Attributes/settings of Chart
// --------------------------------------------------------------------------

//
//---------------------------------------------------------------------------


	//---------------------------------------------------------------------------
	// Declare variables - content types
	//---------------------------------------------------------------------------
	private String[] locationNameArray; // Location name
	private String[] styleArray; // Style URL assigned
	private String[] descriptionArray; // Description 
	private String[] lonArray; // Lon array
	private String[] latArray; // Lat array

/**
Constructor for GoogleEarth formatted object.
<p>
@param locationNameArray String array of location names assigned to each point
@param styleArray String array of icon graphics to use for plotting the location.
@param descriptionArray String array of descriptions, which would be score values for example.
@param lonArray String array of longitude values for each location.
@param latArray String array of latitude values for each location.
*/
	public GoogleEarth(String[] locationNameArray, String[] styleArray, String[] descriptionArray, String[] lonArray, String[] latArray) {
		// Add the passed parameters(attributes) of values to the created chart object
		this.locationNameArray = locationNameArray;
		this.styleArray = styleArray;
		this.descriptionArray = descriptionArray;
		this.lonArray = lonArray;
		this.latArray = latArray;
	}

	//---------------------------------------------------------------------------
	//  Get Methods 
	//
	// Get methods can be used to obtain the values of the attributes of the GoogleEarth object
	//---------------------------------------------------------------------------

	/**
	Get location name array.
	*/
	public String[] getLocationNameArray() {
		return locationNameArray;
	}

	/** 
	Get array of icon styles.
	*/
	public String[] getStyleArray() {
		return styleArray;
	}

	/**
	Get array of description content.
	*/
	public String[] getDescriptionArray() {
		return descriptionArray;
	}

	/** 
	Get array of longitudes.
	*/
	public String[] getLonArray() {
		return lonArray;
	}

	/**
	Get array of latitudes.
	*/
	public String[] getLatArray() {
		return latArray;
	}

	//---------------------------------------------------------------------------
	//  Set Methods 
	//---------------------------------------------------------------------------
	// Set methods can be used if an overloaded method is called by a program
	// that does not pass these attributes or these attributes are changed
	public void setlocationNameArray(String[] locationNameArray) {
		this.locationNameArray = locationNameArray;
	}

	public void setstyleArray(String[] styleArray) {
		this.styleArray = styleArray;
	}

	public void setdescriptionArray(String[] descriptionArray) {
		this.descriptionArray = descriptionArray;
	}

	public void setlonArray(String[] lonArray) {
		this.lonArray = lonArray;
	}

	public void setlatArray(String[] latArray) {
		this.latArray = latArray;
	}

	// toString method to print out values or attributes
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append(" {GoogleEarth Details --");

		return sb.toString();
	}


} // End class GoogleEarth()