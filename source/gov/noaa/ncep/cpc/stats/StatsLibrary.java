package gov.noaa.ncep.cpc.stats;

// Import packages
import gov.noaa.ncep.cpc.qc.QCLibrary;
import gov.noaa.ncep.cpc.settings.SettingsHashLibrary;

import java.util.Arrays;

import org.apache.log4j.Logger;
 
/**
 * Provides methods that calculate different types of scores
 */
public class StatsLibrary {

	static protected Logger logger; // Initialize logger

	/**                                               
	 * Returns heidke score of non EC forecasts calculated over 1 dimension for
	 * both the total and separate categories in the order total,B,N,A.  
	 * EC forecasts (zeros) should be removed from all models before use or
	 * the score will be incorrect.
	 * See calcHeidkeWithEc to verify using EC forecasts.
	 * This method ignores NaNs, and if no fcst-ob pairs are found it returns NaN.
	 * HeidkeNoEC=(numCorrect - numExpected)/(count - numExpected) 
	 * where numExpected for a category is calculated by count * probability of the forecast being in a specific category, and count is the number of valid fcst-ob pairs.
	 * The Heidke score utilizes the number of correct and incorrect category hits.
	 * The values for heidke scores range from -50 to 100 for even terciles. A score of 100 indicates a perfect
	 * forecast, and a score of -50 indicates a perfectly incorrect forecast. This would be different for percentiles that are not even in the terciles (extremes). The minimum HSS would be -p/(1-p), where p is the probability of climatology forecasting the percentile (e.g. 0.15 for the 15th and 85th percentiles). The maximum would always be 1. Scores greater than 0 indicate improvement compared to a random forecast and indicate skill.
	 *
	 * @param fcstCat  1-d float array of forecast categories
	 * @param obsCat   1-d float array of observed categories
     * @param variable String of the variable. Potentially used to extract thresholds associated with forecast categories.
	 *
	 * @return	1-d float array of score calculated over 1 dimension for Total,B,N,A
	 */
	public static float[] calcHeidkeNoEc(float fcstCat[], float obsCat[], String variable) throws Exception {
		logger = Logger.getLogger(StatsLibrary.class.getName());
		logger.trace("In calcHeidkeNoEc calculating heidke non EC 1-d");

		// Initialize variables for this score
		// NaNs are from missing data, weekends with no manual forecast, etc
		int numCats = 3;      		     // Number of forecast categories (a,b,n)
		int[] numCorrect = new int[4];         // num correct forecasts
		float[] numExpected = new float[4];  // num of random fcsts expected to be correct
		float[] heidke = new float[4];	     // value returned, Heidke score, can contain NaNs
        float[]tempHeidke = new float[4]; // Temp heidke array, containing 0s instead of NaNs (to enable averaging for total cats)
		int nanCount; 		             // num of fcst-ob pairs with at least one NaN  
		int[] count = new int[4];            // total number of valid fcst-ob pairs
		int r=fcstCat.length;   
		int[] Total = new int[4];	     // total number of fcsts
        float[] expectedProbability = new float[3]; // Probability associated with each category (for noneven terciles)
		String[] category = SettingsHashLibrary.getCategoryNames();
        // See if an extreme is being processed
        boolean isEvenTerciles = SettingsHashLibrary.isEvenTerciles(variable);

        // For non even terciles get the expected probability associated with each category
        if (isEvenTerciles == false) {
            try {
                String[] categoryThresholds = SettingsHashLibrary.getCategoryThresholds(variable);
                expectedProbability[0] = Float.valueOf(categoryThresholds[0])/100;
                expectedProbability[1] = (Float.valueOf(categoryThresholds[1])-Float.valueOf(categoryThresholds[0]))/100;
                expectedProbability[2] = 1-(Float.valueOf(categoryThresholds[1])/100);
                logger.trace("Category thresholds for non-even terciles : " + categoryThresholds[0] + " and " + categoryThresholds[1]);
                logger.trace("Expected probs for each category : " + expectedProbability[0] + " , " + expectedProbability[1] + " , " + expectedProbability[2]);
            } catch(Exception e) {
                throw e;
            }
        }

		// Calculate heidke by category
		for (int k=1; k<(numCats+1); k++) {
			logger.trace("category: " + category[k]);
			// Initialize counters
			numCorrect[k] = 0;
			count[k] = 0;
			Total[k] = 0;
			// Loop over each forecast 
			for (int i=0; i<r; i++) {
				// Determine various category pieces of information for Heidke
				if (fcstCat[i] == (k)) {  
					// Count total fcsts for current category (obs may be NaN)
					Total[k] = Total[k] + 1;
					// Count number of correct fcsts
					if (fcstCat[i] == obsCat[i]) {
						numCorrect[k]=numCorrect[k]+1;
					}
					// Count the number of fcst-ob pairs without any NaNs for each category
					if ( !(Float.isNaN(fcstCat[i])) && !(Float.isNaN(obsCat[i])) ) {
						count[k] = count[k] + 1;
					}
				} // end if to check cat
			}

            // For non even terciles get the num expected for each category    
            if (isEvenTerciles == false) {

                logger.trace("Calculating num expected for non even tercile for category : " + k);
                if (k == 1) {
                    numExpected[k] = (float) count[k] * expectedProbability[0];
                }
                if (k == 2) {
                    numExpected[k] = (float) count[k] * expectedProbability[1];
                }
                if (k == 3) {
                    numExpected[k] = (float) count[k] * expectedProbability[2];
                }
            }
            // Else assume even terciles
            else {
                // The numExpected is count * window size in probability (ie. including cases for extremes, where
			    numExpected[k] = (float) count[k]/numCats;    // Number of random fcsts expected to be correct
            }   


			// Calculate score if there is at least one fcst-ob pair
			if (count[k] > 0) {
				heidke[k] = 100 * ((numCorrect[k]-numExpected[k]) / (count[k]-numExpected[k]));
                tempHeidke[k] = heidke[k];               
                logger.trace("HSS for category " + k + " : " + heidke[k] + " = 100 * ((" + numCorrect[k] + " - " + numExpected[k] + ") / (" + count[k] + " - " + numExpected[k] + "))");
			}
			// If there are not fcst-obs pairs, score is undefined
			else {
				heidke[k] = Float.NaN;
                tempHeidke[k] = 0;
			}
		} // End calculate HSS by category

        // Get total count of forecast-obs pairs
        count[0] = count[1] + count[2] + count[3];
        logger.trace("# Forecast points for each category is " + count[1] + " , " + count[2] + " , " + count[3] + " | total points : " + count[0]);

        // Calculate total cats HSS for non-even terciles (e.g. extremes)
        // This only includes the lower and upper categories
        if (isEvenTerciles == false) {
            logger.debug("Calculating the total cats HSS for 2 categories (lower and upper) for non-even terciles.");
            // Calculate score if there is at least one valid fcst-ob pair in the lower OR upper category
            if ((count[1] > 0) || (count[3] > 0)) { 
	            heidke[0] = (tempHeidke[1]*count[1] + tempHeidke[3]*count[3])/(count[1] + count[3]);
                logger.trace("HSS for total cats (only including lower and upper cats) : " + heidke[0] + " = (" + tempHeidke[1] + " * " + count[1] + " + " + tempHeidke[3] + " * " + count[3] + ")/(" + count[1] + " + " + count[3] + ")");
            }
            // If there are not fcst-obs pairs, score is undefined
            else {
                logger.warn("Total categories HSS not calculated because there are no non-NaN forecasts in either the lower or upper category.");
	            heidke[0] = Float.NaN;
            }      
        }
        // Calculate total cats HSS for even terciles - includes all 3 cats
        else {
            logger.debug("Calculating the total cats HSS for 3 even tercile categories.");
            // Calculate score if there is at least one valid fcst-ob pair in the lower OR upper category
            if ((count[1] > 0) || (count[2] > 0) || (count[3] > 0)) { 
	            heidke[0] = (tempHeidke[1]*count[1] + tempHeidke[2]*count[2] + tempHeidke[3]*count[3])/(count[1] + count[2] + count[3]);
                logger.trace("HSS for total cats (all 3 cats) : " + heidke[0] + " = (" + tempHeidke[1] + " * " + count[1] + " + " + tempHeidke[2] + " * " + count[2] + " + " + tempHeidke[3] + " * " + count[3] + ")/(" + count[1] + " + " + count[2] + " + " + count[3] + ")");
            }
            // If there are not fcst-obs pairs, score is undefined
            else {
                logger.warn("Total categories HSS not calculated because there are no non-NaN forecasts in any category.");
	            heidke[0] = Float.NaN;
            }      
        }
	    logger.trace("heidke for all cats = " + heidke[0]);
		return heidke;
	}  // end calcHeidkeNoEc 1-D


