package gov.noaa.ncep.cpc.format;

// Import needed packages
import java.util.HashMap;

import org.apache.log4j.Logger;

/**
Contains methods related to mapping values to a String value, ie. a float value to a 
graphic file name. Some of the methods return a String array of these String values
after passing a float array of values to map. 
<p>
<b>To add a new set of mapping rules of $Type, add the following to the code:</b>
<p>Note : In the IconMap.java code, !!! ... !!! exclamations are used to surround
marked instructions explaning what to add.
<p>
<b>In the class declarations above the methods :</b>
<p>
<ul>
<li> hashmap arrays - Currently there are two hash map variables iconTypeArray and thresholdTypeArray that contain
a String value and an associated arrays. iconTypeArray pairs a String value with a String array.
thresholdTypeArray pairs a String value with a float array. These are set by the developer
by pairing a String reference (ie. score type) with arrays the developer adds. This way
the developer only needs to add arrays and set these hash arrays and all the methods
accesses the appropriate arrays during run-time.
<p>
If the developer wants a NEW array type, they will need to set the new hashmap(s). This
will enable a new type of array to be used in formatting. This will require a new
method to be developed since current ones only use iconTypeArray and thresholdTypeArray.
<p>NOTE : The rest of the edits listed assumes you do NOT need to add new types of arrays.
<p><b>For example : </b><p>
private static HashMap<String, $newType> ${new}TypeArray = new HashMap<String, $newType>();
<p>
where $newType is a type of Array, ie. String[], int[]
<p>
<li> Set the threshold array of float[] type for your new type.
<p><b>For example : </b><p>
<b>thresholdArray$Type (ie. thresholdArrayBrierScore)</b>. 
<p>
These are the values that set the ranges used to assign a String value (ie. icon/graphic type).
The size of this should be 1 index greater than the icon graphic array. 
<p>
Different methods treat the ends of this array differently. getIconMapBounded sets the first
and last values as the extreme values allowed to be associated with a valid icon graphic.
Otherwise, values lower than the first value in this array or values higher than the last
value in this array are set to a nullIcon graphic.
<li> Set the icon array of String[] type for your new type to <p>For example : </p>
<b>iconArray$Type (ie. iconArrayBrierScore)</b>.<p>
The size of this array should be 1 index less than the set thresholdArray$Type. The reason for this
is so that the first icon in the icon array represents values between the first and second thresholds
in the set threshold array. Matching the list of icons to range values this way makes the size of
the threshold array 1 index larger than the icon array.
<li> Set the nullIcon. This is typically the graphic associated with non-valid values. This is variable <b>String nullIcon</b>. 
<p><b>For example : </b><p>
<b>private static	 String nullIcon = "null.png";</b>
<p>
</ul>
<p> In the method <b>private static void setIconArrays()</b> :
<p>
<ul>
<li>
Use 'put' commands to pair the String value used
to call mapping methods to the arrays you have set above (thresholdArray$Type and iconArray$Type).
This enables the ability of general variables to be set to specific type arrays.
<p><b>For example : </b><p>
iconTypeArray.put("heidke",iconArrayHeidke);<p>
iconTypeArray is used throughout methods in this class by each method calling this set method 
</ul>
<p> 
In the <b>get methods that perform the mapping of values to icons  </b>
 such as getIconMapBounded() : <p>
<ul>
<li> Call the set method that sets the hash map arrays to the string type :
<p><b>For example : </b><p>
		<b>setIconArrays();</b><p>
</ul>
*/
public class IconMap {
	
	private static Logger logger;

	// Initialize HashMap
	private static	HashMap<String, String[]> iconTypeArray = new HashMap<String, String[]>();
	private static	HashMap<String, float[]> thresholdTypeArray = new HashMap<String, float[]>();
		
	//============== Score Array Settings =============//
	// SET ALL VALUES IN THIS BLOCK FOR A MAP SETTING :

