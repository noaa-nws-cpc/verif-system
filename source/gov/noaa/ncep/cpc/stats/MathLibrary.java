package gov.noaa.ncep.cpc.stats;

// Import packages needed
import gov.noaa.ncep.cpc.format.FormatLibrary;

import org.apache.log4j.Logger;

/**
Provides general math and statistics functions, including associated information with it. For example,
there are methods to find the min and max of a float array (passed as an argument into the method) that
returns values of min and max values, as well as the associated index(es) in the passed float array
that these values occur.
*/
public class MathLibrary {
	// Initialize variables
	static Logger logger = Logger.getLogger(MathLibrary.class.getName());

	/** 
	Returns a 1-d String array with the maximum and minimum values from a float array and the indexes
	of the array that these maximum and minimum values occur. In cases where there are more than one
	indices where these values occur, a comma separated list of indices is the cell of the returned array.
	
	@param floatArray 1-d array of float values 
	@return String array of information, where the returned indices of the array contain
	the following information:
	[0] - Maximum value found in the float array
	[1] - Index of maximum value in the float array
	[2] - Minimum value found in the float array
	[3] - Index of minimum value in the float array
	*/
	public static String[] getMaxMinValueInfo (float[] floatArray) {

		int numMaxIndices = 0;
		int numMinIndices = 0;

		float maxValue = Float.NaN;
		float minValue = Float.NaN; 
		int goodValue = 0;
		StringBuffer indexMaxStr = new StringBuffer(); // String buffer for list of indices of max value
		StringBuffer indexMinStr = new StringBuffer(); // String buffer for list of indices of min value
		// String array to return with max value and index of max value
		String[] infoArray = new String[4];
		// Loop through array to find max,min values
		for (int i=0; i<floatArray.length; i++) { 
			//logger.trace("Float value is : " + floatArray[i]);
			// If a value encountered is NOT a NaN, check to see
			// if the value is greater or less than a previously temporarily saved one
			if (Float.isNaN(floatArray[i])) {
				//logger.trace("Encountered bad value, skipped");
			}
			else {
				goodValue++;
				// If this is the first good value, set this as the initial value.
				// If not, continue and see if this value is greater or less than the  
				// last saved value
				if (goodValue == 1) {
					maxValue = floatArray[i];
					minValue = floatArray[i];
				}
				else {
					logger.trace("Float value is " + floatArray[i] + " maxValue is " + maxValue);
					// If the current value in the array is greater than the current maxValue,
					// reset the maxValue to the float value of this value
					if (floatArray[i] > maxValue) {
						maxValue = floatArray[i];
					}
					if (floatArray[i] < minValue) {
						minValue = floatArray[i];
					}
				}
			}
		} // End for loop for each column of information
		// Create info arrays
		// If there were NO good values to assess, set the values to return
		// as a message
		if (goodValue < 1) {
			logger.debug("No values to assess. Therefore no values can be the max or min");
			infoArray[0] = "N/A";
			infoArray[1] = "N/A";
			infoArray[2] = "N/A";
			infoArray[3] = "N/A";
			logger.debug("max value = " + infoArray[0]);
			logger.debug("min value = " + infoArray[2]);
		}
		else {
			// Find indices of max/min values
			for (int i=0; i<floatArray.length; i++) { 
				// If this value is the same as the max value, add this index to the
				// list of indices of max value(s)
				if (floatArray[i] == maxValue) {
					logger.trace("Found index " + i + " that has max float value " + floatArray[i]);
					numMaxIndices++;
					if(numMaxIndices == 1) {
						// If this is the first occurence of max value found, do not add comma at the end
						indexMaxStr.append(String.valueOf(i));
					}
					else {
						// If this is not the first occurence of max value found, do  add comma at the end
						indexMaxStr.append(",").append(String.valueOf(i));
					}
				}
				// If this value is the same as the min value, add this index to the
				// list of indices of max value(s)
				if (floatArray[i] == minValue) {
					logger.trace("Found index " + i + " that has min float value " + floatArray[i]);
					numMinIndices++;
					if(numMinIndices == 1) {
						indexMinStr.append(String.valueOf(i));
					}
					else {
						indexMinStr.append(",").append(String.valueOf(i));
					}
				}
			}
			// Convert values to string
			String maxValueStr = String.valueOf(maxValue);
			infoArray[0] = maxValueStr;
			infoArray[1] = indexMaxStr.toString();
			String minValueStr = String.valueOf(minValue);
			infoArray[2] = minValueStr;
			infoArray[3] = indexMinStr.toString();
			logger.trace("max value = " + infoArray[0] + " occurs in score array indice(s) " + infoArray[1]);
			logger.trace("min value = " + infoArray[2] + " occurs in score array indice(s) " + infoArray[3]);
		}
		return infoArray;
	} // End getMaxMinValueInfo