	/////////////////////////////////////////////////////////////

        /**
         * Returns heidke score of non EC forecasts calculated over 1 dimension for
         * both the total and separate categories in the order total,B,N,A using
	 * a dry location correction.
         * EC forecasts (zeros) should be removed from all models before use or
         * the score will be incorrect.
         * This method ignores NaNs, and if no fcst-ob pairs are found it returns NaN.
	 * No score is calculated if there is no climatology for that location.
         * The number of categories to verify is set to 3.
         * HeidkeNoEC=(numCorrect - numExpected)/(count - numExpected)
         * where count is the number of valid fcst-ob pairs, and numExpected is the
	 * the number of expected correct forecasts which depends on dry location correction
	 * parameters.
	 * In short the dry location correction modifies the number of expected correct
	 * forecasts based on whether the location is arid, semi-arid, or normal (determined
	 * from the percentage of dry averaging periods for that location and averaging period).
	 * It then collapses to a 2 class system (A or B) for arid and semi-arid locations. To
	 * collapse to a 2 class system, forecasts and obs of N are changed to B for arid and
	 * semi-arid stations. For stations, the percentage dry is based on stations with zero
	 * period over the averaging period. For grids, the percentage dry is based on grids
	 * with less than 1 mm of precip because it is very rare to get a completely dry grid
	 * due to spatial interpolation. See verification ticket #1278 for gridded dry climo info.
	 * The dry correction methodology is detailed in the following trac page:
	 * https://cpc-devtools/trac/projects/Verif_System/wiki/CodingTeam/DryLocationCorrection
         * The Heidke score utilizes the number of correct and incorrect category hits.
		 * The possible range of precipitation Heidke Skill Scores using the dry station
		 * methodology described above theoretically ranges from negative infinity to 100. 
		 *
		 * Note that scores less than -100 are rarely experienced.
         *
         * @param fcstCat  1-d float array of forecast categories
         * @param obsCat   1-d float array of observed categories
         * @param percentDry  1-d float array of percentage of aveWindows (5day or 7day periods) with no precip 
         *
         * @return      1-d float array of score calculated over 1 dimension for Total,B,N,A
         */
        public static float[] calcHeidkeNoEcDryLocationCorrection(float fcstCat[], float obsCat[], float percentDry[]) {
            logger = Logger.getLogger(StatsLibrary.class.getName());
            logger.trace("In calcHeidkeNoEcDryLocationCorrection calculating heidke non EC dry area correction 1-d");
            // Initialize variables for this score
            // NaNs are from missing data, weekends with no manual forecast, etc
            int numCats = 3;                     // Number of forecast categories (a,b,n)
            int[] numCorrect = new int[4];       // num correct forecasts
            float[] numExpected = new float[4];  // num of random fcsts expected to be correct
            float[] expected = new float[fcstCat.length];  // expected value depending on a specific location and fcstCat 
            float[] heidke = new float[4];       // value returned
            int nanCount;                        // num of fcst-ob pairs with at least one NaN
            int[] count = new int[4];            // total number of valid fcst-ob pairs
            int r=fcstCat.length;
            int[] Total = new int[4];            // total number of fcsts
            String[] category = SettingsHashLibrary.getCategoryNames();
		    int percentDryCount;
		    int arid2classFcstCount;
		    int arid2classObsCount;
		    int semiArid2classFcstCount;
		    int semiArid2classObsCount;

            // Dry location correction
		    logger.trace("doing dry location correction");
            for (int k=1; k<(numCats+1); k++) {
                logger.trace("category: " + category[k]);
                // Initialize counters
			    percentDryCount = 0;
			    arid2classFcstCount = 0;
			    arid2classObsCount = 0;
			    semiArid2classFcstCount = 0;
			    semiArid2classObsCount = 0;
                        // Loop over each forecast
                        for (int i=0; i<r; i++) {
				if (Float.isNaN(percentDry[i])) {
					//logger.trace("k = " + k + " i = " + i + " percentDry is null!");
				}
				else {
					percentDryCount = percentDryCount + 1;	
				}
				// Only calculate score if fcst, obs, and percentDry are not NaN
                        	if ( !( Float.isNaN(fcstCat[i]) || Float.isNaN(obsCat[i]) || Float.isNaN(percentDry[i]) )) {
                                	if (fcstCat[i] == (k)) {
						// Use percent dry location climatology to define arid, semi-arid, and normal locations 
						// 0 and 100 are valid values for percentDry
						// Arid locations
						if (percentDry[i] >= 67.0 && percentDry[i] <= 100.0) {
							// Set the expected value for each category for arid locations
							if (k==1) {
								expected[i] = (float) percentDry[i]/100.0f;
							}
							else if (k==2) {
								expected[i] = (float) 0;
							}
							else if (k==3) {
								expected[i] = (float) 1.0 - (percentDry[i]/100.0f);
							}
							// Collapse to a 2 class system for arid locations
							if (fcstCat[i] == 2) {
								logger.trace("orig fcstCat " + fcstCat[i]);
								fcstCat[i] = (float) 1;
								arid2classFcstCount = arid2classFcstCount + 1;
								logger.trace("arid fcst N changed to B: k = " + k + " i = " + i);
								logger.trace("new fcstCat " + fcstCat[i]);
								expected[i] = (float) percentDry[i]/100.0f;
							}
							if (obsCat[i] == 2) {
								logger.trace("orig fcstCat " + fcstCat[i]);
								obsCat[i] = (float) 1;
								arid2classObsCount = arid2classObsCount + 1;
								logger.trace("arid obs N changed to B: k = " + k + " i = " + i);
								logger.trace("new fcstCat " + fcstCat[i]);
							}
						}
						// Semi-arid locations
						else if (percentDry[i] >= 34.0 && percentDry[i] < 67.0) {
							// Set the expected value for each category for semi-arid locations
							if (k==1) {
								expected[i] = (float) 0.667;
							}
        	                else if (k==2) {
        	                        expected[i] = (float) 0;
        	                }
        	                else if (k==3) {
        	                        expected[i] = (float) 0.333;
        	                }
							// Collapse to a 2 class system for arid locations
							if (fcstCat[i] == 2) {
								logger.trace("orig fcstCat " + fcstCat[i]);
								fcstCat[i] = (float) 1;
								semiArid2classFcstCount = semiArid2classFcstCount + 1;
								logger.trace("semi arid fcst N changed to B: k = " + k + " i = " + i);
								logger.trace("new fcstCat " + fcstCat[i]);
								expected[i] = (float) 0.667;
							}
							if (obsCat[i] == 2) {
								logger.trace("orig fcstCat " + fcstCat[i]);
								obsCat[i] = (float) 1;
								semiArid2classObsCount = semiArid2classObsCount + 1;
								logger.trace("semi arid obs N changed to B: k = " + k + " i = " + i);
								logger.trace("new fcstCat " + fcstCat[i]);
							}
						}
						// Normal locations
						// No collapsing of categories
						else if (percentDry[i] < 34.0 && percentDry[i] >= 0.0) {
							// Set the expected value for each category for semi-arid locations
							if (k==1) {
								expected[i] = (float) 0.333;
							}
                               	         		else if (k==2) {
                               	                        	expected[i] = (float) 0.333;
                               	                 	}
                                                	else if (k==3) {
                                                	        expected[i] = (float) 0.333;
                                                	}
						}
						logger.trace("fcstCat " + fcstCat[i] + " expected " + expected[i] + " at i = " + i);
					} // end if to check current category 
                                } // end NaN check 
			} // end i loop over fcstCat
			logger.trace("percentDryCount = " + percentDryCount);
			logger.trace("arid2classFcstCount " + arid2classFcstCount);
			logger.trace("arid2classObsCount " + arid2classObsCount);
			logger.trace("semiArid2classFcstCount " + semiArid2classFcstCount);
			logger.trace("semiArid2classObsCount " + semiArid2classObsCount);
                } // end k loop for fcstCat

                // Calculate heidke by category 
		logger.trace("calculating heidke with dry location correction");
                for (int k=1; k<(numCats+1); k++) {
                        logger.trace("category: " + category[k]);
                        // Initialize counters
                        numCorrect[k] = 0;
                        count[k] = 0;
                        Total[k] = 0;
                        numExpected[k] = 0;
                        // Loop over each forecast
                        for (int i=0; i<r; i++) {
                                // Only calculate score if fcst, obs, and percentDry are not NaN
				if ( !( Float.isNaN(fcstCat[i]) || Float.isNaN(obsCat[i]) || Float.isNaN(percentDry[i]) )) {
                               		if (fcstCat[i] == (k)) {
                               		 	// Count total fcsts for current category (obs may be NaN)
                                       		Total[k] = Total[k] + 1;
                                        	// Determine the expected percent correct by chance
                                        	// numExpected depends on forecast category for that location
                                        	numExpected[k] = numExpected[k] + expected[i];
                                        	//Count number of correct fcsts
                                        	if (fcstCat[i] == obsCat[i]) {
                                        		numCorrect[k]=numCorrect[k] + 1;
                                        	}
                                        	// Count the number of fcst-ob pairs without any NaNs for current category
                                        	count[k] = count[k] + 1;
                                	} // end if to check current category
                                } // end NaN check
                        } // end i loop over fcstCat
                        // Calculate score if there is at least one fcst-ob pair
                        if (count[k] > 0) {
                              heidke[k] = (100 * ((numCorrect[k]-numExpected[k]) / (count[k]-numExpected[k])));
                        }
                        // If there are not fcst-obs pairs, score is undefined
                        else {
				logger.trace("Warning! No fcst-obs pairs found so settings score to NaN");
                              heidke[k] = Float.NaN;
                        }
                        logger.trace("heidke for category " + category[k] + " = " + heidke[k]);
                        logger.trace("numCorrect " + numCorrect[k]);
                        logger.trace("# of good pairs " + count[k]);
                        logger.trace("Total fcsts (obs may be NaN) " +  Total[k]);
                        logger.trace("numExpected " + numExpected[k]);
                } // end k loop for fcstCat
		
		// Calculate heidke for total category
                // Initialize counters
                numCorrect[0] = 0;
                nanCount = 0;
                // Calculate number of correct fcsts
                for (int i=0; i<r; i++) {
			// Only count where percentDry is not NaN
			if ( !( Float.isNaN(fcstCat[i]) || Float.isNaN(obsCat[i]) || Float.isNaN(percentDry[i]) )) {
                        	if (fcstCat[i] == obsCat[i]) {
                                	numCorrect[0]=numCorrect[0]+1;
                        	}
			}
			// Count number of fcst-ob pairs with at least one NaN
			else {
				nanCount = nanCount + 1;
			}
                }
                // Determine total number of pairs without any NaNs
                count[0] = r - nanCount;
                Total[0] = r;

                // Determine number of expected correct using dry location correction
		numExpected[0] = numExpected[1] + numExpected[2] + numExpected[3];

                // Calculate score if there is at least one fcst-ob pair
                if (count[0] > 0) {
                        heidke[0] = (100 * ((numCorrect[0]-numExpected[0]) / (count[0]-numExpected[0])));
                }
                // If there are not fcst-obs pairs, score is undefined
                else {
                        heidke[0] = Float.NaN;
                }
                logger.trace("heidke for all cats = " + heidke[0]);
                logger.trace("numCorrect " + numCorrect[0]);
                logger.trace("# of good pairs " + count[0]);
                logger.trace("numExpected " + numExpected[0]);

                return heidke;
        }  // end calcHeidkeNoEcDryLocationCorrection 1-D