	//----------- Heidke arrays -------------//
	// !!! Set the bounds for ranges of thresholds. !!!
	// For Heidke The size of the threshold array should be one index larger than the set icon array 
	private static	float[] thresholdArrayHeidke = {-50.0f,-20.0f,-10.0f,0.0f,10.0f,20.0f,30.0f,40.0f,50.0f,70.0f,100.0f};
	// For brier size of threshold array and icon array should be same (unbounded extremes) 
// 	private static	float[] thresholdArrayBrier = {-0.8f,-0.6f,-0.4f,-0.2f,0.0f,0.2f,0.4f,0.6f,0.8f,1.0f};
	private static	float[] thresholdArrayBrier = {Float.NEGATIVE_INFINITY,-0.2f,-0.1f,-0.01f,0.01f,0.05f,0.1f,0.2f,0.3f,0.4f,0.5f,1.0f};
	// For RPSS size of threshold array and icon array should be the same (unbounded extrmes)
	private static	float[] thresholdArrayRPSS = {Float.NEGATIVE_INFINITY,-0.2f,-0.1f,-0.01f,0.01f,0.05f,0.1f,0.2f,0.3f,0.4f,0.5f,1.0f};
	// !!! Set the associated icons with ranges set by the thresholdArray. !!!
	// The indices should match those of the values that set the ranges in the thresholdArray. 
	// Different methods in this class deal with the extremes (less than first threshold value,
	// greater than last value) differently but treat values inside the extremes such that
	// an icon is assigned to values GREATER THAN OR EQUAL TO the matching index of the thresholdArray
	// AND LESS THAN the next index value in threshold array
	// For Example : threshold array is set to {5.0f, 10.0f,15.0f}
	// 			 heidke array is set to {image1.png, image2.png}
	// Values GREATER THAN OR EQUAL TO 5.0 and LESS THAN 10.0 will be assigned to image1.png

	// Heidke icons
	private static	String[] iconArrayHeidke= {"./images/dot_darkBlue.png","./images/dot_medBlue.png","./images/dot_medGreen.png","./images/dot_yellow.png","./images/dot_mustard.png","./images/dot_orange.png","./images/dot_brightRed.png","./images/dot_darkRed.png","./images/dot_fuschia.png","./images/dot_purple.png"};
	// Brier icons
	private static	String[] iconArrayBrier= {"./images/dot_darkBlue.png","./images/dot_medBlue.png","./images/dot_medGreen.png","dot_white.png","./images/dot_yellow.png","./images/dot_mustard.png","./images/dot_orange.png","./images/dot_brightRed.png","./images/dot_darkRed.png","./images/dot_fuschia.png","./images/dot_purple.png"};
	// RPSS icons		
	private static	String[] iconArrayRPSS= {"./images/dot_darkBlue.png","./images/dot_medBlue.png","./images/dot_medGreen.png","./images/dot_white.png","./images/dot_yellow.png","./images/dot_mustard.png","./images/dot_orange.png","./images/dot_brightRed.png","./images/dot_darkRed.png","./images/dot_fuschia.png","./images/dot_purple.png"};

	// !!! Set the Null icon !!!
	// This is the String variable icon associated with a value not in the set range 
	// various methods define what is null is assigned to differently
	private static	 String nullIcon = "./images/null.png";
	//----------- End Heidke arrays -----------//

	//=============== End Score Array Settings ===============//

	/**
	Create hash arrays of scoreType to appropriate arrays. Add 'put' commands in here
	as a developer to add the set icon and threshold arrays properly that were
	set in the class specifications.
	**/
	private static void setIconArrays() {

		// Get logger
		logger = Logger.getLogger(IconMap.class.getName());
		
		// !!! Associate the correct icon and threshold arrays !!!!
		// with a String to use for reference, ie. representing a value of scoreType
		// Heidke
		iconTypeArray.put("heidke",iconArrayHeidke);
		thresholdTypeArray.put("heidke",thresholdArrayHeidke);
		// Brier
		iconTypeArray.put("brier",iconArrayBrier);
		thresholdTypeArray.put("brier",thresholdArrayBrier);
		// RPSS
		iconTypeArray.put("rpss",iconArrayRPSS);
		thresholdTypeArray.put("rpss",thresholdArrayRPSS);
	}

