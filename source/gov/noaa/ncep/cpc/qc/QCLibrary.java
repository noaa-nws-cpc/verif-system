package gov.noaa.ncep.cpc.qc;

// Import required Verification packages
import gov.noaa.ncep.cpc.data.Data;
import gov.noaa.ncep.cpc.format.FormatLibrary;
import gov.noaa.ncep.cpc.settings.Settings;
import gov.noaa.ncep.cpc.settings.SettingsHashLibrary;
import gov.noaa.ncep.cpc.stats.Stats;
import gov.noaa.ncep.cpc.qc.Log;

import gov.noaa.ncep.cpc.resources.Resources;
import org.ini4j.Wini;
import org.apache.commons.cli.ParseException;
import java.util.Arrays;
import org.apache.log4j.Logger;

/**
  Provides methods that do quality control on data or files.
 */
public class QCLibrary {

	private static Logger logger = Logger.getLogger(gov.noaa.ncep.cpc.qc.QCLibrary.class);

	/**
	  Returns a 3-D array of type float with zeros replaced with NaNs.

	  @param f  3-d float array of forecast or observed categories (0-3)

	  @return   3-d float array with zeros replaced with NaNs
	 */
	public static float[][][] removeZeros(float[][][] f) {
		logger = Logger.getLogger(QCLibrary.class.getName());
		logger.debug("Inside removeZeros");

		// Initialize variables
		int m = f.length;                     // Determine size of 1st dimension
		int r = f[0].length;                  // Determine size of 2nd dimension
		int c = f[0][0].length;               // Determine size of 3rd dimension
		float[][][] fQC = new float[m][r][c]; // array with bad values removed

		// If a 0 is found, replace it with NaN.
		// Java ignores NaNs already in input array.
		for (int k=0; k<m; k++) {
			for (int i=0; i<r; i++) {
				for (int j=0; j<c; j++) {
					if (f[k][i][j] == 0) {
						fQC[k][i][j]=Float.NaN;
						//logger.trace("found one zero:" + f[k][i][j]);
						//logger.trace("corrected:" + fQC[k][i][j]);
					}
					else {
						fQC[k][i][j]=f[k][i][j];
					}
				}
			}
		}
		return fQC;
	}  // end removeZeros

    /**
	  Returns a 3-D array of type float with zeros replaced with NaNs for
	  the index specified by the integer value.

      @param f     3-d float array of forecast or observed categories (0-3)
	  @param index index integer of the index for which to do QC

      @return      3-d float array with zeros replaced with NaNs
    */
    public static float[][][] removeZeros(float[][][] f, int index) {
		logger = Logger.getLogger(QCLibrary.class.getName());
		logger.debug("Inside removeZeros");

	    // Initialize variables
	    int m = f.length;                     // Determine size of 1st dimension
	    int r = f[0].length;                  // Determine size of 2nd dimension
	    int c = f[0][0].length;               // Determine size of 3rd dimension
	    float[][][] fQC = new float[m][r][c]; // array with bad values removed
        // If a 0 is found, replace it with NaN.
		// Java ignores NaNs already in input array.
		for (int k=0; k<m; k++) {
			for (int i=0; i<r; i++) {
				for (int j=0; j<c; j++) {
					if (k == index && f[k][i][j] == 0) {
						fQC[k][i][j]=Float.NaN;
						logger.trace("found one:" + f[k][i][j]);
					}
					else {
						fQC[k][i][j]=f[k][i][j];
					}
				}
			}
		}
        return fQC;
    }  // end removeZeros

	/**
	  Returns a 4-D array of type float with probabilities for forecast categories of zero
	  (EC forecasts or erroneous zeros) replaced with NaNs.

	  @param fcstProb  4-d float array of forecast probability
      @param fcstCat   3-d float array of forecast category

	  @return   4-d float array with probs replaced with NaNs for cats of zero
	 */
	public static float[][][][] removeProbsForCatZero(float[][][][] fcstProb, float[][][] fcstCat) {
		logger = Logger.getLogger(QCLibrary.class.getName());
		logger.debug("Inside removeProbsForCatZero");

		// Initialize variables
		int m = fcstProb.length;
		int r = fcstProb[0].length;
		int c = fcstProb[0][0].length;
		int p = fcstProb[0][0][0].length;
		float[][][][] fQC = new float[m][r][c][p];

		// If a 0 for fcstCat is found in the official fcst, change the corresponding probs to NaN.
		// Java ignores NaNs already in input array.
		for (int k=0; k<m; k++) {
			for (int i=0; i<r; i++) {
				for (int j=0; j<c; j++) {
					for (int l=0; l<p; l++) {
						if (fcstCat[k][i][j]==0) {
							fQC[k][i][j][l]=Float.NaN;
						}
						else {
							fQC[k][i][j][l]=fcstProb[k][i][j][l];
						}
					}
				}
			}
		}
		return fQC;
	}  // end removeProbsForCatZero

    /**
	  Returns a 4-D array of type float with probabilities for forecast categories of zero
	  (EC forecasts or erroneous zeros) replaced with NaNs for the index specified by the integer value.

	  @param fcstProb  4-d float array of forecast probability
	  @param fcstCat   3-d float array of forecast category
	  @param index     integer of the index for which to do QC

      @return   4-d float array with probs replaced with NaNs for cats of zero
    */
    public static float[][][][] removeProbsForCatZero(float[][][][] fcstProb, float[][][] fcstCat, int index) {
		logger = Logger.getLogger(QCLibrary.class.getName());
		logger.debug("Inside removeProbsForCatZero");

		// Initialize variables
		int m = fcstProb.length;
		int r = fcstProb[0].length;
		int c = fcstProb[0][0].length;
		int p = fcstProb[0][0][0].length;
		float[][][][] fQC = new float[m][r][c][p];

        // If a 0 for fcstCat is found in the official fcst, change the corresponding probs to NaN.
		// Java ignores NaNs already in input array.
		for (int k=0; k<m; k++) {
			for (int i=0; i<r; i++) {
				for (int j=0; j<c; j++) {
					for (int l=0; l<p; l++) {
						if (k==index && fcstCat[k][i][j]==0) {
							fQC[k][i][j][l]=Float.NaN;
							logger.trace("found one: " + fcstCat[k][i][j]);
						}
						else {
							fQC[k][i][j][l]=fcstProb[k][i][j][l];
						}
					}
				}
			}
		}
        return fQC;
	}  // end removeProbsForCatZero