	/**
	* Returns heidke score of all forecasts, including EC, calculated over 1 dimension for
    * both the total and separate categories in the order total,B,N,A. 
	* Scores for the separate categories are the same as in the noEC version.
	* See calcHeidkeNoEc to verify without using EC forecasts.
	* Zeros from all models except manual should be removed before use.
	* This method ignores NaNs, and if no fcst-ob pairs are found it returns NaN.
	* The number of categories to verify is set to 3.
	* HeidkeWithEC=((numCorrect of nonEC fcsts + numCorrect of EC fcsts) - numExpected)/(count - numExpected) 
	* where numCorrect of EC fcsts is (num of EC fcsts/numCats) or 1/3 of all EC fcsts when numCats is 3, 
	* and numExpected is (count/number of categories) and count is sum of valid EC and non EC fcst-ob pairs.
	* HeidkeWithEC simplifies to HeidkeNoEC * coverage where coverage is (number of non EC fcsts/count).
	* The Heidke score utilizes the number of correct and incorrect category hits.
	* The values for heidke scores range from -50 to 100. A score of 100 indicates a perfect
	* forecast, and a score of -50 indicates a perfectly incorrect forecast. Scores greater
	* than 0 indicate improvement compared to a random forecast and indicate skill.
	*
    * @param fcstCat  1-d float array of forecast categories
    * @param obsCat   1-d float array of observed categories
    *
    * @return  1-d float array of score calculated over 1 dimension for Total,B,N,A
	*/
	public static float[] calcHeidkeWithEc(float fcstCat[], float obsCat[]) {
		logger = Logger.getLogger(StatsLibrary.class.getName());
		logger.trace("In calcHeidkeWithEc calculating heidke with EC 1-d");

		// Initialize variables for this score
		// NaNs are from missing data, weekends with no manual forecast, etc
		int numCats = 3;      // Number of forecast categories (a,b,n)
		float[] numExpected = new float[4];    // num of random fcsts expected to be correct
		float[] heidke = new float[4];   // value returned
		float coverage=(float) 0; // fraction of fcsts that are non-equal chance
		int nanCount = 0;     // num of fcst-ob pairs with at least one NaN
		int r=fcstCat.length;
		int nonZeroCount = 0; // number of valid non EC forecasts
		int[] count = new int[4]; // total number of valid fcst-ob pairs including EC fcsts
		int[] Total = new int[4]; // total number of fcsts 
		int zeroCount = 0;    // number of EC fcsts
                int[] numCorrect = new int[4];   // num correct non EC forecasts
		float EcCorrect;      // number of correct EC fcsts (defined to be 1/3 of EC fcsts)
		float totCorrect;     // number of correct non EC and EC fcsts
		String[] category = SettingsHashLibrary.getCategoryNames();

		numCorrect[0] = 0;
		Total[0] = r;
		// Loop through valid fcst-ob pairs
		for (int i=0; i<r; i++) {
			if ( !( Float.isNaN(fcstCat[i]) || Float.isNaN(obsCat[i]) )) {
				// Count number of EC forecasts
				if (fcstCat[i] == 0) {
					zeroCount = zeroCount + 1;
				}
				else {
					// Count number of non EC forecasts
					nonZeroCount = nonZeroCount + 1;
					// Count number of correct non EC fcsts 
					if (fcstCat[i] == obsCat[i]) {
						numCorrect[0] = numCorrect[0] + 1;
					}
				}
			}
		}
		logger.trace("# of EC fcsts = " + zeroCount);
		logger.trace("# of non EC fcsts = " + nonZeroCount);
		logger.trace("numCorrect of non EC= " + numCorrect[0]);

		// Determine number of fcst-ob pairs with NaNs
		nanCount = r - zeroCount - nonZeroCount;
		logger.trace("nanCount = " + nanCount);
		
		// Determine number of fcst-ob pairs without NaNs
		count[0] = zeroCount + nonZeroCount;
		logger.trace("count = " + count[0]);

		// Determine number of random fcsts expected to be correct
		// Total valid pairs including EC fcsts/number of categories
		numExpected[0] = (float) count[0]/numCats;    
		float numExpected2 = (float) nonZeroCount/numCats;    
		logger.trace("numExpected = " + numExpected[0]);
		logger.trace("numExpected2 = " + numExpected2);

		// Determine number of correct EC fcsts (1/3 of all EC forecasts)
		EcCorrect = (float) zeroCount/numCats;
		logger.trace("EcCorrect = " + EcCorrect);

		// Count total number of correct fcsts including both non EC and EC fcsts
		totCorrect = (float) numCorrect[0] + EcCorrect;
		logger.trace("totCorrect = " + totCorrect);

		// Fraction of fcsts that are non-equal chance
		// total number of non EC fcsts/total number of valid fcsts
		if (count[0] > 0) {
			coverage = (float) nonZeroCount/count[0]; 
		}
		else {
			coverage = 0.0f;		
		}
		logger.trace("coverage = " + coverage);

		float heidke2;
		float heidke3;
		// Calculate score if there is at least one fcst-ob pair
		if (count[0] > 0) {
				heidke[0] = (100 * ((totCorrect-numExpected[0]) / (count[0]-numExpected[0])));
		}
		// If there are not fcst-obs pairs, score is undefined
		else {
				heidke[0] = Float.NaN;
		}

		// This is temporary to check that heidke with EC and without EC are consistent
		if (nonZeroCount > 0 ) {
			heidke2 = (100 * coverage * ((numCorrect[0]-numExpected2) / (nonZeroCount-numExpected2)));
			heidke3 = (100 * ((numCorrect[0]-numExpected2) / (nonZeroCount-numExpected2)));
		}
		else {
			heidke2 = Float.NaN;
			heidke3 = Float.NaN;
		}
			logger.trace("heidke all cats with EC = " + heidke[0]);
			logger.trace("heidke all cats with EC using heidke w/o EC*coverage = " + heidke2);
			logger.trace("heidke all cats without EC = " + heidke3);

		// Calculate heidke by category
		for (int k=1; k<(numCats+1); k++) {
			logger.trace("category: " + category[k]);
			// Initialize counters
			numCorrect[k] = 0;
			numExpected[k] = 0;
			count[k] = 0;
			Total[k] = 0;
			// Loop over each forecast
			for (int i=0; i<r; i++) {
				if (fcstCat[i] == (k)) {
					// Count number of fcsts for current category (obs may be NaN)
					Total[k] = Total[k] + 1;
					// Count number of correct fcsts
					if (fcstCat[i] == obsCat[i]) {
							numCorrect[k]=numCorrect[k]+1;
					}
					// Count the number of fcst-ob pairs without any NaNs for each category
					if ( !(Float.isNaN(fcstCat[i])) && !(Float.isNaN(obsCat[i])) ) {
							count[k] = count[k] + 1;
					}
				} // end if to check cat
			}
			numExpected[k] = (float) count[k]/numCats;    // Number of random fcsts expected to be correct
					// Calculate score if there is at least one fcst-ob pair
			if (count[k] > 0) {
						heidke[k] = (100 * ((numCorrect[k]-numExpected[k]) / (count[k]-numExpected[k])));
			}
			// If there are not fcst-obs pairs, score is undefined
			else {
						heidke[k] = Float.NaN;
			}
			logger.trace("heidke for cat " + k + " = " + heidke[k]);
			logger.trace("numCorrect " + numCorrect[k]);
			logger.trace("# of good pairs " + count[k]);
			logger.trace("Total fcsts (obs may be NaN) " + Total[k]);
			logger.trace("numExpected " + numExpected[k]);
		}
		return heidke;
	}  // end calcHeidkeWithEc 1-D