	/**
	Get the icon array for a specific scoreType. This is an array of String values representing the names of icons to use that represents score values.
    @param scoreType String value of a valid score type to format for
	*/
	public static String[] getIconArray(String scoreType) {
		logger.debug("In getIconArray");
		// Get logger
		logger = Logger.getLogger(IconMap.class.getName());
		// Get appropriate icon array
		String[] iconArrayUsed = iconTypeArray.get(scoreType);
		return iconArrayUsed;
		
	}
	
	/**
	Get the threshold values array for a specific scoreType. This is an array of String values representing the names of icons to use that represents score values.
    @param scoreType String value of a valid score type to format for
	*/
	public static float[] getLegendThresholdArray(String scoreType) {

		// Get logger
		logger = Logger.getLogger(IconMap.class.getName());
		// Get appropriate icon array
		float[] thresholdArrayUsed = thresholdTypeArray.get(scoreType);
		return thresholdArrayUsed;
		
	}

	/**
	Returns a String array of icons associated with passed float values for a specific score type. In this version of the method bounds ARE set by the min Value and last value in the threshold array. Values less than the min or greater than the last value in the threshold array are set as null Icon. This means that data values beyond these set ranges are considered NULL. Values equal to the first and last values in the set range are considered
	valid values and are included in the range.
	<p>
	Mapping function currently works for :
	<ul>
	<li>heidke skill score, passing "heidke" for scoreType
	</ul>
	<p>
	@param scoreType String value of a valid score type to format for
	@param dataArray Float array of data to map to icons
	*/
	public static String[] getIconMap(String scoreType, float[] dataArray) {
		//array with set icons
// 		String[] dataIconArray = null;

		// Call method to initialize hashmaps
		setIconArrays();
		
		// Initialize dataIconArray - array with set icons. Each index set
		// icon is associated with the matching index of the data point value.
		String[] dataIconArray = new String[dataArray.length];

// 		try {

		//	thresholdTypeArray.put("Heidke",thresholdArray);
			//-------------- End Heidke ------------------//
	// 		// Get logger
			logger = Logger.getLogger(IconMap.class.getName());
	
			//---------- Get appropriate arrays ---------//
			String[] iconArray = iconTypeArray.get(scoreType);
			float[] thresholdArray = thresholdTypeArray.get(scoreType);
			
			logger.debug("Get icon map for score " + scoreType);
			
			// Make sure that the threshold and icon arrays are proper sizes.
			// This means that the icon array should be 1 index smaller than the
			// threshold array.
	
			// If the threshold array is NOT 1 index larger than the icon
			// array then these arrays were not set correctly
			if (thresholdArray.length != iconArray.length + 1) {
				logger.fatal("Threshold array (size " + thresholdArray.length + ") is NOT 1 index size larger than the icon array (" + iconArray.length + "). The threshold array should be 1 index size larger than the icon array. Fix the arrays in /format/IconMap.java arrays properly.");
			}
			// If array sizes correct, continue processing
			else {
				// For each point in the data, populate the dataIconArray
				// with the appropriate associated icon
				logger.trace("data Array length is " + dataArray.length + ", Threshold array length is " + thresholdArray.length);
				for (int i=0; i< dataArray.length; i++) {
					logger.trace("Array index i = " + i);
					logger.trace("dataArray[i] = " + dataArray[i]);
					
					// VALUES EXCEEDING FIRST AND LAST VALUES 
					// If the score is less than the min set value set this to the null icon
	
					if (dataArray[i] < thresholdArray[0]) {
						logger.debug("OUT OF BOUNDS : data value : " + dataArray[i] + " < first threshold");
						dataIconArray[i] = nullIcon;
					}
		
					// If score greater than the last set threshold array value
					else if (dataArray[i] > thresholdArray[thresholdArray.length-1]) {
						dataIconArray[i] = nullIcon;
						logger.debug("OUT OF BOUNDS : data value : " + dataArray[i] + " > last threshold");
					}
		
					// VALUE IS A NAN
					else if (Float.isNaN(dataArray[i])) {
						dataIconArray[i] = nullIcon;
					}
	
		// 			// If score does not exceed extreme values of the range, 
		// 			// check which icon to set depending on the threshold range
					else {
						// For each icon in the array, see which range data is in
						for (int j=0; j < iconArray.length; j++) {
							// If this is the last index, see if value is greater than or equal
							// to the last threshold value AND GREATER THAN OR EQUAL TO the 		
							// current index threshold value 
							// (allows values to be equal to last set value in threshold array)
							if (j == iconArray.length - 1) {
								if (dataArray[i] >= thresholdArray[j] && dataArray[i] <= thresholdArray[j+1]) {
									logger.trace(thresholdArray[j] +  " <= data <= " + thresholdArray[j + 1] );	
									dataIconArray[i] = iconArray[j];
								} // End if data array
							}
		
							// Not last index. Check if data value in this range index
							else {
								// If the score is greater or equal to the last threshold value
								// AND greater than the current index threshold value, assign 
								// the icon of the current index	
								if (dataArray[i] >= thresholdArray[j] && dataArray[i] < thresholdArray[j+1]) {
									logger.trace(thresholdArray[j] + "<= data < " + thresholdArray[j+1]);	
									dataIconArray[i] = iconArray[j];
								} 
								// If the above is not true, continue to next loop of next
								// threshold range to see if the data value is in it.
							} // End else not first loop
							
						} // End for loop of thresholdsArray
					} // End else
				} // For loop for each data
		
				// Print the dataIconArray
				logger.trace("The assigned graphics are  : ");
				for (int k=0; k < dataIconArray.length; k++) {
					logger.trace("!!! DATA : " + dataArray[k] + " ICON : " +dataIconArray[k]);
				}
	
		} // End else 
// 		} // End try
// 		catch (Throwable e) {
// 			logger.warn("Exception thrown, cannot get icon map. Perhaps icon settings not available for this score, or data passed is invalid.");
// 		}
	// Return array of Strings, containing icon information for each value in the passed float array
	return dataIconArray;
			
	} // End method getIconMapBounded