	/**
	  Returns the number of fcst-ob pairs used for calculating the score
	  excluding NaNs and the percentage of fcst-ob pairs excluding NaNs
	  to total fcst-ob pairs calculated over 1 dimension for each category
	  for score types other than reliability.
	  The percentage is relative to all fcst-obs pairs (including NaNs) for the
	  total category, and for each individual category it is relative to the
	  number of forecasts for that category. For the case where outputDimension is
	  space for ERF, weekends are not counted because forecasts are only made on weekdays.
	  Otherwise it is assumed that there are forecats for each date/location.
	  The dimensions are [category][count or percent] where category is Total,B,N,A.
	  If EC forecasts are passed to this method, they are included for calculating the
	  count and percent for the Total category and ignored for all other categories.
	  For Brier, EC forecasts are removed prior to calling this method.
	  For RPSS, the count and percent for each category are removed in Stats since
	  RPSS by category is not valid. This method will return counts and percentages
	  for the B,N,A categories for RPSS, but they are incorrect since this method
	  only calculates counts and percentages for the forecast category.
	  The 0 index of the last dimension is count and the first index of the
	  last dimension is percent.
	  If no valid pairs are found this method returns zero for both parameters.

	  @param fcstCat  1-d float array of forecast category (0-3), typically data associated with one reference data point
	  @param obsCat   1-d float array of observed category (0-3), typically data associated with one reference data point
	  @param numExpectedFcstsPerScore integer of total expected forecasts that go into calculating each score value
	  @param numEC Number of forecasts that have EC (0.0f) as value associated with the passed forecast array
	  @param ecType Either include equal chances (withEC) or do not include equal chances category forecasts (noEC)
      @return  2-d float array of # of valid fcst-ob pairs and % of valid pairs where the
	  first dimension is Total,B,N,A and the 0th index of the second dimension is count
	  and the 1st index of the second dimension is percent. It should be noted that the "good" count/percent for separate categories are based only on the matching obs since you inherently you do not have an expected number of forecasts in each category separately. Also, the total percent takes does not include EC forecasts as part of the expected # if "noEC" option is used. numEC is set to 0 by default prior to calling this method if "withEC" is selected or if there are no EC values. 
	 */
	public static float[][] countGoodDataPairs(float fcstCat[], float obsCat[], int numExpectedFcstsPerScore, float numEC, String ecType) throws Exception  {
		logger = Logger.getLogger(QCLibrary.class.getName());
		logger.trace("Inside countGoodDataPairs");

		// Initialize variables
		// NaNs are from missing data, weekends with no manual forecast, etc
		int nanCount = 0;      // num of fcst-ob pairs with at least one NaN
		float[] goodDataPercent = new float[4]; // percentage of fcst-ob matches
		//(num of fcst-ob matches that don't have NaNs/total num of fcst-ob pairs)
		float[][] goodDataStats = new float [4][2];
		int r=fcstCat.length;
		int[] Total = new int[4];
		int[] count = new int[4];
		String[] category = SettingsHashLibrary.getCategoryNames();

		// QC for all categories together
		// Determine number of non-NaN fcst-ob pairs
		goodDataPercent[0] = 0;
		for (int i=0; i<r; i++) {
			// Count number of fcst-ob pairs with at least one NaN
			if ( Float.isNaN(fcstCat[i]) || Float.isNaN(obsCat[i]) ) {
				nanCount = nanCount + 1;
			}
		}

		// Get number of fcst-ob pairs that don't contain NaN ("good" or "valid" pairs)
		count[0] = r - nanCount;

		// Calculate the percentage of fcst-ob matches that don't have NaNs
		// If withEC, do not subtract # EC fcsts
		
		if (ecType.compareToIgnoreCase("withEC") == 0) {
			goodDataPercent[0] = 100f * count[0]/numExpectedFcstsPerScore;
			logger.trace("category: " + category[0]);
			logger.trace("good data percent for total categories (100f * # good fcst-obs pairs/# expected pairs : " + goodDataPercent[0] + " = 100.0 * " + count[0] + " / " + numExpectedFcstsPerScore);		
		}
		// else if noEC
		else if (ecType.compareToIgnoreCase("noEC") == 0) {
			goodDataPercent[0] = 100f * count[0]/(numExpectedFcstsPerScore - numEC);
			logger.trace("category: " + category[0]);
			logger.trace("good data percent for total categories (100f * # good fcst-obs pairs/(# expected pairs - # EC fcsts): " + goodDataPercent[0] + " = 100.0 * " + count[0] + " / (" + numExpectedFcstsPerScore + " - " + numEC + ")");
		}
		// else kill - not a valid option
		else {
			logger.fatal("Invalid ecType (Can either be 'withEC' or 'noEC'): " + ecType + " . Killing countGoodDataPairs()");
			Log.fatal("Report invalid 'EC Type'.","#errorPanelText");
			throw new Exception("Invalid ecType (Can either be 'withEC' or 'noEC'): " + ecType + " . Killing countGoodDataPairs()");
		}
		// else assume no EC forecasts to account for


		// Populate QC stats for all cats together in output array
		goodDataStats[0][0] = count[0];
		goodDataStats[0][1] = goodDataPercent[0];

		// QC by category- can only find out if the matching obs is a NaN or not. Cant tell how many fcsts in a category should be expected
		for (int k=1; k<4; k++) { // 1 -below, 2-normal, 3-above
			logger.trace("category: " + category[k]);
			// Initialize counters
			count[k] = 0;
			Total[k] = 0;
			goodDataPercent[k] = 0;
			// Loop over each forecast
			for (int i=0; i<r; i++) {
				// Count number of fcsts for current cat (obs may be NaNs)
				if (fcstCat[i] == k) {
					Total[k] = Total[k] + 1;
					//logger.trace("fcst value is " + fcstCat[i]);
					// Count the number of obs  w/o NaNs for current cat . This means it would be a good fcst-obs pair
					if ( !(Float.isNaN(obsCat[i])) ) {
						count[k] = count[k] + 1;
						//logger.trace("** Good matching obs value counted! **");
					}
					else {
						//logger.trace("Matching Obs Value deemed NOT Good (a NaN)");
					}
				}  // end if to check cat
			}
			if (Total[k] == 0) {
				goodDataPercent[k] = 0;
			}
			else {
				// percent is relative to only total forecasts for the specific category
				goodDataPercent[k] = (float) 100f * count[k]/Total[k];
			}
			logger.trace("good data percent for category: " + k + ": (100f * # valid fcst-obs-percentDry pairs/# total fcsts-obs-percentDry pairs per score): " +  goodDataPercent[k] + " = 100.0 * " + count[k] + " / " + Total[k]);


			// Populate QC stats for each category in indexes 1-3 of output array
			goodDataStats[k][0] = count[k];
			goodDataStats[k][1] = goodDataPercent[k];
		}  // end category loop

		return goodDataStats;
	}  // end countGoodDataPairs