	/**
	 * Returns ranked probability skill score calculated over 1 dimension.
	 * By definition this score takes into account all categories at once.
	 * EC is used for this score because it does not use forecast categories
	 * directly, only the forecast probabilities.
	 * This method ignores NaNs, and if no fcst-ob pairs are found it returns NaN.
	 * The number of categories to verify is 3.
	 * RPSS = 1 - RPS/RPSreference
	 * RPS = 1/N * (probB-obsB)*(probB-obsB) + (probN-obsN)*(probN-obsN) + (probA-obsA)*(probA-obsA)
	 * where probabilities of B,N,A are cumulative and the total is 1, the obs are either 
	 * 0 or 1, and N is the number of valid fcst-ob pairs.
	 * ie. for a forecast of 50%B (50%B,33%N,17%A) the cumulative probs are: B=0.5, N=0.833, A=1.0
	 * If a category verifies, obs is 1, if it does not verify, obs is 0.
	 * RPSreference is identical to RPS except that the forecast probs for each category are
	 * constant reference values for each category.
	 * RPSS values range from -Infinity to 1. The RPS penalizes forecasts less severely when their
	 * probabilities are close to the outcome and more severely when their probabilties are
	 * further from the outcome.
	 *
     * @param fcstProb  2-d float array of forecast probabilities
     * @param obsCat   1-d float array of observed categories
     *
	 * @return      float value of score calculated over 1 dimension
	 */
	public static float calcRpss(float fcstProb[][], float obsCat[]) {
		logger = Logger.getLogger(StatsLibrary.class.getName());
		logger.trace("In calcRpss calculating rpss 1-d");

		// Initialize variables
		float probB=Float.NaN;
		float probN=Float.NaN;
		float probA=Float.NaN;
		float obsB=Float.NaN;
		float obsN=Float.NaN;
		float obsA=Float.NaN;
		float RPS=(float) 0;
		float RPSRef=(float) 0;
		float RPSS;  		// value returned
		int r=fcstProb.length;
		int N=0;
		// Initialize variables for RPS climatology
		// Ref probs are set to match Scott's values
		float probRefB=(float) .3333; 
		float probRefN=(float) .6666;
		float probRefA=(float) .9999;
		int obsRefB;
		int obsRefN;
		int obsRefA;
		float refB;
		float refN;
		float refA;

		// Determine cumulative probability and if obs verified
		for (int i=0; i<r; i++) {
		logger.trace("B " + fcstProb[i][0] + " N " + fcstProb[i][1] + " A " + fcstProb[i][2] + " obs " + obsCat[i]);
			// If any probability for obs is missing do not calculate RPS 
			if ( !( Float.isNaN(fcstProb[i][0]) || Float.isNaN(fcstProb[i][1]) || 
						Float.isNaN(fcstProb[i][2]) || Float.isNaN(obsCat[i]) )) {
				N = N + 1;
				switch ( (int) obsCat[i]) {
					case 1:     // obs of B
						probB=fcstProb[i][0];
						obsB=(float) 1;
						probN=fcstProb[i][0]+fcstProb[i][1];
						obsN=(float) 1;
						probA=fcstProb[i][0]+fcstProb[i][1]+fcstProb[i][2];
						obsA=(float) 1;
						break;
					case 2:     // obs of N
						probB=fcstProb[i][0];
						obsB=(float) 0;
						probN=fcstProb[i][0]+fcstProb[i][1];
						obsN=(float) 1;
						probA=fcstProb[i][0]+fcstProb[i][1]+fcstProb[i][2];
						obsA=(float) 1;
						break;
					case 3:     // obs of A (this term drops out no matter what)
						probB=fcstProb[i][0];
						obsB=(float) 0;
						probN=fcstProb[i][0]+fcstProb[i][1];
						obsN=(float) 0;
						probA=fcstProb[i][0]+fcstProb[i][1]+fcstProb[i][2];
						obsA=(float) 1;
						break;
					default:   // obs are missing 
						   // It should never get in here so NaNs won't be an issue here
						probB=Float.NaN;
						obsB=Float.NaN;
						probN=Float.NaN;
						obsN=Float.NaN;
						probA=Float.NaN;
						obsA=Float.NaN;
				} // end switch

				// Calculate RPS 
				RPS = RPS + (float) ( Math.pow(probB-obsB,2) + Math.pow(probN-obsN,2) + Math.pow(probA-obsA,2) );
				logger.trace("RPS = " + RPS);

				// Calculate RPS of climo
				RPSRef = RPSRef + (float) ( Math.pow(probRefB-obsB,2) + Math.pow(probRefN-obsN,2) + Math.pow(probRefA-obsA,2) );
				logger.trace("RPSRef = " + RPSRef);
			} // end if to check for NaNs
		} // end for


		// If there is at least 1 valid fcstProb and ob pair calculate the skill score otherwise RPSS is NaN
		// If N is not zero, RPS, RPSRef, and RPSS cannot be NaN
		if ( N > 0 ) {
			// Calculate average RPS
			RPS = RPS/N;
			logger.trace("ave RPS = " + RPS);
			RPSRef = RPSRef/N;
			logger.trace("ave RPSRef = " + RPSRef);
			// Calculate ranked probability skill score
			RPSS = 1 - (RPS/RPSRef);
		}
		else {
			RPSS=Float.NaN;
		}
		logger.trace("N = " + N);
		logger.trace("RPSS = " + RPSS);

		return RPSS;
	}  // end calcRpss 1-D

	/////////////////////////////////////////////////////////////