	/**
	Returns a float value of the maximum value found in the passed float array.
	@param floatArray 1-d array of float values
	@return float value of the maximum value found in the passed float array.
	*/
	public static float getMaxValue (float[] floatArray) {
		float maxValue = Float.NaN; 
		int goodValue = 0;
		// Loop through array to find max values
		for (int i=0; i<floatArray.length; i++) { 
			// If a value encountered is NOT a NaN, check to see
			// if the value is greater or less than a previously temporarily saved one
			// If there were NO good values to assess, then maxValue would keep its default value of NaN
			if (Float.isNaN(floatArray[i])) {
				//logger.trace("Encountered bad value, skipped");
			}
			else {
				goodValue++;
				// If this is the first good value, set this as the initial value.
				// If not, continue and see if this value is greater or less than the  
				// last saved value
				if (goodValue == 1) {
					maxValue = floatArray[i];
				}
				else {
					logger.trace("Float value is " + floatArray[i] + " maxValue is " + maxValue);
					// If the current value in the array is greater than the current maxValue,
					// reset the maxValue to the float value of this value
					if (floatArray[i] > maxValue) {
						maxValue = floatArray[i];
					}
				}
			}
		} // End for loop for each column of information
		return maxValue;
	} // End getMaxValue

	/**
	Returns a float value of the minimum value found in the passed float array.
	@param floatArray 1-d array of float values
	@return float value of the minimum value found in the passed float array.
	*/
	public static float getMinValue (float[] floatArray) {
		float minValue = Float.NaN; 
		int goodValue = 0;
		// Loop through array to find min values
		for (int i=0; i<floatArray.length; i++) { 
			// If a value encountered is NOT a NaN, check to see
			// if the value is greater or less than a previously temporarily saved one
			// If there were NO good values to assess, then minValue would keep its default value of NaN
			if (Float.isNaN(floatArray[i])) {
				//logger.trace("Encountered bad value, skipped");
			}
			else {
				goodValue++;
				// If this is the first good value, set this as the initial value.
				// If not, continue and see if this value is greater or less than the  
				// last saved value
				if (goodValue == 1) {
					minValue = floatArray[i];
				}
				else {
					logger.trace("Float value is " + floatArray[i] + " minValue is " + minValue);
					// If the current value in the array is greater than the current minValue,
					// reset the minValue to the float value of this value
					if (floatArray[i] < minValue) {
						minValue = floatArray[i];
					}
				}
			}
		} // End for loop for each column of information
		return minValue;
	} // End getMaxValue

	/**
	Returns a 1-d integer array with the indice(s) where the maximum value occurs in a passed float array.
	Returns a value of '-1' in the returned integer array if no indices were found of a valid max value in 
	the passed float array. This could mean that there were only 'NaN's passed as the float array so no
	indices could be found.
	@param floatArray 1-d array of float values
	@return 1-D integer array of indices where the maximum value occurs in the passed float array.
	*/
	public static int[] getMaxValueIndices (float[] floatArray) {
		float maxValue = Float.NaN; 
		int goodValue = 0;
		int numMaxIndices = 0;
		int[] maxIndicesArray; 
		// Loop through array to find max values
		for (int i=0; i<floatArray.length; i++) { 
			// If a value encountered is NOT a NaN, check to see
			// if the value is greater or less than a previously temporarily saved one
			if (Float.isNaN(floatArray[i])) {
				//logger.trace("Encountered bad value, skipped");
			}
			else {
				goodValue++;
				// If this is the first good value, set this as the initial value.
				// If not, continue and see if this value is greater or less than the  
				// last saved value
				if (goodValue == 1) {
					maxValue = floatArray[i];
				}
				else {
					logger.trace("Float value is " + floatArray[i] + " maxValue is " + maxValue);
					// If the current value in the array is greater than the current maxValue,
					// reset the maxValue to the float value of this value
					if (floatArray[i] > maxValue) {
						maxValue = floatArray[i];
					}
				}
			}
		} // End for loop for each column of information
		// Create info arrays
		// If there were NO good values to assess, set the values to return
		// as a message
		if (goodValue < 1) {
			logger.debug("No values to assess. Therefore no values can be the max");
			maxIndicesArray = new int[1];
			maxIndicesArray[0] = -1; // Set index to -1 if there were no float values found with a valid max value
		}
		else {
			// Find how many times the max occurs to create size of integer array
			for (int i=0; i<floatArray.length; i++) { 
				// If this value is the same as the max value, add this index to the
				// list of indices of max value(s)
				if (floatArray[i] == maxValue) {
					logger.trace("Found index " + i + " that has max float value " + floatArray[i]);
					numMaxIndices++;
				}
			}
			// Declare / initialize integer array of indices
			maxIndicesArray = new int[numMaxIndices];
			// Fill integer array with the found indices
			int j = 0;
			for (int i=0; i<floatArray.length; i++) {
				if (floatArray[i] == maxValue) {		
					maxIndicesArray[j] = i;
					logger.trace("max indices array = " + maxIndicesArray[j]);
					j++; 
				}
			}
		}
		return maxIndicesArray;
	} // End getMaxValueInfo