        /**
          Currently returns the same data as countGoodDataPairs(), except this method includes information in the log file about the # of good percent dry
	  points associated with the fcst-obs pairs. There is a separate series of data stored in the climatology database that contains the percent of areas considered dry, which is input to the verification software along with the forecast and observations when this information is needed. Returns the number of matched fcst-obs pairs data used for calculating the score for a specific 
	  time or location that do not have NaN values and the percentage of fcst-ob pairs excluding NaNs
          to total fcst-ob pairs calculated over 1 dimension for each category
          for score types other than reliability.
	  The counts do not account for when the fcst and/or obs are collapsed to a 
	  2 class system.
          The percentage is relative to all fcst-obs pairs (including NaNs) for the
          total category, and for each individual category it is relative to the
          number of forecasts for that category. For the case where outputDimension is
          space for ERF, weekends are not counted because forecasts are only made on weekdays.
          Otherwise it is assumed that there are forecats for each date/location.
          The dimensions are [category][count or percent] where category is Total,B,N,A.
          If EC forecasts are passed to this method, they are included for calculating the
          count and percent for the Total category and ignored for all other categories.
          For Brier, EC forecasts are removed prior to calling this method.
          For RPSS, the count and percent for each category are removed in Stats since
          RPSS by category is not valid. This method will return counts and percentages
          for the B,N,A categories for RPSS, but they are incorrect since this method
          only calculates counts and percentages for the forecast category.
          The 0 index of the last dimension is count and the first index of the
          last dimension is percent.
          If no valid pairs are found this method returns zero for both parameters.

          @param fcstCat  1-d float array of forecast category (0-3) for a certain location or time.
          @param obsCat   1-d float array of observed category (0-3)
          @param percentDry  1-d float array of percentDry 
          @param numExpectedFcstsPerScore integer of total expected forecasts
  	  @param numEC Number of forecasts that have EC (0.0f) as value associated with the passed forecast array
	  @param ecType Either include equal chances (withEC) or do not include equal chances category forecasts (noEC)
      @return  2-d float array of # of valid fcst-ob-percentDry pairs and % of valid pairs where the
          first dimension is Total,B,N,A and the first index of the second dimension is count
          and the second index of the second dimension is percent.
         */
        public static float[][] countGoodDataPairsDryCorrection(float fcstCat[], float obsCat[], float percentDry[], int numExpectedFcstsPerScore, float numEC, String ecType) throws Exception {
                logger = Logger.getLogger(QCLibrary.class.getName());
                logger.trace("Inside countGoodDataPairsDryCorrection");
		
                // Initialize variables
                // NaNs are from missing data, weekends with no manual forecast, etc
                int nanCount = 0;      // num of fcst-ob pairs with at least one NaN
		int nanCountDry = 0; // num % dry data points with a NaN
                float[] goodDataPercent = new float[4]; // percentage of fcst-ob matches
                //(num of fcst-ob matches that don't have NaNs/total num of fcst-ob pairs)
                float[][] goodDataStats = new float [4][2];
                int r=fcstCat.length;
                int[] Total = new int[4];
                int[] count = new int[4]; // good data pairs of fcst-obs
		int[] countDry = new int[4]; // good # dry points 
                String[] category = SettingsHashLibrary.getCategoryNames();
		float[] percentDryData = new float[4];
		
                // QC for all categories together
                // Determine number of non-NaN fcst-ob pairs
                goodDataPercent[0] = 0;
                for (int i=0; i<r; i++) {
			logger.trace("fcst : " + fcstCat[i] + " obs : " + obsCat[i] + " % dry :" + percentDry[i]);
                        // Count number of fcst-ob pairs with at least one NaN
			// Below version commented out because % dry data in database is old and is likely to have less points
			// than the forecast and obs and would therefore lead to reported low quality data and penalize
			// the fcst-obs pairs
                        //if ( Float.isNaN(fcstCat[i]) || Float.isNaN(obsCat[i]) || Float.isNaN(percentDry[i]) ) {
			if ( Float.isNaN(fcstCat[i]) || Float.isNaN(obsCat[i])) {
                                nanCount = nanCount + 1;
				logger.trace("Fcst or obs NaN counted, total = " + nanCount);
                        }
			if ( Float.isNaN(percentDry[i]) ) {
				nanCountDry = nanCountDry + 1;
				logger.trace("% Dry data NaN counted, total = " + nanCountDry);
			}
                }

                // Get number of fcst-ob pairs that don't contain NaN
                //float N = r - nanCount;
		count[0] = r - nanCount;
		
		// Calculate the percentage of fcst-ob matches that don't have NaNs
		// If withEC, do not subtract # EC fcsts
		if (ecType.compareToIgnoreCase("withEC") == 0) {
			goodDataPercent[0] = 100f * count[0]/numExpectedFcstsPerScore;
			logger.trace("category: " + category[0]);
			logger.trace("good data percent for total categories (100f * # good fcst-obs pairs/# expected pairs : " + goodDataPercent[0] + " = 100.0 * " + count[0] + " / " + numExpectedFcstsPerScore);		
		}
		// else if noEC
		else if (ecType.compareToIgnoreCase("noEC") == 0) {
			goodDataPercent[0] = 100f * count[0]/(numExpectedFcstsPerScore - numEC);
			logger.trace("category: " + category[0]);
			logger.trace("good data percent for total categories (100f * # good fcst-obs pairs/(# expected pairs - # EC fcsts): " + goodDataPercent[0] + " = 100.0 * " + count[0] + " / (" + numExpectedFcstsPerScore + " - " + numEC + ")");
		}
		// else kill - not a valid option
		else {
			logger.fatal("Invalid ecType (Can either be 'withEC' or 'noEC'): " + ecType + " . Killing countGoodDataPairs()");
			Log.fatal("Report invalid 'EC Type'.","#errorPanelText");
			throw new Exception("Invalid ecType (Can either be 'withEC' or 'noEC'): " + ecType + " . Killing countGoodDataPairs()");
		}
		
                // Populate QC stats for all cats together in output array
                goodDataStats[0][0] = count[0];
                goodDataStats[0][1] = goodDataPercent[0];
		
		// Assesss dry data points for logging
		// Get # good dry data points, printed at end
		countDry[0] = r- nanCountDry;
		percentDryData[0] = 100f * countDry[0]/(numExpectedFcstsPerScore - numEC);


                // QC by category
                for (int k=1; k<4; k++) {
                        logger.trace("category: " + category[k]);
                        // Initialize counters
                        count[k] = 0;
			countDry[k] = 0;
                        Total[k] = 0;
                        goodDataPercent[k] = 0;
                        // Loop over each forecast
                        for (int i=0; i<r; i++) {
				logger.trace("fcst : " + fcstCat[i] + " obs : " + obsCat[i] + " % dry :" + percentDry[i]);
                                // Count number of fcsts for current cat (obs or percentDry may be NaNs)
                                if (fcstCat[i] == k) {
                                        Total[k] = Total[k] + 1;
                                        // Count the number of ob-percentDry w/o NaNs for current cat
					// Below if commented out because currently expected percent dry will likely be less than fcst-obs
					// pairs and should not penalize
                                        //if ( !(Float.isNaN(obsCat[i])) && !(Float.isNaN(percentDry[i])) ) {
					if ( !(Float.isNaN(obsCat[i])) ) {
                                                count[k] = count[k] + 1;
                                        }
					if ( !(Float.isNaN(percentDry[i])) ) {
						countDry[k] = countDry[k] + 1;
						logger.trace("% Dry data NaN counted, total = " + countDry[0]);
					}
                                }  // end if to check cat
                        }
                        if (Total[k] == 0) {
                                goodDataPercent[k] = 0;
                        }
                        else {
                                // percent is relative to only total forecasts for the specific category
                                goodDataPercent[k] = (float) 100f * count[k]/Total[k];
				percentDryData[k] = (float) 100f * countDry[k]/Total[k];
                        }
                     
			logger.trace("good data percent for category: " + k + ": (100f * # valid fcst-obs-percentDry pairs/# total fcsts-obs-percentDry pairs per score): " +  goodDataPercent[k] + " = 100.0 * " + count[k] + " / " + Total[k]);

                        // Populate QC stats for each category in indexes 1-3 of output array
                        goodDataStats[k][0] = count[k];
                        goodDataStats[k][1] = goodDataPercent[k];
                }  // end category loop

		// Print dry data info
		logger.trace("**** Dry station count info ****");
		logger.trace("good percent dry data for total categories (doesn't impact QC currently)  (100f * # valid dry data points/(numExpectedFcstsPerScore - numEC)): " + 
		percentDryData[0] + " = 100f * " + countDry[0] + " / (" + numExpectedFcstsPerScore + " - " +  numEC + " )"); 
		logger.trace("For below category : " + percentDryData[1] + " = 100f * " + countDry[1] + " / " + Total[1]); 
		logger.trace("For normal category : " + percentDryData[2] + " = 100f * " + countDry[2] + " / " + Total[2]); 
		logger.trace("For above category : " + percentDryData[3] + " = 100f * " + countDry[3] + " / " + Total[3]); 
		logger.trace("******************************");

                return goodDataStats;
        }  // end countGoodDataPairsDryCorrection