	/**
	 * Returns Brier skill score of non EC forecasts calculated over 1 dimension for 
	 * total and separate categories in the order total,B,N,A.
	 * EC forecasts (zeros) and corresponding probabilities should be removed from  
	 * all models before use or the score will be incorrect.
	 * Probabilities associated with zeros from all models should be removed before use.
	 * A score is calculated for the forecast category only so scores for EC do not make sense.
	 * This method ignores NaNs, and if no fcst-ob pairs are found it returns NaN.
	 * The number of categories to verify is 3.
	 * BSS = 1 - BS/BSreference
	 * BS = 1/N * (prob-obs)*(prob-obs)
	 * If a category verifies, obs is 1, if it does not verify, obs is 0.
	 * BSreference is identical to BS except that the forecast prob is a constant reference value.
	 * BSS values range from -Infinity to 1. The BS penalizes forecasts less severely when the
	 * probabilities are close to the outcome and more severely when the probabilties are
	 * further from the outcome.
	 *
     * @param fcstCat  1-d float array of forecast categories
     * @param fcstProb  2-d float array of forecast probabilities
     * @param obsCat   1-d float array of observed categories
     * @param variable String of variable, should include thresholds if non-even tercile forecasts are being processed
     *
     * @return  1-d float array of score calculated over 1 dimension for Total,B,N,A
	 * where all is a weighted average of all categories 
	 */
	public static float[] calcBrier(float fcstCat[], float fcstProb[][], float obsCat[], String variable) throws Exception {
		logger = Logger.getLogger(StatsLibrary.class.getName());
		logger.trace("In calcBrier calculating Brier non EC");

		// Initialize variables
		// Arrays
		float[] brierSS  = new float[3];
		float[] brier    = new float[3];
		float[] brierRef = new float[3];
		int[]   numFcsts = new int[3];
		float[] brierSSall = new float[4];    // array returned
		// Non-arrays
		float obs = Float.NaN;
		float brierSSTotal = (float) 0;
		int numCats = 3;
		int numFcstsTotal = 0;
        float[] climProb = new float[3];
        // If non-even terciles, get climProb from the percentile thresholds
        // See if an extreme is being processed
	    boolean isEvenTerciles = SettingsHashLibrary.isEvenTerciles(variable);
        if (isEvenTerciles == false) {
            float thresholdLower;
            float thresholdUpper;
            float probWindows[] = new float[3];
            // Get category thresholds
            try {
                thresholdLower = Float.parseFloat(SettingsHashLibrary.getCategoryThresholds(variable)[0]);
                thresholdUpper = Float.parseFloat(SettingsHashLibrary.getCategoryThresholds(variable)[1]);
                // Get windows of probability/percentiles based on lower and upper thresholds
                probWindows = SettingsHashLibrary.getPercentileWindows(thresholdLower,thresholdUpper);
            } catch(Exception e) {
                logger.warn("Can't get category percentile windows." + e);
                throw e;
            }
            climProb[0] = probWindows[0]/100.0f;
            climProb[1] = probWindows[1]/100.0f;
            climProb[2] = probWindows[2]/100.0f;
        }
        // Else even terciles
        else {
            climProb[0] = (float) 1/numCats;
            climProb[1] = (float) 1/numCats;
            climProb[2] = (float) 1/numCats;
        }
        logger.trace("climProb for 3 cats : " + climProb[0] + " , " + climProb[1] + " , " + climProb[2]);
		int r = fcstCat.length;
		String[] category = SettingsHashLibrary.getCategoryNames();

                // Set values to 0 since values in these arrays are summed
		int b=brier.length;
		for (int i=0; i<b; i++) {
			brier[i]=(float) 0;
			brierRef[i]=(float) 0;
			numFcsts[i]= 0;
		}

		for (int i=0; i<r; i++) {
			// If fcst or obs are missing do not calculate score
			if ( !( Float.isNaN(fcstCat[i]) || Float.isNaN(obsCat[i]) || Float.isNaN(fcstProb[i][0])
						|| Float.isNaN(fcstProb[i][1]) || Float.isNaN(fcstProb[i][2]) )) {
				// Determine if category verified
				if (fcstCat[i] == obsCat[i]) {
					obs=(float) 1;
				}
				else {
					obs=(float) 0;
				}

				switch ( (int) fcstCat[i]) {
					case 1:     // fcst of B
						numFcsts[0] = numFcsts[0]+1;
						brier[0]    = brier[0]    + (float) Math.pow(fcstProb[i][0]-obs,2);
						brierRef[0] = brierRef[0] + (float) Math.pow(climProb[0]-obs,2);
						break;
					case 2:     // fcst of N
						numFcsts[1] = numFcsts[1]+1;
						brier[1]    = brier[1]    + (float) Math.pow(fcstProb[i][1]-obs,2);
						brierRef[1] = brierRef[1] + (float) Math.pow(climProb[1]-obs,2);
						break;
					case 3:     // fcst of A
						numFcsts[2] = numFcsts[2]+1;
						brier[2]    = brier[2]    + (float) Math.pow(fcstProb[i][2]-obs,2);
						brierRef[2] = brierRef[2] + (float) Math.pow(climProb[2]-obs,2);
						break;
					default:
						break;
				} // end switch
			} // end if to check for NaNs
		} // end for

		// If there is at least 1 fcst-ob pair for each category calculate	 
		// a score for each category
		int count = 0;
		for (int i=0; i<numCats; i++) {
			if (numFcsts[i] > 0) {
				brier[i]    = brier[i]/numFcsts[i];
				brierRef[i] = brierRef[i]/numFcsts[i];
				brierSS[i]  = 1 - brier[i]/brierRef[i];
			} else {
				brier[i]    = Float.NaN;
				brierRef[i] = Float.NaN;
				brierSS[i]  = Float.NaN;
			}

			// Calculate a single Brier score using weighted category scores
			// Don't sum NaNs
			if ( !(Float.isNaN(brierSS[i]*numFcsts[i])) ) {
				brierSSTotal  = brierSSTotal + brierSS[i]*numFcsts[i];
				numFcstsTotal = numFcstsTotal + numFcsts[i];
				// Count # of categories with non NaNs 
				count = count + 1;
			}
			
			logger.trace("count of non NaN brier cats into total = " + count);
			logger.trace("numFcsts for category " + category[(i+1)] + " is: " + numFcsts[i]);

			// Put the scores for each category into an array
			// The order is All,B,N,A 
			brierSSall[i+1] = brierSS[i];
		}
		logger.trace("brierSSTotal = " + brierSSTotal);
		logger.trace("numFcstsTotal = " + numFcstsTotal);

		// Finish calculating single Brier score 
		if (count==0) {
			// Scores for every category are NaN so the sum should be set to NaN
			brierSSTotal = Float.NaN;
		}
		else {
			// Scores were summed correctly in the above section ignoring NaNs
			// just need to divide by the weights
			brierSSTotal =  brierSSTotal / numFcstsTotal;
		}
	
		// Put the score for the total weighted average of all categories into the array
		// that contains scores for individual categories
		brierSSall[0]=brierSSTotal;  

		// Concatenate the average Brier and the component Briers
		//	return ArrayUtils.addAll(brierSS,brierSSTotal);

		logger.trace("brierSS for all cats = " + brierSSall[0]);
		logger.trace("brierSS for B = " + brierSSall[1]);
		logger.trace("brierSS for N = " + brierSSall[2]);
		logger.trace("brierSS for A = " + brierSSall[3]);
		return brierSSall;
	}  // end calcBrier 1-D

	/////////////////////////////////////////////////////////////