	/**
	Returns a 1-d integer array with the indice(s) where the minimum value occurs in a passed float array.
	Returns a value of '-1' in the returned integer array if no indices were found of a valid min value in 
	the passed float array. This could mean that there were only 'NaN's passed as the float array so no
	indices could be found.
	@param floatArray 1-d array of float values
	@return 1-D integer array of indices where the minimum value occurs in the passed float array.
	*/
	public static int[] getMinValueIndices (float[] floatArray) {
		float minValue = Float.NaN; 
		int goodValue = 0;
		int numMinIndices = 0;
		int[] minIndicesArray; 
		// Loop through array to find min values
		for (int i=0; i<floatArray.length; i++) { 
			// If a value encountered is NOT a NaN, check to see
			// if the value is greater or less than a previously temporarily saved one
			if (Float.isNaN(floatArray[i])) {
				//logger.trace("Encountered bad value, skipped");
			}
			else {
				goodValue++;
				// If this is the first good value, set this as the initial value.
				// If not, continue and see if this value is greater or less than the  
				// last saved value
				if (goodValue == 1) {
					minValue = floatArray[i];
				}
				else {
					logger.trace("Float value is " + floatArray[i] + " minValue is " + minValue);
					// If the current value in the array is greater than the current minValue,
					// reset the minValue to the float value of this value
					if (floatArray[i] < minValue) {
						minValue = floatArray[i];
					}
				}
			}
		} // End for loop for each column of information
		// Create info arrays
		// If there were NO good values to assess, set the values to return
		// as a message
		if (goodValue < 1) {
			logger.debug("No values to assess. Therefore no values can be the min");
			minIndicesArray = new int[1];
			minIndicesArray[0] = -1; // Set index to -1 if there were no float values found with a valid min value
		}
		else {
			// Find how many times the min occurs to create size of integer array
			for (int i=0; i<floatArray.length; i++) { 
				// If this value is the same as the min value, add this index to the
				// list of indices of min value(s)
				if (floatArray[i] == minValue) {
					logger.debug("Found index " + i + " that has min float value " + floatArray[i]);
					numMinIndices++;
				}
			}
			// Declare / initialize integer array of indices
			minIndicesArray = new int[numMinIndices];
			// Fill integer array with the found indices
			int j = 0;
			for (int i=0; i<floatArray.length; i++) {
				if (floatArray[i] == minValue) {		
					minIndicesArray[j] = i;
					logger.trace("min indices array = " + minIndicesArray[j]);
					j++; 
				}
			}
		}
		return minIndicesArray;
	} // End getMaxValueInfo
	