	/**
	  Returns the number fcsts per category per bin for reliability scores without EC.
	  Only fcsts as part of a valid forecast-ob pair are counted.
	  EC forecasts should be removed before using this method or the count
	  will be incorrect.
	  Dimensions are [category][bin] where category is Total,B,N,A.
	  If no forecasts are found this method returns a count of 0.

	  @param fcstProb 3-d float array of forecast probability
	  @param obsCat   2-d float array of observed category (0-3)
	  @param probabilityBinLowerThreshold 1-d float array of probability bin lower thresholds
	  @param probabilityBinUpperThreshold 1-d float array of probability bin upper thresholds
	  @param bins integer number of probability bins

	  @return  2-d integer array of # of fcsts per category and bin where the first dimension
	  is Total,B,N,A and the second dimension is for each bin.
	 */
	public static int[][] countGoodDataPairsReliabilityNoEc(float fcstProb[][][], float obsCat[][], float[] probabilityBinLowerThreshold, float[] probabilityBinUpperThreshold, int bins) {
		logger = Logger.getLogger(QCLibrary.class.getName());
		logger.debug("inside countGoodDataPairsReliabilityNoEc");

		// Initialize variables
		int fcstCatTotal;       	// total # of fcsts for a category in a probability range
		int obsCatCount;        	// # of obs that verify in the fcst cat and prob range
		int[][] fcstCountArray = new int[4][bins];
		int fcstCountTotal;
		String[] category = SettingsHashLibrary.getCategoryNames();

		// Loop through each category
		for (int k=0; k<3; k++) {
			// Loop through each bin (probability range bin or 'prob bin')
			logger.trace("category is: " + category[(k+1)]);
			for (int b=0; b<bins; b++) {
				logger.trace("bin is: " + b + " range is " + probabilityBinLowerThreshold[b] + "-" + probabilityBinUpperThreshold[b]);
				// Reset counters
				fcstCatTotal = 0;
				obsCatCount = 0;
				// Loop through each fcstProb
				for (int i=0; i<fcstProb.length; i++) {
					for (int j=0; j<fcstProb[0].length; j++) {
						// If any fcstProb or ob is missing do not count it
						if ( !( Float.isNaN(fcstProb[i][j][0]) || Float.isNaN(fcstProb[i][j][1]) || Float.isNaN(fcstProb[i][j][2]) || Float.isNaN(obsCat[i][j]) )) {
							// Count # of fcsts for each fcstCat and  prob bin
							if (b!=(bins-1)) {  // to skip last bin
								if (fcstProb[i][j][k] >= probabilityBinLowerThreshold[b] && fcstProb[i][j][k] < probabilityBinUpperThreshold[b]) {
									fcstCatTotal = fcstCatTotal + 1;
									// Count # of obs corresponding to the fcst cat and prob bin that verify
									if (obsCat[i][j]==(k+1)) {
										obsCatCount = obsCatCount + 1;
									}
								}
							}
							// For last bin, include the upperThreshold
							else {
								if (fcstProb[i][j][k] >= probabilityBinLowerThreshold[b] && fcstProb[i][j][k] <= probabilityBinUpperThreshold[b]) {
									fcstCatTotal = fcstCatTotal + 1;
									// Count # of obs corresponding to the fcst cat and prob bin that verify
									if (obsCat[i][j]==(k+1)) {
										obsCatCount = obsCatCount + 1;
									}
								}
							}
						} // end if to check for NaNs
					}
				}
				// Populate columns 1 - 3 with counts by category
				fcstCountArray[k+1][b] = fcstCatTotal;
				logger.trace("obsCatCount = " + obsCatCount);
				logger.trace("fcstCatTotal = " + fcstCatTotal);
				logger.trace("count array " + fcstCountArray[k+1][b]);
			}
		}
		// Populate 1st dimension with the count per bin of all cats summed together
		for (int b=0; b<bins; b++) {
			fcstCountTotal = 0;
			// Loop over all cats
			for (int k=1; k<4; k++) {
				fcstCountTotal = fcstCountTotal + fcstCountArray[k][b];
			}
			fcstCountArray[0][b] = fcstCountTotal;
			logger.trace("count total " + fcstCountArray[0][b]);
		}
		return fcstCountArray;
	}  // end countFcstsPerBinNoEc