	/**
	Returns a String array of icons associated with passed float values for a specific score type. In this version of the method bounds ARE NOT bounded by the min Value and last value in the threshold array. Values less than the min or greater than the last value in the threshold array are allowed to be past these extremes, except for when the value is a 'NaN'. 'NaN' values are set to null icon. Values less than the first set threshold array value is set to the first icon in the icon array. Values greater than the last set threshold array value is set to the last icon in the icon array.
	<p>
	Mapping function currently works for :
	<ul>
	<li>heidke skill score, passing "heidke" for scoreType
	</ul>
	<p>
	@param scoreType String value of a valid score type to format for
	@param dataArray Float array of data to map to icons
	*/
	public static String[] getIconMapNotBounded(String scoreType, float[] dataArray) {

		// Get logger
		logger = Logger.getLogger(IconMap.class.getName());

		logger.debug("In getIconMapNotBounded");
		// Call method to initialize hashmaps
		setIconArrays();
		
		// Initialize dataIconsArray - array with set icons. Each index set
		// icon is associated with the matching index of the data point value.
		String[] dataIconArray = new String[dataArray.length];
	//	thresholdTypeArray.put("Heidke",thresholdArray);
		//-------------- End Heidke ------------------//


		//---------- Get appropriate arrays ---------//
		String[] iconArray = iconTypeArray.get(scoreType);
		float[] thresholdArray = thresholdTypeArray.get(scoreType);
		
		logger.debug("Get icon map for score " + scoreType);
		
		// Make sure that the threshold and icon arrays are proper sizes.
		// This means that the icon array should be 1 index smaller than the
		// threshold array.

		// If the threshold array is NOT 1 index larger than the icon
		// array then these arrays were not set correctly
		if (thresholdArray.length != iconArray.length) {
			logger.fatal("Threshold array (size " + thresholdArray.length + ") is NOT the same as the icon array (" + iconArray.length + "). Theses must be the same size. Fix the arrays in /format/IconMap.java arrays properly.");
		}
		// If array sizes correct, continue processing
		else {
			// For each point in the data, populate the dataIconArray
			// with the appropriate associated icon
			logger.debug("data Array length is " + dataArray.length);
			logger.debug("Threshold array length is " + thresholdArray.length);
			for (int i=0; i< dataArray.length; i++) {
				
// 				// VALUES EXCEEDING FIRST AND LAST VALUES 
// 				// If the score is less than the min set value set this to the null icon

// 				if (dataArray[i] < thresholdArray[0]) {
// 					logger.debug("OUT OF BOUNDS : data value : " + dataArray[i] + " < first threshold");
// 					dataIconArray[i] = iconArray[0];
// 				}
	
// 				// If score greater than the last set threshold array value
// 				else if (dataArray[i] > thresholdArray[thresholdArray.length-1]) {
// 					dataIconArray[i] = iconArray[iconArray.length - 1];
// 					logger.debug("OUT OF BOUNDS : data value : " + dataArray[i] + " > last threshold");
// 				}
	
				// VALUE IS A NAN
				if (Float.isNaN(dataArray[i])) {
					dataIconArray[i] = nullIcon;
				}

	 			// If score is not a nan check which icon to set depending on the threshold range
				else {
					// For each icon in the array, see which range data is in
					for (int j=0; j < iconArray.length; j++) {
						// If this is the last threshold index, see if value is greater than or equal to the last threshold value assign last icon
						if (j == iconArray.length - 1) {
							if (dataArray[i] >= thresholdArray[j]) {
								logger.trace(thresholdArray[j] +  " <= data ");	
								dataIconArray[i] = iconArray[j];
							} // End if data array
						}
						// If this is first threshold, see if value is equal to or less than the first threshold
						else if (j == 0) {
							if (dataArray[i] < thresholdArray[0]) {
								dataIconArray[i] = iconArray[0];
							}
						}
						// Not last index. Check if data value in this range index
						else {
							// If the score is greater or equal to the last threshold value
							// AND greater than the current index threshold value, assign 
							// the icon of the current index	
							if (dataArray[i] >= thresholdArray[j] && dataArray[i] < thresholdArray[j+1]) {
								logger.trace(thresholdArray[j] + "<= data < " + thresholdArray[j+1]);	
								dataIconArray[i] = iconArray[j];
							} 
							// If the above is not true, continue to next loop of next
							// threshold range to see if the data value is in it.
						} // End else not first loop
						
					} // End for loop of thresholdsArray
				} // End else
				// Print assigned icon
				logger.debug("Data index i = " + i + " | Data value = " + dataArray[i] + " | icon assigned : " + dataIconArray[i] );
			} // For loop for each data
	
			// Print the dataIconArray
			logger.trace("The assigned graphics are  : ");
			for (int k=0; k < dataIconArray.length; k++) {
				logger.debug("!!! DATA : " + dataArray[k] + " ICON : " +dataIconArray[k]);
			}

		} // End else 

	// Return array of Strings, containing icon information for each value in the passed float array
	return dataIconArray;
			
	} // End method getIconMapNotBounded

/**
	Returns a String array of icons associated with passed float values for a specific score type. In this version of the method, values less than the first set threshold float value is allowed to be unbounded (-inf to first threshold value) but cap at the last set threshold value. Values less than the min or greater than the last value in the threshold array are allowed to be past these extremes, except for when the value is a 'NaN'. 'NaN' values are set to null icon. Values less than the first set threshold array value is set to the first icon in the icon array. Values greater than the last set threshold array value is set to the last icon in the icon array.
	<p>
	Mapping function currently works for :
	<ul>
	<li>heidke skill score, passing "heidke" for scoreType
	</ul>
	<p>
	@param scoreType String value of a valid score type to format for
	@param dataArray Float array of data to map to icons
	*/
	public static String[] getIconMapTopBounded(String scoreType, float[] dataArray) {

		// Get logger
		logger = Logger.getLogger(IconMap.class.getName());

		logger.debug("In getIconMapNotBounded");
		// Call method to initialize hashmaps
		setIconArrays();
		
		// Initialize dataIconsArray - array with set icons. Each index set
		// icon is associated with the matching index of the data point value.
		String[] dataIconArray = new String[dataArray.length];
	//	thresholdTypeArray.put("Heidke",thresholdArray);
		//-------------- End Heidke ------------------//


		//---------- Get appropriate arrays ---------//
		String[] iconArray = iconTypeArray.get(scoreType);
		float[] thresholdArray = thresholdTypeArray.get(scoreType);
		
		logger.debug("Get icon map for score " + scoreType);
		
		// Make sure that the threshold and icon arrays are proper sizes.
		// This means that the icon array should be 1 index smaller than the
		// threshold array.

		// If the threshold array is NOT 1 index larger than the icon
		// array then these arrays were not set correctly
		if (thresholdArray.length != iconArray.length) {
			logger.fatal("Threshold array (size " + thresholdArray.length + ") is NOT the same as the icon array (" + iconArray.length + "). Theses must be the same size. Fix the arrays in /format/IconMap.java arrays properly.");
		}
		// If array sizes correct, continue processing
		else {
			// For each point in the data, populate the dataIconArray
			// with the appropriate associated icon
			logger.debug("data Array length is " + dataArray.length);
			logger.debug("Threshold array length is " + thresholdArray.length);
			for (int i=0; i< dataArray.length; i++) {
				
// 				// VALUES EXCEEDING FIRST AND LAST VALUES 
// 				// If the score is less than the min set value set this to the null icon

// 				if (dataArray[i] < thresholdArray[0]) {
// 					logger.debug("OUT OF BOUNDS : data value : " + dataArray[i] + " < first threshold");
// 					dataIconArray[i] = iconArray[0];
// 				}
	
// 				// If score greater than the last set threshold array value
// 				else if (dataArray[i] > thresholdArray[thresholdArray.length-1]) {
// 					dataIconArray[i] = iconArray[iconArray.length - 1];
// 					logger.debug("OUT OF BOUNDS : data value : " + dataArray[i] + " > last threshold");
// 				}
	
				// VALUE IS A NAN
				if (Float.isNaN(dataArray[i])) {
					dataIconArray[i] = nullIcon;
				}

	 			// If score is not a nan check which icon to set depending on the threshold range
				else {
					// For each icon in the array, see which range data is in
					for (int j=0; j < iconArray.length; j++) {
						// If this is the last threshold index, see if value is greater than or equal to the last threshold value assign last icon
						if (j == iconArray.length - 1) {
							if (dataArray[i] >= thresholdArray[j] && dataArray[i] <= thresholdArray[j+1]) {
								logger.trace(thresholdArray[j] +  " <= data ");	
								dataIconArray[i] = iconArray[j];
							} // End if data array
						}
						// If this is first threshold, see if value is equal to or less than the first threshold
						else if (j == 0) {
							if (dataArray[i] < thresholdArray[0]) {
								dataIconArray[i] = iconArray[0];
							}
						}
						// Not last index. Check if data value in this range index
						else {
							// If the score is greater or equal to the last threshold value
							// AND greater than the current index threshold value, assign 
							// the icon of the current index	
							if (dataArray[i] >= thresholdArray[j] && dataArray[i] < thresholdArray[j+1]) {
								logger.trace(thresholdArray[j] + "<= data < " + thresholdArray[j+1]);	
								dataIconArray[i] = iconArray[j];
							} 
							// If the above is not true, continue to next loop of next
							// threshold range to see if the data value is in it.
						} // End else not first loop
						
					} // End for loop of thresholdsArray
				} // End else
				// Print assigned icon
				logger.debug("Data index i = " + i + " | Data value = " + dataArray[i] + " | icon assigned : " + dataIconArray[i] );
			} // For loop for each data
	
			// Print the dataIconArray
			logger.trace("The assigned graphics are  : ");
			for (int k=0; k < dataIconArray.length; k++) {
				logger.debug("!!! DATA : " + dataArray[k] + " ICON : " +dataIconArray[k]);
			}

		} // End else 

	// Return array of Strings, containing icon information for each value in the passed float array
	return dataIconArray;
			
	} // End method getIconMapNotBounded

}