	/**
	Returns a String array with the average value from a float Array as well as the number of values  
	making up the average.                

	@param floatArray 1-d array of float values
	@return 1-d String array of information, where the returned indices of the array contain
	the following information:
	[0] - Average value found in the float array
	[1] - Number of values making up the average    
	*/
	public static String[] getAveValueInfo (float[] floatArray) {
		logger.trace("getting ave info");
		float aveValue = (float) 0;
		int count = 0;
		// String array to return with ave value and the number of values
		String[] aveInfoArray = new String[2];

		// Loop through array to sum the values
		for (int i=0; i<floatArray.length; i++) {
				//logger.trace("Float value is : " + floatArray[i]);
				// Check for NaNs                
				if (Float.isNaN(floatArray[i])) {
							//logger.trace("Encountered bad value, skipped");
				}
				// Sum values that are NOT NaNs
				else {
					//logger.trace("Encountered good value" + floatArray[i]);
					count++;
					aveValue = aveValue + floatArray[i];
				}
		} // End for loop for each column of information

		// Calculate the average value
		if (count>0) {
			logger.trace("sum of values = " + aveValue);
			logger.trace("# of values = " + count);
			aveValue= aveValue/count;
			// Round the average value to 2 decimal places
			logger.trace("before rounding " + aveValue);
			aveValue=FormatLibrary.roundToDecimal(aveValue,2);
			logger.trace("after rounding " + aveValue);
			// Convert values to string and insert into returned array
			String aveValueStr = String.valueOf(aveValue);
			String countValueStr = String.valueOf(count);
			aveInfoArray[0] = aveValueStr;
			aveInfoArray[1] = countValueStr;
			logger.trace("average value = " + aveValue);
		}
		// If there were NO good values to assess, set the values to return as a message
		else {
			logger.debug("No values to assess. Therefore there can be no average.");     
			aveInfoArray[0] = "N/A";
			aveInfoArray[1] = "N/A";
			logger.debug("average value = " + aveInfoArray[0]);
			logger.debug("# of values = " + aveInfoArray[1]);
		}
		return aveInfoArray;
	} // End getAveValueInfo

	/**
	Returns a float array with the average value from a float Array as well as the number of values
	making up the average for each model and category.
	
	The dimensions are: [model][category][ave value/number of values] where the third dimension
	index 0 is the average value and index 1 is the number of values making up the average.
	
	@param floatArray     3-d float array of float values
	@param minAllowedVal  Minimum value allowed - values less than this will be set to this before averaging
	
	@return 3-d float array of average score information
	*/
	public static float[][][] calcAveValue (float[][][] floatArray, float minAllowedVal) {
		logger.debug("calculating ave value");
		int m = floatArray.length;
		int r = floatArray[0].length;
		int c = floatArray[0][0].length;
		float aveValue;
		int count;
		// Array to return with ave value and the number of values
		float[][][] aveInfoArray = new float[m][4][2];
		// Loop through each model 
		for (int k=0; k<m; k++) {
			// Loop through each category
			for (int j=0; j<r; j++) {
				aveValue = (float) 0;
				count = 0;
				// Loop through each score to sum the values
				for (int i=0; i<c; i++) {
					// Check for NaNs
					if (Float.isNaN(floatArray[k][j][i])) {
						// Don't include this value
					}
					// If the value is less than the minimum allowed value
					else if (floatArray[k][j][i] < minAllowedVal) {
						count++;
						aveValue = aveValue + minAllowedVal;
					}
					// Sum values that are NOT NaNs, and > minAllowedVal
					else {
						count++;
						aveValue = aveValue + floatArray[k][j][i];
					}
				} // End i for loop 
				// Calculate the average value for current category
				if (count>0) {
					aveValue= aveValue/count;
					// Round the average value to 2 decimal places
					logger.trace("average before rounding " + aveValue);
					aveValue=FormatLibrary.roundToDecimal(aveValue,2);
					logger.debug("average value after rounding " + aveValue);
					logger.debug("# of values = " + count);
					// Insert values into returned array
					aveInfoArray[k][j][0] = aveValue;
					aveInfoArray[k][j][1] = count;
				}
				// If there were NO good values to assess, set the values to NaN
				else {
					logger.debug("No values to assess. Therefore there can be no average.");
					aveInfoArray[k][j][0] = Float.NaN;
					aveInfoArray[k][j][1] = Float.NaN;
					logger.debug("average value = " + aveInfoArray[k][j][0]);
					logger.debug("# of values = " + aveInfoArray[k][j][1]);
				}
			} // end j for loop
		} // end k loop
		return aveInfoArray;
	}
	/**
	Returns true if the given float array contains the given float, otherwise false.

	@param array  array of numbers to search through
	@param num    number to search for in the array
	*/
	public static boolean contains(float[] array, float num) {
		boolean containsNumber = false;
		// Loop over all array elements and test for a match
		for (int i=0; i<array.length; i++) {
			if (array[i] == num) {
				containsNumber = true;
			}
		}
		return containsNumber;
	}
	/**
	Returns true if the given int array contains the given int, otherwise false.

	@param array  array of numbers to search through
	@param num    number to search for in the array
	*/
	public static boolean contains(int[] array, int num) {
		boolean containsNumber = false;
		// Loop over all array elements and test for a match
		for (int i=0; i<array.length; i++) {
			if (array[i] == num) {
				containsNumber = true;
			}
		}
		return containsNumber;
	}
} // End MathLibary