	/**
	* Returns reliability scores, not including EC forecasts, for each probability range 
	* calculated over space and location for both the total and separate categories
	* in the order total,B,N,A.
	* Reliability scores are calculated for each forecast for all categories regardless 
	* of which category was forecast.
	* Reliability array is [category][bin] where category is Total,B,N,A. 
	* The reliability of all categories together is a weighted average of the reliability for
	* the B,N,A categories. A weighted average in this case is mathematically the same as
	* summing the reliability scores for each category for each probability bin.
	* EC forecasts (zeros) and corresponding probabilities should be removed from 
	* all models before use or the score will be incorrect.
	* See calcReliabilityWithEc to verify using EC forecasts. 
	* The number of bins and the threshold values are declared in the Stats class.
	* Values in the bins include the lower value but are less than the higher value.
	* The bin is a range of values from the indices in probabilityBinLowerThreshold and
 	* probabilityBinUpperThreshold.  Associated with each of these values is a value in a reference
	* array which is probabilities from 0 to 1.
	* This method ignores NaNs, and if no fcst-ob pairs are found it returns NaN.
	* The equation is: # obs category / # fcst category where category is either B,N,A.
	* For all categories together the equation is:
	* (# obs A/# fcst A) + (# obs B/# fcst B) + (# obs N/# fcst N)
	*
    * @param fcstProb  3-d float array of forecast probabilities
    * @param obsCat   2-d float array of observed categories
	* @param probabilityBinLowerThreshold  1-d float array of values representing the beginning of the probability ranges associated with matching indices of the upper threshold.
	* @param probabilityBinUpperThreshold  1-d float array of values representing the beginning of the probability ranges associated with matching indices of the lower threshold.
	* @param bins integer number of bins
	*
	* @return 2-d float array of score calculated over 2 dimensions where the first dimension
	* is Total,B,N,A and the second dimension is for each bin 
	*/
	public static float[][] calcReliabilityNoEc(float fcstProb[][][], float obsCat[][], 
					float[] probabilityBinLowerThreshold, float[] probabilityBinUpperThreshold, int bins) {
		logger = Logger.getLogger(StatsLibrary.class.getName());
		logger.trace("In calcReliabilityNoEc calculating reliability no EC");
		// Initialize variables
		int fcstCatTotal;	// total # of fcsts for a category in a probability range	
		int obsCatCount;	// # of obs that verify for the fcst cat in the prob range
		float[][] reliability = new float[4][bins];	
		float reliabilityAll;
		float numFcstsTotal;
		int count;
		int[][] fcstCountArray = new int[4][bins];

		// Loop through each category
		for (int k=0; k<3; k++) {
			// Loop through each bin (probability range bin or 'prob bin')
			logger.trace("*** Category to verify is: " + (k+1) + " ***");
			for (int b=0; b<bins; b++) { 
				logger.trace("bin is: " + b + " range is " + probabilityBinLowerThreshold[b] + "-" + probabilityBinUpperThreshold[b]);
				// Reset counters
				fcstCatTotal = 0;
				obsCatCount = 0;
				// Loop through each fcstProb for the current category
				for (int i=0; i<fcstProb.length; i++) {
					for (int j=0; j<fcstProb[0].length; j++) {
						// If any prob or ob is missing do not count it
						if ( !( Float.isNaN(fcstProb[i][j][0]) || Float.isNaN(fcstProb[i][j][1]) || Float.isNaN(fcstProb[i][j][2]) || Float.isNaN(obsCat[i][j]) )) {
							// Count # of fcsts for the current fcstCat and prob bin      
							if (b!=(bins-1)) { //  to skip last bin
								if (fcstProb[i][j][k] >= probabilityBinLowerThreshold[b] && fcstProb[i][j][k] < probabilityBinUpperThreshold[b]) {
									fcstCatTotal = fcstCatTotal + 1;
									//logger.trace("found fcstCat");
									// Count # of obs corresponding to the fcst cat and prob bin that verify
									if (obsCat[i][j]==(k+1)) {
										obsCatCount = obsCatCount + 1;
										//logger.trace("found obsCat");
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
				// Reliability is the percent correct of obs in each prob bin for each fcst category
				// Populate columns 1 to 3 with scores by category
				fcstCountArray[k+1][b] = fcstCatTotal;
				if (fcstCatTotal > 0) {
					reliability[k+1][b] = (float) obsCatCount/fcstCatTotal;
					//fcstCountArray[k+1][b] = (float) fcstCatTotal;
				}
				else {
					reliability[k+1][b] = Float.NaN;
					//fcstCountArray[k+1][b] = Float.NaN;
				}
				logger.trace("obsCatCount = " + obsCatCount);
				logger.trace("fcstCatTotal = " + fcstCatTotal);
				logger.trace("reliability = " + reliability[k+1][b]);
			} // End b for loop 
		} // End k for loop
		// Populate 1st dimension (reliability of all cats together) as a weighted average of all category scores 
		for (int b=0; b<bins; b++) {
			reliabilityAll =(float) 0;
			numFcstsTotal = (float) 0;
			count = 0;
			// Loop over all cats
			for (int k=1; k<4; k++) {
				if ( !(Float.isNaN(reliability[k][b]*fcstCountArray[k][b])) ) {
					reliabilityAll = reliabilityAll + (reliability[k][b]*fcstCountArray[k][b]);
					numFcstsTotal = numFcstsTotal + fcstCountArray[k][b];
					count = count + 1;
				}
			}
			// Save weighted ave if there is at least 1 category with a reliability value
			if (count == 0) {
				reliability[0][b] = Float.NaN;
			}
			else {
				reliability[0][b] = reliabilityAll/numFcstsTotal;
			}
			logger.trace("reliability = " + reliability[0][b]);
			logger.trace("numFcstsTotal = " + numFcstsTotal);
		} // End b for loop
		return reliability;
	}

	/**
    * Returns reliability scores, including EC forecasts, for each probability range
    * calculated over space and location for both the total and separate categories
    * in the order total,B,N,A.
	* Zeros and probabilities associated with zeros from all models except manual
	* should be removed before use.
    * Reliability scores are calculated for each forecast for all categories regardless
    * of which category was forecast.
    * Reliability array is [category][bin] where category is Total,B,N,A.
	* The reliability of all categories together is a weighted average of the reliability for
	* the B,N,A categories. A weighted average in this case is mathematically the same as
	* summing the reliability scores for each category for each probability bin.
    * See calcReliabilityNoEc to verify without using EC forecasts.
    * Number of bins and the threshold values are declared in the Stats class.
    * The bin is a range of values from the indices in probabilityBinLowerThreshold and
 	* probabilityBinUpperThreshold.  Associated with each of these values is a value in a reference
    * array which is probabilities from 0 to 1. 
	* Values in the bins include the lower value but are less than the higher value.
	* For EC forecasts, there is a narrow bin from .3333 to .3334 (only probs of .3333 are included 
	* in this bin). The N category for this bin contains reliability scores for EC forecasts 
	* and forecasts where N is .3333. The A and B categories for this bin may also contain
	* EC forecasts along with forecasts of .3333 for their respective categories, 
	* although forecasts of .3333 for A or B only occur in rare cases when there is a 
	* forecast of .3334 for N. A sum (weighted average) of the reliability of the EC
	* and N forecasts is used to calculate the reliability for the N/EC category for the .3333 prob
	* bin.  In short, the reliability of the .3333 bin can be attributed all or mostly to EC forecasts
	* for the A and B categories and approximately even amounts of N adn EC forecasts for the N 
	* category.  The reliability of all categories together for this bin is the sum of the B,N/EC,
	* and A reliabilities.
	* EC forecasts (zeros) are verified by counting the corresponding obs for each category
	* and plotting the observed frequency of each category at the forecast probability of .3333.
	* The equation is: # obs category / # fcst category where category is either B,N,A.
	* For all categories together the equation is:
	* (# obs A/# fcst A) + (# obs B/# fcst B) + (# obs N/# fcst N)
    * This method ignores NaNs, and if no fcst-ob pairs are found it returns NaN.
    *
    * @param fcstProb  3-d float array of forecast probabilities
    * @param fcstCat  2-d float array of forecast categories
    * @param obsCat   2-d float array of observed categories
    * @param probabilityBinLowerThreshold  1-d float array of values representing the beginning of the probability ranges associated with matching indices of the upper threshold.
    * @param probabilityBinUpperThreshold  1-d float array of values representing the beginning of the probability ranges associated with matching indices of the lower threshold.
    * @param bins integer number of bins
    *
    * @return 2-d float array of score calculated over 2 dimensions where the first dimension is 
	* for Total,B,N,A and the second dimension is for each bin
    */
    public static float[][] calcReliabilityWithEc(float fcstProb[][][], float fcstCat[][], float obsCat[][], 
					float[] probabilityBinLowerThreshold, float[] probabilityBinUpperThreshold, int bins) {
        logger = Logger.getLogger(StatsLibrary.class.getName());
        logger.trace("In calcReliabilityWithEc calculating reliability with EC");
        // Initialize variables
        int fcstCatTotal;   // total # of fcsts for a category in a probability range
        int obsCatCount;    // # of obs that verify for the fcst cat in the prob range
		int fcstEcCatTotal = 0; // total # of EC fcsts 
		int obsEcCatCount;      // # of obs for EC fcsts for each category 
        float[][] reliability = new float[4][bins];
        float reliabilityAll;
        float numFcstsTotal;
        int count;
        int[][] fcstCountArray = new int[4][bins];

        // Loop through each category
        for (int k=0; k<3; k++) {
			//obsEcCatCount = 0;
			//fcstEcCatTotal = 0;
            // Loop through each bin (probability range bin or 'prob bin')
            logger.trace("*** Category to verify is: " + (k+1) + " ***");
            for (int b=0; b<bins; b++) {
                logger.trace("bin is: " + b + " range is " + probabilityBinLowerThreshold[b] + "-" + probabilityBinUpperThreshold[b]);
                // Reset counters
                fcstCatTotal = 0;
                obsCatCount = 0;
				obsEcCatCount = 0;
				fcstEcCatTotal = 0;
                // Loop through each fcstProb for the current category
                for (int i=0; i<fcstProb.length; i++) {
                    for (int j=0; j<fcstProb[0].length; j++) {
                        // If any prob or ob is missing do not count it
                        if ( !( Float.isNaN(fcstProb[i][j][0]) || Float.isNaN(fcstProb[i][j][1]) || Float.isNaN(fcstProb[i][j][2]) || Float.isNaN(obsCat[i][j]) )) {
							//logger.trace("fcstCat: " + fcstCat[i][j] + " obsCat: " + obsCat[i][j] + " prob b: " + fcstProb[i][j][0] + " prob n: " + fcstProb[i][j][1] + " prob a: " + fcstProb[i][j][2]); 
							if (fcstCat[i][j] != 0) {
                            	// Count # of fcsts for the current fcstCat and prob bin
                            	if (b!=(bins-1)) { //  to skip last bin
                            	    if (fcstProb[i][j][k] >= probabilityBinLowerThreshold[b] && fcstProb[i][j][k] < probabilityBinUpperThreshold[b]) {
                            	        fcstCatTotal = fcstCatTotal + 1;
                            	        //logger.trace("found fcstCat");
                            	        // Count # of obs corresponding to the fcst cat and prob bin that verify
                            	        if (obsCat[i][j]==(k+1)) {
                            	            obsCatCount = obsCatCount + 1;
                            	            //logger.trace("found obsCat");
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
                    }
                }
                // Reliability is the percent correct of obs in each prob bin for each fcst category
                // Populate columns 1 to 3 with scores by category 
				// For the EC bin: A weighted average of EC forecasts and other forecasts with probs is used
				// For all other bins, the EC counts are zero, so the reliability is just for fcsts with that prob 
				fcstCountArray[k+1][b] = fcstEcCatTotal+fcstCatTotal;
				if ((fcstEcCatTotal+fcstCatTotal) > 0) {
					reliability[k+1][b] = (float) (obsEcCatCount+obsCatCount)/(fcstEcCatTotal+fcstCatTotal);
				}
				else {
					reliability[k+1][b] = Float.NaN;
				}
                logger.trace("obsCatCount = " + obsCatCount);
                logger.trace("fcstCatTotal = " + fcstCatTotal);
                logger.trace("obsEcCatCount = " + obsEcCatCount);
                logger.trace("fcstEcCatTotal = " + fcstEcCatTotal);
                logger.trace("reliability = " + reliability[k+1][b]);
				logger.trace("fcstCountArray = " + fcstCountArray[k+1][b]);
            } // End b for loop
        } // End k for loop

        // Populate 1st dimension (reliability of all cats together) as a weighted average of all category scores
        for (int b=0; b<bins; b++) {
            reliabilityAll =(float) 0;
            numFcstsTotal = (float) 0;
            count = 0;
            // Loop over all cats
            for (int k=1; k<4; k++) {
                if ( !(Float.isNaN(reliability[k][b]*fcstCountArray[k][b])) ) {
                    reliabilityAll = reliabilityAll + (reliability[k][b]*fcstCountArray[k][b]);
                    numFcstsTotal = numFcstsTotal + fcstCountArray[k][b];
                    count = count + 1;
                }
            }
            // Save weighted ave if there is at least 1 category with a reliability value
            if (count == 0) {
                reliability[0][b] = Float.NaN;
            }
            else {
                reliability[0][b] = reliabilityAll/numFcstsTotal;
            }
			logger.trace("reliability = " + reliability[0][b]);
			logger.trace("numFcstsTotal = " + numFcstsTotal);
        } // End b for loop
        return reliability;
    }

    /**
    Returns the average forecast probability per category per bin for reliability scores,
    which are used as the x axis plotting values on the diagram.
    Only fcsts as part of a valid forecast-ob pair are counted.
    will be incorrect.
    Dimensions are [category][bin] where category is Total,B,N,A.
    If no forecasts are found this method returns a NaN.

    @param fcstProb 3-d float array of forecast probability
    @param obsCat   2-d float array of observed category (0-3)
    @param probabilityBinLowerThreshold 1-d float array of probability bin lower thresholds
    @param probabilityBinUpperThreshold 1-d float array of probability bin upper thresholds
    @param bins integer number of probability bins

    @return  2-d integer array of # of fcsts per category and bin where the first dimension
    is Total,B,N,A and the second dimension is for each bin.
    */
    public static float[][] calcAverageProbability(float fcstProb[][][], float obsCat[][], float[] probabilityBinLowerThreshold, float[] probabilityBinUpperThreshold, int bins) {
        logger = Logger.getLogger(QCLibrary.class.getName());
        logger.debug("inside calcAverageProbability");

        // Initialize variables
        int fcstCatCount;          // # of fcsts for a category in a probability range
        float fcstCatProbSum;      // sum of probabilities for a category in a probability range
        float[][] aveProbArray = new float[4][bins];
        int[] fcstCountArray = new int[bins];     // # of fcsts for all categories in a probability range
        float[] fcstProbSumArray = new float[bins]; // sum of probs for all categories in a probability range
	String[] category = SettingsHashLibrary.getCategoryNames();
        // Set counters to zero
        for (int b=0; b<bins; b++) {
            fcstCountArray[b] = 0;
            fcstProbSumArray[b] = 0;
        }

        // Loop through each category
        for (int k=0; k<3; k++) {
            // Loop through each bin (probability range bin or 'prob bin')
            logger.trace("category is: " + category[(k+1)]);
            for (int b=0; b<bins; b++) {
                logger.trace("bin is: " + b + " range is " + probabilityBinLowerThreshold[b] + "-" + probabilityBinUpperThreshold[b]);
                // Reset counters
                fcstCatCount = 0;
                fcstCatProbSum = 0;
                // Loop through each fcstProb
                for (int i=0; i<fcstProb.length; i++) {
                    for (int j=0; j<fcstProb[0].length; j++) {
                        // If any fcstProb or ob is missing do not count it
                        if ( !( Float.isNaN(fcstProb[i][j][0]) || Float.isNaN(fcstProb[i][j][1]) || Float.isNaN(fcstProb[i][j][2]) || Float.isNaN(obsCat[i][j]) )) {
                            // Count # of fcsts for each fcstCat and prob bin and sum the probs
                            if (b!=(bins-1)) {  // to skip last bin
                                if (fcstProb[i][j][k] >= probabilityBinLowerThreshold[b] && fcstProb[i][j][k] < probabilityBinUpperThreshold[b]) {
                                    fcstCatCount = fcstCatCount + 1;
                                    fcstCatProbSum = fcstCatProbSum + fcstProb[i][j][k];
                                }
                            }
                            // For last bin, include the upperThreshold
                            else {
                                if (fcstProb[i][j][k] >= probabilityBinLowerThreshold[b] && fcstProb[i][j][k] <= probabilityBinUpperThreshold[b]) {
                                    fcstCatCount = fcstCatCount + 1;
                                    fcstCatProbSum = fcstCatProbSum + fcstProb[i][j][k];
                                }
                            }
                        } // end if to check for NaNs
                    }
                }
                // Calculate ave prob and populate columns 1-3 with averages by category
                aveProbArray[k+1][b] = fcstCatProbSum/fcstCatCount;
                logger.trace("fcstCatCount " + fcstCatCount);
                logger.trace("fcstCatProbSum " + fcstCatProbSum);
                logger.trace("ave " + aveProbArray[k+1][b]);
                // Sum counts and probs for all categories (to calc aveProb for all cats together)
                fcstCountArray[b] = fcstCountArray[b] + fcstCatCount;
                fcstProbSumArray[b] = fcstProbSumArray[b] + fcstCatProbSum;
            }
        }
        // Populate 1st dimension with the average per bin of all cats together
        for (int b=0; b<bins; b++) {
            aveProbArray[0][b] = fcstProbSumArray[b]/fcstCountArray[b];
            logger.trace("bin is " + b);
            logger.trace("fcstCountArray " + fcstCountArray[b]);
            logger.trace("fcstProbSumArray " + fcstProbSumArray[b]);
            logger.trace("ave " + aveProbArray[0][b]);
        }
        return aveProbArray;
    }

	//TO DO :
// 	Get a score summary of the total models (comparison using all models).
// 	<p>
// 	Information returned in the array is as follows :
// 	scoreSummaryAllModels[max score][date of max][model name of max][min score][date of min][model name of min]
// 	<p> 

	/**
	Returns a 3-d array of a score summary containing information for each individual model
	and each category. The score summary includes the following information:
	<p>
	<ul>
	<li> max and min values for each model and category
	<li> Reference information associated with these max and min values. This depends on the String array of data passed as String[] referenceStringArray, the second passed argument to this method. This can be a String list of dates, location information, etc.<p>
	If there is more than one occurance of the reference of either max or min, the reference information for index would contain
	a string list of values that are comma separated. For example, if 3.2 was the min, and it occured in the stats results for 2 different
	dates (1/1/10 and 2/2/10), in the cell array for indices, the String value would be "1/1/10,2/2/10".
   <li> Average value for each model and category
   <li> Number of values used to calculate the average for each model
	</ul>
	Information returned in the array is as follows :
	[model][category][max|max reference points|min|min reference points|ave|# values making up ave|# values making up max| # values making up min] 
	so :
	<p>
	1st Dimension : # models
	2nd Dimension : Categories 
	3rd Dimension : Score summary information about a model (see below)
	<p>
	where indexes in the third dimension are:
	0 - max value, 1 - date(s) or location(s) of max value. If more than one value, comma separated., 2 - min value, 3 - date(s) or location(s) of min value. If more than one value, comma separated.
	4 - average value, 5 - number of values making up average, 6 - # of date(s) or location(s) of max value, 7 - # of date(s) or location(s) of min value.
	NOTE : The array size of # cols specified in the scoreSummaryEachModel much match
	the size of the information supplied by the get methods that populate this array.
	<p>

	@param statsObj stats object containing statistics score information
	@param referenceStringArray a String array of information associated with the summary data (ie. dates, locations, etc.)
	@return 3-d string array of score information
	*/
	public static String[][][] getScoreSummaryArrayEachModel(Stats statsObj, String[] referenceStringArray) {
		logger = Logger.getLogger(StatsLibrary.class.getName());
		float[][][] scoreCatFloatArray = null;
		String[][][] scoreSummary = null;

		// Declare string buffers
		StringBuffer maxReferenceString;
		StringBuffer minReferenceString;
		String[] indicesMaxArrayStr = null;
		String[] indicesMinArrayStr = null;
		String[] category = SettingsHashLibrary.getCategoryNames();
		try {

			scoreCatFloatArray = statsObj.getScoreCatFloatArray();
			int numModels = scoreCatFloatArray.length;

			// Initialize information array, size of cols specified is the # of cols of model info
			String[][] maxMinInfo = new String[numModels][4];  // temporary array for max/min info
			String[][] aveInfo = new String[numModels][2];  // temporary array for average info
			scoreSummary = new String[numModels][4][8]; // array for all info 
			// For each model perform summary get methods
			for (int i=0; i<numModels; i++) {
				logger.trace("Getting summary for model " + i);
				logger.trace("Attempt to get max min value info");
				// Loop over each category
				for (int j=0; j<4; j++) {
					// Reinitialize string buffers between categories
					maxReferenceString = new StringBuffer();
					minReferenceString = new StringBuffer();
					// Get the max min stats for the current model and category
					logger.trace("the score to find max min : " + Arrays.toString(scoreCatFloatArray[i][j]));
					maxMinInfo[i] = MathLibrary.getMaxMinValueInfo(scoreCatFloatArray[i][j]);
					// Max value info
					// Populate columns 0 and 1 with max info
					scoreSummary[i][j][0] = maxMinInfo[i][0]; // Max value
					if (!(maxMinInfo[i][1].equals("N/A"))) {
						// Parse list of max indices by comma delimiter
						indicesMaxArrayStr = maxMinInfo[i][1].split(",");					
						// convert string array to integer array
						int[] indicesMaxValues = new int[indicesMaxArrayStr.length];
						logger.trace("**** model # = " + i + " max array length = " +  indicesMaxArrayStr.length + " category " + category[j] + "*******");
						for (int k=0;k<indicesMaxArrayStr.length;k++) {
							indicesMaxValues[k] = Integer.parseInt(indicesMaxArrayStr[k]);
							// If this is the first max index, do not include a comma
							// in the scoreSummary string for max indices
							if(k == 0) {
								logger.trace("indicesMaxValues[0] = " + indicesMaxValues[k]);
								maxReferenceString.append(referenceStringArray[indicesMaxValues[k]]);		
							}
							else {
							// If this is the second or greater max index, add reference info
							// comma delimited
								maxReferenceString.append(", ").append(referenceStringArray[indicesMaxValues[k]]);
							}
						logger.trace(" max ref value = " + referenceStringArray[indicesMaxValues[k]]);
						}
						// Get associated reference information associated with the max value
						scoreSummary[i][j][1] = maxReferenceString.toString();
						scoreSummary[i][j][6] = String.valueOf(indicesMaxArrayStr.length); // # of reference points that have the maximum value
					}
					else {
						scoreSummary[i][j][1]="N/A";
						scoreSummary[i][j][6]="N/A";
					}
					// Min value info
					// Populate columns 2 and 3 with min info
					scoreSummary[i][j][2] = maxMinInfo[i][2]; // Min value
					if (!(maxMinInfo[i][3].equals("N/A"))) {					
						// Parse list of max indices by comma delimiter
						indicesMinArrayStr = maxMinInfo[i][3].split(",");
						// convert string array to integer array
						int[] indicesMinValues = new int[indicesMinArrayStr.length];
						logger.trace("**** model # = " + i + " min array length = " +  indicesMinArrayStr.length + " category " + category[j] + "*******");
						for (int k=0;k<indicesMinArrayStr.length;k++) {
							indicesMinValues[k] = Integer.parseInt(indicesMinArrayStr[k]);
							// If this is the first min index, do not include a comma
							// in the scoreSummary string for min indices
							if(k == 0) {
								minReferenceString.append(referenceStringArray[indicesMinValues[k]]);
							}
							else {
							// If this is the second or greater min index, add reference info
							// comma delimited
								minReferenceString.append(",").append(referenceStringArray[indicesMinValues[k]]);
							}
							logger.trace(" min ref value = " + referenceStringArray[indicesMinValues[k]]);
						}
						// Get associated reference information associated with the max value
						scoreSummary[i][j][3] = minReferenceString.toString();
						scoreSummary[i][j][7] = String.valueOf(indicesMinArrayStr.length); // # of reference points that have the minimum value  indicesMinArrayStr.length
					}
					else {
						scoreSummary[i][j][3]="N/A";
						scoreSummary[i][j][7]="N/A";
					}

					// Get the average info 
					aveInfo[i] = MathLibrary.getAveValueInfo(scoreCatFloatArray[i][j]);
					// Populate columns 4 and 5 with average info 
					scoreSummary[i][j][4] = aveInfo[i][0];	// Average value
					scoreSummary[i][j][5] = aveInfo[i][1];	// # of values in average value calculation
					logger.debug("summary for model " + i + " category " + category[j] + " is : " + Arrays.toString(scoreSummary[i][j]));
				} // end loop over category
			} // End for loop over model
		} // End try 
		catch (ArrayIndexOutOfBoundsException e) {
			logger.error("Exception thrown, array out of bounds : " + e);
		}
		catch (Throwable e) {
			logger.error("Exception thrown from trying to get the score summary for each model : " + e);
		}
		return scoreSummary;
	}   // End getScoreSummary()

} // end StatsLibrary class