    /**
      Returns the number fcsts per category per bin for reliability scores including EC.
	  Only fcsts as part of a valid forecast-ob pair are counted.
      EC forecasts are included using this method. See StatsLibrary.calcReliabilityWithEC
	  for how EC is handled.
	  Dimensions are [category][bin] where category is Total,B,N,A.
	  In some cases for forecasts of A and B, the probability of N can be .3333.  These counts
	  are included in the reliability for N for the bin at .3333.
	  In rare occassions, there can be a probability of .3333 for A or B that will be included in
	  the .3333 bin.
      If no forecasts are found this method returns a count of 0.

      @param fcstProb 3-d float array of forecast probability 
      @param fcstCat  2-d float array of forecast category
      @param obsCat   2-d float array of observed category (0-3, for total,B,N,A)
      @param probabilityBinLowerThreshold 1-d float array of probability bin lower thresholds
      @param probabilityBinUpperThreshold 1-d float array of probability bin upper thresholds
      @param bins integer number of probability bins

      @return  2-d integer array of # of fcsts per category and bin where the first dimension
	        is Total,B,N,A and the second dimension is for each probability bin.
     */
    public static int[][] countGoodDataPairsReliabilityWithEc(float fcstProb[][][], float fcstCat[][], float obsCat[][], float[] probabilityBinLowerThreshold, float[] probabilityBinUpperThreshold, int bins) {
        logger = Logger.getLogger(QCLibrary.class.getName());
        logger.debug("inside countGoodDataPairsReliabilityWithEc");

        // Initialize variables
        int fcstCatTotal;           // total # of fcsts for a category in a probability range
        int obsCatCount;            // # of obs that verify in the fcst cat and prob range
		int fcstEcCatTotal = 0; // total # of EC fcsts
		int obsEcCatCount;      // # of obs for EC fcsts for each category
        int[][] fcstCountArray = new int[4][bins];
        int fcstCountTotal;
	String[] category = SettingsHashLibrary.getCategoryNames();

        // Loop through each category
        for (int k=0; k<3; k++) {
            // Loop through each bin (probability range bin or 'prob bin')
            logger.trace("category is: " + category[(k+1)]);
            for (int b=0; b<bins; b++) {
                logger.trace("bin is: " + b + " range is " + probabilityBinLowerThreshold[b] + "-" + probabilityBinUpperThreshold[b]);
                // Reset counters
                fcstCatTotal = 0;
                obsCatCount = 0;
		obsEcCatCount = 0;
		fcstEcCatTotal = 0;
                // Loop through each fcstProb
                for (int i=0; i<fcstProb.length; i++) {
                    for (int j=0; j<fcstProb[0].length; j++) {
                        // If any fcstProb or ob is missing do not count it
                        if ( !( Float.isNaN(fcstProb[i][j][0]) || Float.isNaN(fcstProb[i][j][1]) || Float.isNaN(fcstProb[i][j][2]) || Float.isNaN(obsCat[i][j]) )) {
				if (fcstCat[i][j] != 0) {
                            		// Count # of fcsts for each fcstCat and  prob bin
                            		if (b!=(bins-1)) {  // to skip last bin
                                		if (fcstProb[i][j][k] >= probabilityBinLowerThreshold[b] && fcstProb[i][j][k] < probabilityBinUpperThreshold[b]) {
                                    			fcstCatTotal = fcstCatTotal + 1;
                                    			// Count # of obs corresponding to the fcst cat and prob bin that verify
                                    			if (obsCat[i][j]==(k+1)) {
                                    	    			obsCatCount = obsCatCount + 1;
                                    			}
                                		}
                            		}
                            		// For last bin, include the upperThreshold
                            		else {
                                		if (fcstProb[i][j][k] >= probabilityBinLowerThreshold[b] && fcstProb[i][j][k] <= probabilityBinUpperThreshold[b]) {
                                    		fcstCatTotal = fcstCatTotal + 1;
                                    		// Count # of obs corresponding to the fcst cat and prob bin that verify
                                    			if (obsCat[i][j]==(k+1)) {
                                    	    			obsCatCount = obsCatCount + 1;
                                    			}
                                		}
                            		}
				} // end if for cat != 0
				else if (fcstCat[i][j]==0 && probabilityBinLowerThreshold[b]==.3333f && probabilityBinUpperThreshold[b]==.3334f) {
					fcstEcCatTotal = fcstEcCatTotal + 1;
					if (obsCat[i][j]==(k+1)) {
						obsEcCatCount = obsEcCatCount + 1;
					}
				}
                        } // end if to check for NaNs
                    } // End loop 
                }
                // Populate columns 1 - 3 with counts by category
				// For the EC bin: A sum of EC forecasts and other categories at EC prob value (.3333)
				// For all other bins, the EC counts are zero
                fcstCountArray[k+1][b] = fcstEcCatTotal+fcstCatTotal;
                logger.trace("obsCatCount = " + obsCatCount);
                logger.trace("fcstCatTotal = " + fcstCatTotal);
		logger.trace("obsEcCatCount  = " + obsEcCatCount);
		logger.trace("fcstEcCatTotal  = " + fcstEcCatTotal);
                logger.trace("count array " + fcstCountArray[k+1][b]);
            }
        }
        // Populate 1st dimension with the count per bin of all cats summed together
        for (int b=0; b<bins; b++) {
            fcstCountTotal = 0;
            // Loop over all cats
            for (int k=1; k<4; k++) {
                fcstCountTotal = fcstCountTotal + fcstCountArray[k][b];
            }
            fcstCountArray[0][b] = fcstCountTotal;
        	logger.trace("count total " + fcstCountArray[0][b]);
        }
        return fcstCountArray;
    }  // end countFcstsPerBinWithEc
		
	/**
	  Returns the count and percentage of scores (except reliability) that passed quality control in a 2-D array.
	  Dimensions are [model][count/percent]. The 0th index of the third dimension (count/percent) is count and the 1st index is percent.
	  The percent is the ratio of the number of scores that passed quality control
	  to the total number of possible scores (based on the number of forecasts or locations).
	  For ERF outputDimension of time where the tool is either manual or tool off the manual (_manual), weekends are ignored. This is based on the
	  number of expected scores (ignoring weekends if applicable) passed as the second argument.
	  Otherwise it is assumed that all dates/locations should have a score.
	  For reliability this method does not apply, use getCountGoodDataReliability() instead.
	  @param scoreCatFloatArray 3-d array scoreCatFloatArray
	  @param numExpectedScores 1-d array numExpectedScores Total # of expected scores at the end of processing for each model
	  @return 2-d float array containing the count and percentage of scores (except reliability) that passed quality control for the total category. Dimensions are [model][count/percent]. The separate categories are typically not able to be assessed for number of expected scores (especially hit based scores) so only the total category situation is contained. The 0th index of the third dimension (count/percent) is count and the 1st index is percent.
	*/
	public static float[][][] getCountGoodScores(float scoreCatFloatArray[][][], int numExpectedScores[]) {
		logger = Logger.getLogger(QCLibrary.class.getName());
                logger.trace("Inside getCountGoodScores - only considering for case of total");

		int m = scoreCatFloatArray.length;  // number of models
		int c = scoreCatFloatArray[0].length;  // number of categories 
		int r = scoreCatFloatArray[0][0].length; // number of dates/locations
		float[][][] scoreStats = new float[m][c][2];
		int count;

		// Loop over models
		for (int i=0; i<m; i++) {
			logger.trace("------------ model : " + i + "-------------------");
			// Loop over categories. Commented out section in case separate cats wanted to be 
			// assessed for future use. Not used currently for QC
			// If statement used currently so only total category assessed.. 
			for (int k=0; k<c; k++) {
				count = 0;
				logger.trace("-- category index : " + k + " --"); 
				// Loop over days/locations
				for (int j=0; j<r; j++) {
					logger.trace("- date/location index : " + j + " -");
					// Count scores that are not NaNs
					if (!(Float.isNaN(scoreCatFloatArray[i][k][j]))) {
						count = count + 1;
						//logger.trace("good score value found and counted : " + scoreCatFloatArray[i][k][j]);
					}
					else { // NaN counted
						logger.trace("NaN value found : " + scoreCatFloatArray[i][k][j]);
					}
				}
				// Populate with counts for all categories and models
				scoreStats[i][k][0] = count;
				// Calculate good data percent for total category only. Separate categories not included.
				// (score count/total expected scores over dates/locations/bins)
				if (k==0) {
					scoreStats[i][k][1] = (float) count/numExpectedScores[i];
					logger.debug("For the total category : ");
					logger.debug("# good scores " + count);
					logger.debug("numExpectedScores " + numExpectedScores[i]);
					logger.debug("goodScorePercent " + scoreStats[i][k][1]); 
				}
				// For separate categories the percent is NaN since the number of
	                       // expected forecats is not known (otherwise it is usually 100, based on the number of actual forecasts for that category) 
				else {
					scoreStats[i][k][1] = Float.NaN;
				}
				
			}
			logger.debug("num expected scores for total category: " + numExpectedScores[i] + " for model " + i);
		}
		return scoreStats;
	}

	/**
	  Removes scores below the good data percent quality control threshold specified in this method for scores other
	  than reliability. Quality control is assessed separately for each forecast source. 
	  Score quality control is only assessed by the total category. If a score does not pass qc
	  for the total category then the score for that reference point (time or location) is replaced with NaN for the total category
	  and each individual category. This is because it is not possible to calculate the 
	  percentage of scores by category since the number of expected scores is determined by the forecast and not
	  known ahead of time.
	  Dimensions are [model][category][day/location] (the same as scoreCatFloatArray in Stats).
	  Do not use this method for a score type of reliability or it will return incorrect results.
	  Prints logger info for scores where the number of non NaN fcst-ob pairs (good data) per time/location is too low or
	  the fraction of number of non NaN fcst-ob pairs/total pairs (percentage of good data) per time/location is too low.
	  Prints error message on web tool if all scores for all times/locations are NaNs for any model and selected category.
	  Note weekend forecasts for ERF for outputDimension of space are already ignored in the percentages passed to this method.

	  @param settingsObj  Settings Object
	  @param statsObj     Stats Object
	  @param dataObj      Data Object

	  @return 3-d float array with scores below QC threshold removed
	 */
	public static float[][][] removeScoresWithLowQuality(Settings settingsObj, Stats statsObj, Data dataObj) throws Exception {
		logger = Logger.getLogger(QCLibrary.class.getName());
		logger.debug("Inside removeScoresWithLowQuality");
		String[] referenceStringArray = null;
		if (settingsObj.getScoreType().equals("reliability")) {
			logger.warn("Warning, removeScoresWithLowQuality cannot be used for reliability diagram! QC results may be incorrect. Use method QCLibrary.removeAllScoresIfBelowQCThresholdReliability for reliability score type.");
		}
		float[][][] goodDataPercentArray = statsObj.getGoodDataPercentArray(); // dims is [model][category][day/location] , cat is [total][Below][Normal][Above]
		int[][][] goodDataCountArray = statsObj.getGoodDataCountArray();
		float[][][] scoreCatFloatArray = statsObj.getScoreCatFloatArray();
		int m = goodDataPercentArray.length;	 // num models
		int c = goodDataPercentArray[0].length;  // this is number of categories
		int r = goodDataPercentArray[0][0].length; // num dates/locations
		//String error = null;
		int[][] lowQualityScoreCount = new int[m][4];
		float[][][] qcedScore = statsObj.getScoreCatFloatArray();
 		String[] fcstSourceArray = settingsObj.getFcstSourceArray();
		String[] category = SettingsHashLibrary.getCategoryNames();
                //int missingScoreCount = 0; // used to create pop up window if chart or map contains no scores (is blank)
                referenceStringArray = dataObj.getReferenceArray();
                logger.trace("Ref array in QCLibrary is : " + Arrays.toString(referenceStringArray));

		String dataThresholdStr;  // This is read in from the config file 
		float dataThreshold;   // String threshold value is converted to float 
		
		// Load server configuration file
		Wini ini = null;
		try {
			ini = new Wini(Resources.getURL("verif.conf"));
		} catch (Exception e) {
			logger.fatal("Cannot open configuration file verif_sever.conf(web tool mode) or verif_client.conf(command-line run mode). Make sure there is a verif_sever.conf(web tool mode) or verif_client.conf(command-line run mode) file in the input directory.");
			Log.fatal("Cannot open configuration file.","#errorPanelText");
			throw(e);
		}
		// Try to read the QC threshold set by the server config file
		try {
			dataThresholdStr = ini.get("qc","goodDataThreshold");
		} catch (Exception e) {
			logger.fatal("Could not read threshold value from verif_sever.conf(web tool mode) or verif_client.conf(command-line run mode) file. Please set a variable 'goodDataThreshold' in a section labled '[qc]'.");
			Log.fatal("Could not read QC threshold data value from configuration file.","#errorPanelText");
			throw(e);
		}
		
		// Convert string to float 
		try {
			dataThreshold = Float.parseFloat(dataThresholdStr.trim());
		}
		catch (Exception e) {
			logger.fatal("Could not obtain a QC data threshold properly from the configuration file. Make sure you have set a variable 'goodDataThreshold' in a section labled '[qc]'."); 
			Log.fatal("Could not obtain a QC data threshold properly from the configuration file.","#errorPanelText");
			throw(e);
		}
		
		logger.debug("QC threshold for throwing out scores with insufficient good data is : " + dataThreshold);

		// Check if goodDataPercentArray and goodDataCountArray are the same size
		// Loop over models
		for (int i=0; i<m; i++) {
			// Set counts to zero for all categories
			lowQualityScoreCount[i][0] = 0;
			lowQualityScoreCount[i][1] = 0;
			lowQualityScoreCount[i][2] = 0;
			lowQualityScoreCount[i][3] = 0;
			// Loop over days/locations
			for (int j=0; j<r; j++) {
				// Start with total category
				if ( goodDataPercentArray[i][0][j] < dataThreshold && !(Float.isNaN(scoreCatFloatArray[i][0][j])) ) {
					logger.trace("Warning, score is below qc " + dataThreshold + " % threshold! Model : " + fcstSourceArray[i] + " | category: " + category[0] + " | score : " + scoreCatFloatArray[i][0][j] + " | count : " + goodDataCountArray[i][0][j] + " | percent valid data : " + goodDataPercentArray[i][0][j] + " | location or date : " + referenceStringArray[j]);
					lowQualityScoreCount[i][0] = lowQualityScoreCount[i][0] + 1;
					// Remove the score if it does not pass qc
					qcedScore[i][0][j] = Float.NaN;
					logger.trace("removing the score");
					// Loop over the separate categories
					for (int k=1; k<c; k++) {
						lowQualityScoreCount[i][k] = lowQualityScoreCount[i][k] + 1;
						// Remove scores for each category since total category did not pass qc
						qcedScore[i][k][j] = Float.NaN;
						logger.trace("also removing score for category: " + category[k]);
					}
				}
						//error = "Warning, score has low quality! Model is " + i + ", category is " + category[k] + ", count is " + statsObj.getGoodDataCountArray()[i][k][j] + " , percentage is " + statsObj.getGoodDataPercentArray()[i][k][j] + ", location or date is " + referenceStringArray[j] + ".";
						// Printing this warning is optional
						//Log.warning(error,"#errorPanelText");
				
			} // end j loop
				//logger.trace("Number of locations or days missing scores for model " + i + " category " + k + ": " + count[i][k]);
				//////////// TODO This commented out section is for ticket #1138, creating an alert on the VWT
				// if all scores are NaN for the category selected, including total.
				//////////////////////////
				// Print info about NaN scores to error panel on web tool for only the categories selected
				// Count sets of missing scores
				//if (count[i][k]==r) {
					//logger.warn("All scores for model " + i + " and cat " + k + " are NaNs! There is nothing to plot!");
					//error = "There may be no forecasts for the category selected, or all forecasts or observations are missing for model " + fcstSourceArray[i] + ", category " + category[k] + ", for the dates and locations selected.";
					//String error2 = " Note, manual forecasts for the N category are very rare for monthly and seasonal forecasts.";
					//if (settingsObj.getCategoryType().equals("total") && k==0) {
					//	missingScoreCount = missingScoreCount + 1;
					//	Log.warning(error,"#errorPanelText");
					//}
					//else if (settingsObj.getCategoryType().equals("separate") && (k==1 || k==3)) {
					//	missingScoreCount = missingScoreCount + 1;
					//	Log.warning(error,"#errorPanelText");
					//}
					//else if (settingsObj.getCategoryType().equals("separate") && (k==2)) {
					//	missingScoreCount = missingScoreCount + 1;
					//	if (settingsObj.getFcstType().equals("extendedRange")) {
					//		Log.warning(error,"#errorPanelText");
					//	}
					//	else {
					//		Log.warning(error.concat(error2),"#errorPanelText");
					//	}
					//}
					//else if (settingsObj.getCategoryType().equals("B") && k==1) {
					//	missingScoreCount = missingScoreCount + 1;
					//	Log.warning(error,"#errorPanelText");
					//}
					//else if (settingsObj.getCategoryType().equals("N") && k==2) {
					//	missingScoreCount = missingScoreCount + 1;
					//	Log.warning(error.concat(error2),"#errorPanelText");
					//}
					//else if (settingsObj.getCategoryType().equals("A") && k==3) {
					//	missingScoreCount = missingScoreCount + 1;
					//	Log.warning(error,"#errorPanelText");
					//}
				//}
			logger.debug("number of scores removed: " + lowQualityScoreCount[i][0] + ", for model " + fcstSourceArray[i] + " category " + category[0] + " because good data % is below qc threshold of " + dataThreshold); 
			logger.debug("number of scores removed: " + lowQualityScoreCount[i][1] + ", for model " + fcstSourceArray[i] + " category " + category[1] + " because good data % is below qc threshold of " + dataThreshold); 
			logger.debug("number of scores removed: " + lowQualityScoreCount[i][2] + ", for model " + fcstSourceArray[i] + " category " + category[2] + " because good data % is below qc threshold of " + dataThreshold); 
			logger.debug("number of scores removed: " + lowQualityScoreCount[i][3] + ", for model " + fcstSourceArray[i] + " category " + category[3] + " because good data % is below qc threshold of " + dataThreshold); 
		} // end i loop
		/////////// TODO This is also part of ticket #1138 to print an alert on the VWT if all scores are NaNs for the
		// selected category, including total.
		///////////////////////////////////////////////////
		// Print message on pop up window if there are no scores and chart or map will be blank
		//if (settingsObj.getCategoryType().equals("total") || settingsObj.getCategoryType().equals("B") || settingsObj.getCategoryType().equals("N") || settingsObj.getCategoryType().equals("A")) {
		//	if (missingScoreCount == m) {
		//		error = "No scores can be calculated due to missing or undefined data. See details on warning panel below plot.";
		//		logger.debug("m " + m + "missingscore count " + missingScoreCount);
		//		Log.fatal(error, "#errorPanelText");
		//	}
		//}
		//else if (settingsObj.getCategoryType().equals("separate")) {
		//	 if (missingScoreCount == m*3) {
		//     	error = "No scores can be calculated due to missing or undefined data. See details on warning panel below plot.";
		//		logger.debug("m " + m + " c " + c + "missingscore count " + missingScoreCount);
		//     	Log.fatal(error, "#errorPanelText");
		//     }
		//}
		return qcedScore;
	} // end removeScoresWithLowQuality

        /**
          Removes all scores for total category and separate categories if the percentage of valid scores (not a NaN) is below 
	  good score percentage threshold. Quality control is assessed separately for each forecast source.
	  This can result in a blank plot or an ASCII value with lots of NaN values. This method can be used for all scores
	  including reliability.
	  - you do not know the number of how many fcst-obs pairs are expected for a specific category making up the score value
	  because the score is based on # hits of a specific category which would not be known. Therefore you cannot assess the
	  count of # of good scores that result. Can still use the # of good scores in the total category scores to determine 
	  whether the separate category values should be replaced with 'NaN's. This assessment is purely based on the total cat results.
	  
 	  For RPSS separate cats
	  - DO NOT REMOVE ANY SEPARATE CATEGORIES. This level of QC-ing does not exist in this situation.
	   
	  Note, the static spatial plots do total category qc independently. They are set up
	  to not create any plots if the number of scores is too low by reading the percent
	  of good scores printed in the ascii file heading.
          For ERF outputDimension of time, weekends are ignored. This is already taken into
	  account with values in goodScorePercentArray passed as the second argument.
          Otherwise it is assumed that all dates/locations should have a score.
          @param scoreCatFloatArray 3-d array Score values by category (scoreCatFloatArray). Dimensions are [model][category][day/location]
          @param goodScorePercentArray 2-d array Percent of good scores in an array (goodScorePercentArray).Dimensions are [model][category] 
	  @param scoreType Score type. This is needed to determine whether separate categories get replaced with 'NaN' values. RPSS would not get values replaced with 'NaN' in separate category. 
          @return 3-d float array of scores containing NaNs if replaced by this QC method.
        */
        public static float[][][] removeAllScoresIfBelowQCThreshold (float scoreCatFloatArray[][][], float goodScorePercentArray[][],String scoreType) throws Exception  {
                logger = Logger.getLogger(QCLibrary.class.getName());
                logger.trace("Inside removeAllScoresIfBelowQCThreshold");

                int m = scoreCatFloatArray.length;  // number of models in score array
                int r = scoreCatFloatArray[0][0].length; // number of dates/locations
		int numPercentModels = goodScorePercentArray.length; // number of models in goodScorePercentArray
                float[][][] qcedScore = scoreCatFloatArray;;
		String scoreThresholdStr;  // Threshold is read in from config file
		float scoreThreshold;
		
		// Load server configuration file
		Wini ini = null;
		try {
			ini = new Wini(Resources.getURL("verif.conf"));
		} catch (Exception e) {
			logger.fatal("Could not open configuration file verif_sever.conf(web tool mode) or verif_client.conf(command-line run mode). Make sure there is a verif_server.conf file in the input directory.");
			Log.fatal("Could not open server configuration file.","#errorPanelText");
			throw(e);
		}
		// Try to read the QC threshold set by the server config file
		try {
			// if reliability read reliability threshold 
			if (scoreType.equals("reliability")) {
				scoreThresholdStr = ini.get("qc","goodScoreThresholdReliability");
			}
			else {
				scoreThresholdStr = ini.get("qc","goodScoreThreshold");
			}
		} catch (Exception e) {
			logger.fatal("Could not read threshold value from verif_sever.conf(web tool mode) or verif_client.conf(command-line run mode) file. Please set a variable 'goodScoreThreshold' in a section labled '[qc]'.");
			Log.fatal("Could not open server configuration file.","#errorPanelText");
			throw(e);
		}
		
		// Convert string to float 
		try {
			scoreThreshold = Float.parseFloat(scoreThresholdStr.trim());
		}
		catch (Exception e) {
			logger.fatal("Could not obtain a QC number valid scores threshold properly from the configuration file. Make sure you have set a variable 'goodScoreThreshold' in a section labled '[qc]'."); 
			Log.fatal("Could not obtain a QC number valid scores threshold properly from the configuration file.","#errorPanelText");
			throw(e);
		}
		
		logger.debug("QC threshold for throwing out all scores if insufficient good scores is : " + scoreThreshold);
		
		for (int i=0;i<numPercentModels; i++){
			logger.debug("The % good scores for categories total (individual cats should be NaN): " + goodScorePercentArray[i][0] + " B : "  + goodScorePercentArray[i][1] + " N : "  + goodScorePercentArray[i][2] + " A : "  + goodScorePercentArray[i][3]);
		}	
		
		//---------------------------------------------------------
		// PERFORM QC2 - Removing scores if the score threshold is not satisfied
		//---------------------------------------------------------
		// NEED TO ONLY ASSESS THE TOTAL CATEGORY - in scores that utilize # hits (heidke, brier) you do not know
		// the counts of how many fcst-obs pairs make up a specific category when the score is calculated
		// For RPSS separate cats, DO NOT REMOVE ANY SEPARATE CATEGORIES			
                // Loop over models
                for (int k=0; k<m; k++) {
			// Check total category percentage for current model
			logger.debug("Model " + k + ", total category, " + "goodScorePercent " + goodScorePercentArray[k][0]);
			
			if (goodScorePercentArray[k][0] < scoreThreshold) {
				// Loop over days/locations and remove score for total category
				// Scores for separate categories are also removed if the total category is
				logger.info("Scores for entire plot did not pass qc percent threshold of " + scoreThreshold + " % ! Removing all scores for total category, model " + k);
				
				// Replace total category values with 'NaN'
				for (int j=0; j<r; j++) {
					qcedScore[k][0][j] = Float.NaN;

				}
				// If it is not RPSS, also replace separate category values with 'NaN'
				if (!(scoreType.equals("rpss"))) {
					logger.info("Also removing scores for each individual category since total category did not pass qc");
					for (int j=0; j<r; j++) {
						qcedScore[k][1][j] = Float.NaN;
						qcedScore[k][2][j] = Float.NaN;
						qcedScore[k][3][j] = Float.NaN;
					}
				}
			}
                }
                return qcedScore;
        }

	/**
	  Returns a boolean value of whether passed 1-d String arrays all have the same
	  sizes. Any number of 1-d String arrays may be passed to this method.

	  @param stringArray one or more String type arrays.
	 */
	public static boolean isSameSize(String[] ... stringArray) {
		// By default set boolean of arrays being same size equal to true
		boolean isArraysSameSize = true;

		int arraySize = 0; // Set default array size to 0
		// For each array in the passed String arrays check to see if
		// the size of the current array in the loop differs
		// from the previous array in the loop
		int i = 0;
		// If there is only 1 array, return true. No other
		// array lengths to check for matching size
		if ((stringArray.length) == 1) {
			logger.warn("Only one array submitted. value returned for checking for same size arrays is set to true by default.");
			isArraysSameSize = true;
		}
		else { // More than one array so can compare sizes of them
			logger.trace("Length is " + stringArray.length);
			for (String[] s : stringArray) {
				// If it is the first array evaluated, get the length of it
				if (i == 0) {
					arraySize = s.length;
					logger.trace("Length of first array : " + arraySize);
				}
				// If it is not the first array, see if this length matches arraySize
				else {
					// If the length of the array in this loop is not the length
					// of the previous array, return false.
					if (s.length != arraySize) {
						logger.trace("Length of arrays NOT the same. There is are array sizes " + s.length + " and " + arraySize);
						isArraysSameSize = false;
					}
					// if the length of the array in this loop IS the same length
					// as the previous array, continue the loop.
				} // End else
				i++;
			}  // End loop
		} // End else
		// Return boolean value
		return isArraysSameSize;
	} // End method isSameSize(String[] ... stringArray)

	/**
	Returns 1-d integer array of lengths of one or multiple 1-D String arrays passed to this method. Each index contains
	the corresponding length of the array of the index of the array passed to this
	method.
	<p>
	ie. you call this method and pass 3 String arrays :
	QCLibrary.getSizeArrays(array1, array2 , array 3);
	where array1, array2, and array3 are all 1-D arrays of type String.
	<p>
	This will result in a 1-D integer array with lengths of these arrays,
	corresponding to the order of the arrays submitted.
	<p>
	Result : [array1.length | array2.length | array3.length]
	<p>
	@param stringArray one or more String type arrays.
	@return integer array of sizes of passed arrays. Indices of values correspond with the array order.
	 */
	public static int[] getSizeArrays(String[] ... stringArray) {
		int i = 0;
		int[] sizeArrays = new int[stringArray.length];
		logger.debug("Number of String arrays submitted : " + stringArray.length);
		// Get array lengths, put into an array
		for (String[] s : stringArray) {
			sizeArrays[i] = s.length;
			i++;
		}  // End loop
		return sizeArrays;
	} // End getSizeArrays()

} // end QCLibrary class


