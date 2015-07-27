package gov.noaa.ncep.cpc.stats;

// Import all packages needed
import gov.noaa.ncep.cpc.data.Data;
import gov.noaa.ncep.cpc.format.FormatLibrary;
import gov.noaa.ncep.cpc.qc.QCLibrary;
import gov.noaa.ncep.cpc.settings.Settings;
import gov.noaa.ncep.cpc.settings.SettingsHashLibrary;
import gov.noaa.ncep.cpc.qc.Log;

import java.util.Arrays;

import org.apache.log4j.Logger;

/**
 * Mini driver for the stats package, which deals with all logic for manipulating the
 * data depending on outputType and calculating the score depending on scoreType.
	* In general : The 'total' and 'separate' category scores are always calculated.
	The total categories score is always in the 0th index, then the 'B' (below average) is in the 1st index, 'N' (normal category) is in the 2nd index, and 'A' (above average) is in the 3rd category. Indices look like : [total][Below][Normal][Above].
 */
public class Stats {

	// Initialize variables
	// First dimension of these variables is model
	private float aveFloatArray[][][];      // contains average score and # of values making up ave for each model and cat
	private float scoreCatFloatArray[][][]; // dimensions are [model][category][day/location/bin] where category is (Total,B,N,A)
	private int goodDataCountArray[][][];     // number of valid fcst-ob pairs per score excluding any pair with a NaN, dimensions are [model][category][day/location/bin]
	private float goodDataPercentArray[][][]; // ratio of valid fcst-ob pairs per score excluding NaNs to the total # of fcst-ob pairs, dimensions are [model][category][day/location]
	private float aveFcstProbArray[][][];     // average forecast probability per category per bin for x axis plotting values for reliability diagram, dimensions are [model][category][bin]
        private int goodScoreCountArray[][];      // total number of scores per model and category for entire plot, dimensions are [model][cat]
        private float goodScorePercentArray[][];  // ratio of scores that passed qc to the total number of possible scores (based on number of dates (weekdays for ERF) or locations) for entire plot, dimensions are [model][cat]

	private int numExpectedFcstsPerScore[];    // dimension is [model], excludes weekends for ERF otherwise its the size of the forecast array opposite of the outputDimension, for total category only, not valid for reliability,
	private int numExpectedScores[];   // dimension is [model], excludes weekends for ERF, total category only for scores except reliability. This should not be used in case of reliability. reliability utilizes numExpectedDataPairsReliability
	private static Logger logger; // Initialize logger

	// The following 4 variables are for reliability diagram.
	// They are set near the beginning of calcStats.
  	private int bins;
  	private float[] probabilityBinLowerThreshold;
  	private float[] probabilityBinUpperThreshold;
 	 private float[] probabilityBinAxisLabels;
	private String[] probabilityBinLabels;

	// Minimum score values allowed in averages - When a skill score is lower than the specified
	// value, it gets set to the specified value before getting included in an average over space or
	// time. This is because some dry locations can have really negative Heidke Skill Scores, which
	// pollutes the long-term average skill scores.
	float minAllowedHeidkeValForAve = -50f;

	/**
	 * Sole constructor. Nothing needs to be passed to the constructor
	 * because the settings and data are all retrieved using get methods
	 * from the {@link Data Data class} and {@link Settings Settings class}.
	 */
	public Stats() {
		logger = Logger.getLogger(Stats.class.getName());
		logger.trace("Got logger for stats");
	}

	/**
	 * Uses logic to determine what quality control needs to be done, how to
	 * manipulate the data to calculate the score over the correct dimension, and
	 * calls the correct score calculation method.
	 * A score array is returned from this method that contains the score by model,
	 * category, time/location/probability bin.
	 * Score calculation methods are called from {@link StatsLibrary} depending on the scoreType.
	 * There is a qc method that checks the resulting scores for low quality, which
	 * can be set to remove scores that are derived from too few good data or contain a
	 * low percentage of good data.
	 * To retrieve values, call methods in this class such as
	 * getScoreCatFloatArray() and getScoreCatStringArray().
	 * QC stats can be retrieved by calling getGoodDataCountArray and getGoodDataPercentArray.
	 *
	 * @param dataObj      Data object from which to retrieve loaded data
	 * @param settingsObj  Settings object from which to retrieve the setting
	 */
	public void calcStats(Data dataObj, Settings settingsObj) throws Exception {
		logger.trace("In calcStats method");
		// Initialize variables
		float[][][][] fcstProb4d=null;  // These must be null since they are set inside if statements
		float[][][] fcstCat3d=null;
		float[][] obsCat2d=null;
		float[][] percentDry2d=null;
		float[][][] fcstProb3d;
		float[][] fcstCat2d;
		float[] obsCat1d=null;
		float[] percentDry1d=null;
		float[][] fcstProb2d=null;
		float[] fcstCat1d=null;
		int m;
		int r;
		int c;
		int p;
		String[] category = SettingsHashLibrary.getCategoryNames();
		String[] fcstSourceArray = settingsObj.getFcstSourceArray();
		String categoryType = settingsObj.getCategoryType();
		String scoreType = settingsObj.getScoreType();
		String ecType = settingsObj.getECType();
		// Get Reference array
		String[] refArray = dataObj.getReferenceArray();
		// Array of expected data pairs used for reliability QC. Doesnt get populated if not reliability
		int[][] numExpectedDataPairsReliability = new int[fcstSourceArray.length][4];

		int[] numExpectedDates = new int[fcstSourceArray.length];
		int[] numExpectedLocations = new int[fcstSourceArray.length];
		// # of dates and locations in the forecast data arrays
		int numDatesInData = 0;
		int numLocationsInData = 0;
		float[][][] numDataByCategory; // Array of number of points in each category (B,N,A,EC). By default is 0.0f except for noEC

		// Set arrays with correct dimensions depending on output dimension
		// For Time
		// fcstCat3d[model][time][location]
		// fcstProb4d[model][time][location][category]
		if (settingsObj.getOutputDimension().compareToIgnoreCase("time") == 0) {
			fcstProb4d=dataObj.getFcstProb();
			fcstCat3d=dataObj.getFcstCat();
			obsCat2d=dataObj.getObsCat();
			numDatesInData = fcstCat3d[0].length; // Num Dates
			numLocationsInData = fcstCat3d[0][0].length; // Num locations
			// Do this only if dry location correction is enabled
			if (settingsObj.getDryLocationCorrection()) {
				percentDry2d=dataObj.getPercentDry();
			}
		}
		// For probability
		// fcstCat3d[model][time][location]
		// fcstProb4d[model][time][location][category]
		// same dimensitions as above
		else if (settingsObj.getOutputDimension().compareToIgnoreCase("probability") == 0) {
			fcstProb4d=dataObj.getFcstProb();
			fcstCat3d=dataObj.getFcstCat();
			obsCat2d=dataObj.getObsCat();
			numDatesInData = fcstCat3d[0].length; // Num Dates
			numLocationsInData = fcstCat3d[0][0].length; // Num locations
		}
		// Switch dimensions of time and location for spatial map
		// For space
		// fcstCat3d[model][location][time]
		// fcstProb4d[model][location][time][probability]
		else if (settingsObj.getOutputDimension().compareToIgnoreCase("space") == 0) {
			fcstProb4d=switchDimensions4d(dataObj.getFcstProb());
			fcstCat3d=switchDimensions3d(dataObj.getFcstCat());
			obsCat2d=switchDimensions2d(dataObj.getObsCat());
			numDatesInData = fcstCat3d[0][0].length; // Num Dates
			numLocationsInData = fcstCat3d[0].length; // Num locations
			// Do this only if dry location correction is enabled
			if (settingsObj.getDryLocationCorrection()) {
				percentDry2d=switchDimensions2d(dataObj.getPercentDry());
			}
		}

		// Set the variables for reliability diagram that depend on forecast type
		// They are set based on fcstType since the bins differ depending on if there are EC forecasts or not.
		if (settingsObj.getScoreType().compareToIgnoreCase("reliability") == 0) {
			if (settingsObj.getFcstType().compareToIgnoreCase("extendedRange") == 0) {
				// There is no bin for EC
	    		bins = getBinsExtRange();
	    		probabilityBinLowerThreshold = getProbabilityBinLowerThresholdExtRange();
	    		probabilityBinUpperThreshold = getProbabilityBinUpperThresholdExtRange();
	    		probabilityBinAxisLabels = getProbabilityBinAxisLabelsExtRange();
                probabilityBinLabels = getProbabilityBinLabelsExtRange();
			}
			else if (settingsObj.getFcstType().compareToIgnoreCase("longRange") == 0) {
				// There is a separate bin for EC at .3333
				// The length of all these variables is one longer than the extended range version
	    		bins = getBinsLongRange();
	    		probabilityBinLowerThreshold = getProbabilityBinLowerThresholdLongRange();
	    		probabilityBinUpperThreshold = getProbabilityBinUpperThresholdLongRange();
	    		probabilityBinAxisLabels = getProbabilityBinAxisLabelsLongRange();
                probabilityBinLabels = getProbabilityBinLabelsLongRange();
			}
		}

		// Determine sizes of arrays
		// !! The second and third dims switch depending on whether it is space or time as output dimension!!
		// Second dimension should be the one with the reference points
		// see further above for dims
		m = fcstProb4d.length;
		r = fcstProb4d[0].length;  // 2nd dim (ref points)
		c = fcstProb4d[0][0].length;  //3rd dim
		p = fcstProb4d[0][0][0].length;
		logger.debug("prob array size m: " + m);
		logger.debug("prob array size r: " + r);
		logger.debug("prob array size c: " + c);
		logger.debug("prob array size p: " + p);

		int mm = fcstCat3d.length;
		int rr = fcstCat3d[0].length;
		int cc = fcstCat3d[0][0].length;
		logger.debug("fcst cat array size mm: " + mm);
		logger.debug("fcst cat array size rr: " + rr);
		logger.debug("fcst cat array size cc: " + cc);

		int rrr = obsCat2d.length;
		int ccc = obsCat2d[0].length;
		logger.debug("obs cat array size rrr: " + rrr);
		logger.debug("obs cat array size ccc: " + ccc);

		// Print out the forecast categories and probabilities for debugging
		for (int f=0; f<fcstProb4d.length; f++) {
			logger.trace("********* Fcst data for model fcst and obs data: " + f + " *************");
			for (int d=0; d<fcstProb4d[0].length; d++) {
				for (int l=0; l<fcstProb4d[0][0].length; l++) {
					//logger.trace("At [" + f + "][" + d + "][" + l + "]: fcstCat3d = " + fcstCat3d[f][d][l] + " and fcstProb4d = " + Arrays.toString(fcstProb4d[f][d][l]));
				}
			}
		}

		logger.debug("EC type = " + ecType);
		logger.debug("fcst type = " + settingsObj.getFcstType());

		///////////// EC QC Section ////////////////////////////////
		// [models][ref points][B,N,A,EC]
		numDataByCategory = new float[fcstCat3d.length][fcstCat3d[0].length][4];
		// Call Data method that counts # fcsts in each category to find out # that have EC
		// This MUST be done BEFORE removing zeros and replacing with NaN
		if (ecType.compareToIgnoreCase("noEC") == 0) {
			numDataByCategory = dataObj.getNumDataByCategory(fcstCat3d,settingsObj.getOutputDimension());
		}


		// QC that depends on the fcstType (includes removing EC forecasts if necessary)
		if ( settingsObj.getFcstType().compareToIgnoreCase("extendedRange") == 0) {
			// There should be no EC forecasts for extended range so zeros are bad data.
			// Remove probabilities (if score type uses them) corresponding to a forecast
			// category of zero and replace with NaN.
			if ( settingsObj.getScoreType().compareToIgnoreCase("rpss") == 0 || settingsObj.getScoreType().compareToIgnoreCase("brier") == 0||
			    settingsObj.getScoreType().compareToIgnoreCase("reliability") == 0) {
				fcstProb4d = QCLibrary.removeProbsForCatZero(fcstProb4d, fcstCat3d);
			}
			// Remove forecast categories of zero
			fcstCat3d = QCLibrary.removeZeros(fcstCat3d);
		} // end if for extended range
		else if ( settingsObj.getFcstType().compareToIgnoreCase("longRange") == 0) {
			if (ecType.compareToIgnoreCase("noEC") == 0) {
				logger.info("verifying nonEC fcsts only");
				// Remove probabilities (if score type uses them) corresponding to a forecast
				// category of zero and replace with NaN.
				if ( settingsObj.getScoreType().compareToIgnoreCase("rpss") == 0|| settingsObj.getScoreType().compareToIgnoreCase("brier") == 0 ||
					settingsObj.getScoreType().compareToIgnoreCase("reliability") == 0) {
					fcstProb4d = QCLibrary.removeProbsForCatZero(fcstProb4d, fcstCat3d);
				}
				// Remove forecast categories of zero and replace with NaN.
				fcstCat3d = QCLibrary.removeZeros(fcstCat3d);
			}
//			// Verifying all forecasts including EC
//			else if (ecType.compareToIgnoreCase("withEC") == 0) {
//				logger.info("verifying all fcsts including EC");
//				// EC fcst probs are set to .3333 prior to going in the database
//				// and are assumed to be correct.
//				// Note, EC forecasts remain untouched here for fcst sources on EC List.
//				// For other sources, EC fcsts (fcsts with low skill) or fcsts with erroneous
//				// zeros for a forecast category are removed.
//				String[] ecList = settingsObj.getLongRangeEcFcstSourceListArray();
//				int numFcstSources = fcstSourceArray.length;
//				int numEcSources = ecList.length;
//				logger.debug("ec list " + Arrays.toString(ecList));
//				logger.debug("fcst source array " + Arrays.toString(fcstSourceArray));
//				// Determine the indices of fcst sources that need EC forecasts removed.
//				for (int i=0; i<numFcstSources; i++) {
//					boolean onList = false;
//					for (int j=0; j<numEcSources; j++) {
//						if (fcstSourceArray[i].compareToIgnoreCase(ecList[j]) == 0) {
//							onList = true;
//							logger.debug(fcstSourceArray[i] + " is on ecList. Not removing zeros for index: " + i);
//							break;
//						}
//					} // end loop over EC source list
//					if (onList == false) {
//						logger.debug(fcstSourceArray[i] + " is not on ecList. Removing zeros for index: " + i);
//						// Remove probabilities corresponding to a forecast category of zero
//						// for fcst sources where EC (low skill) forecasts shouldn't be verified
//						// and replace with NaN.
//						fcstProb4d = QCLibrary.removeProbsForCatZero(fcstProb4d, fcstCat3d, i);
//						// Remove forecast categories of zero from those fcst sources and replace with NaN.
//						fcstCat3d = QCLibrary.removeZeros(fcstCat3d, i);
//					}
//				}
//			}
		} // end if for monthly or seasonal

		// Define arrays whose size doesn't depend on outputType
		fcstProb3d = new float[r][c][p];
		fcstCat2d = new float[r][c];
		goodScoreCountArray = new int[m][4];
		goodScorePercentArray = new float[m][4];

		// Define arrays based on number of models and number of probability bins
		// if output dimension is probability
		if (settingsObj.getOutputDimension().compareToIgnoreCase("probability") == 0) {
			logger.debug("number of bins: " + bins);
			scoreCatFloatArray = new float[m][4][bins];
			goodDataCountArray   = new int[m][4][bins];
			goodDataPercentArray   = new float[m][4][bins];
			aveFcstProbArray = new float[m][4][bins];
		}
		// Define arrays based on number of models and number of times or locations
		// for output dims other than probability (non-reliability scores)
		else {
			fcstProb2d = new float[c][p];
			fcstCat1d = new float[c];
			obsCat1d = new float[c];
			// Do this only if dry location correction is enabled
			if (settingsObj.getDryLocationCorrection()) {
				percentDry1d = new float[c];
			}
			scoreCatFloatArray = new float[m][4][r];
			goodDataCountArray   = new int[m][4][r];    // allocate memory
			goodDataPercentArray = new float[m][4][r];  // allocate memory
			aveFloatArray    = new float[m][4][2];      // allocate memory
			numExpectedFcstsPerScore = new int[m];
			numExpectedScores = new int[m]; // For most scores (except reliability) only use total category
		}

		//////////////////////////////////////////////////////////////////
		// For each forecast source:
		//   - Retrieve # expected dates and locations.
		//   - Save a value for each forecast source in arrays
		//////////////////////////////////////////////////////////////////
		for (int k=0; k<fcstSourceArray.length; k++) {
			logger.trace("k = " + k);
			logger.trace("fcsttype = " + settingsObj.getFcstType() + " fcstSource = " + fcstSourceArray[k]);
			// Get # expected dates. If the source ends with "manual", don't count weekend forecasts as missing
			if ( settingsObj.getFcstType().compareToIgnoreCase("extendedRange") == 0 && fcstSourceArray[k].matches("(.*_manual|manual)$")) {
				logger.trace("Only using # of weekdays for # expected dates to calculate % good scores (case fcstType='extendedRange' and fcstSource is manual or a tool ran off the manual (_manual).'");
				numExpectedDates[k] = dataObj.getNumWeekdays();
			}
			// else Get # expected dates for all other situations from the data object
			else {
				logger.trace("Number of expected dates uses all days (weekends and weekdays)");
				numExpectedDates[k] = dataObj.getNumUniqueFcstDates();
			}
			// Get # expected locations. If station, use reference table
			// NOTE: Melissa is going to assume to always use the reference table in the situation of spatialType = station.
			if ( settingsObj.getSpatialType().compareToIgnoreCase("station") == 0) {
				numExpectedLocations[k] = dataObj.getNumExpectedLocations(fcstSourceArray[k],settingsObj.getFcstType(),settingsObj.getVariable(),settingsObj.getSpatialType(),settingsObj.getRefDBName());
			}
			// else get # expected locations for non-stations (ie. gridded). This is used instead of a Data.java get method
			// because much of the location data is retrieved not based on returned data but purely from settings
			// looking at look up reference tables.
			else {
				numExpectedLocations[k] = numLocationsInData;
			}
			logger.debug("num expected dates: " + numExpectedDates[k] + " for model " + k);
			logger.debug("num expected locations: " + numExpectedLocations[k] + " for model " + k);
		}

		// Determine number of expected forecasts (used to calc percentage of valid data for each point
		// for score types other than reliability) that go into a score value (numExpectedFcstsPerScore)
		// and number of expected scores (used to calc % of valid qced scores over dates/location), which is the total # of scores
		// expected by the end of processing.
		// numExpectedScores is the # of total scores expected
		// numExpectedFcstsPerScore is for each reference array value (ie. if time is outputDimension, # of dates of scores expected at the end of processing)



		// For reliability calculate numExpefctedDataPairsReliability. for total category it is num dates * num locations * 3 where
		// num dates and num locations uses the logic above.
		// for separate category the qc method just use this value/3.
		// Only the total is actually used
		for (int k=0; k<fcstSourceArray.length; k++) {
			// Get num expected data pairs for each fcst source and cat [fcstSource][total,B,N,A]
			if (settingsObj.getScoreType().compareToIgnoreCase("reliability") == 0) {

				// Get numExpectedDataPairsReliability for separate categories (this would be used to assess each seprate category of data in the 'separate' category case)
				// or specified category (ie. above_normal) but this would typically not be used because data is required to all have the same # good data pairs for each category
				// If 'noEC' subtract # found EC values
				if (ecType.compareToIgnoreCase("noEC") == 0) {
					float numEC = 0;
					// Since EC data points would be for each ref point need to sum over all ref points to get total
					for (int i=0;i<numDataByCategory[0].length;i++) {
						numEC = numEC + numDataByCategory[k][i][3];
					}
					logger.trace("Total # EC points across date and location : " + numEC);
					// Get numExpectedDataPairsReliability for total category (# dates * # locations * 3 (total category)
					numExpectedDataPairsReliability[k][0] = ((numExpectedDates[k] * numExpectedLocations[k]) - (int) Math.round(numEC)) * 3;
					numExpectedDataPairsReliability[k][1] = (numExpectedDates[k] * numExpectedLocations[k]) - (int) Math.round(numEC);
					numExpectedDataPairsReliability[k][2] = (numExpectedDates[k] * numExpectedLocations[k]) - (int) Math.round(numEC);
					numExpectedDataPairsReliability[k][3] = (numExpectedDates[k] * numExpectedLocations[k]) - (int) Math.round(numEC);
					logger.trace("For fcst source " + fcstSourceArray[k]);
					logger.trace("For each of total cats (same for each) # expected data pairs = ((# expected dates * # expected locations) - # EC fcsts : " + numExpectedDataPairsReliability[k][0] + " = (" + numExpectedDates[k] + " * " + numExpectedLocations[k] + ") - " + (int) Math.round(numEC) + ") * 3");
					logger.trace("For each of separate cats (same for each) # expected data pairs = (# expected dates * # expected locations) - # EC fcsts : " + numExpectedDataPairsReliability[k][1] + " = (" + numExpectedDates[k] + " * " + numExpectedLocations[k] + ") - " + (int) Math.round(numEC));
				}
				// If 'withEC' just multiply # expected dates * # expected locations
				else if (ecType.compareToIgnoreCase("withEC") == 0) {
					// Get numExpectedDataPairsReliability for total category (# dates * # locations * 3 (total category)
					numExpectedDataPairsReliability[k][0] = numExpectedDates[k] * numExpectedLocations[k] * 3;
					numExpectedDataPairsReliability[k][1] = numExpectedDates[k] * numExpectedLocations[k];
					numExpectedDataPairsReliability[k][2] = numExpectedDates[k] * numExpectedLocations[k];
					numExpectedDataPairsReliability[k][3] = numExpectedDates[k] * numExpectedLocations[k];
					logger.trace("For fcst source " + fcstSourceArray[k]);
					logger.trace("For each of total cats (same for each) # expected data pairs = (# expected dates * # expected locations) * 3: " + numExpectedDataPairsReliability[k][0] + " = (" + numExpectedDates[k] + " * " + numExpectedLocations[k] + ") * 3");
					logger.trace("For each of separate cats (same for each) # expected data pairs = # expected dates * # expected locations : " + numExpectedDataPairsReliability[k][1] + " = " + numExpectedDates[k] + " * " + numExpectedLocations[k]);
				}
				// Else not a valid ecType option
				else {
					logger.fatal("Invalid ecType (Can either be 'withEC' or 'noEC'): " + ecType + " . End calculating numExpectedDataPairsReliability");
					Log.fatal("Report invalid 'EC Type'.","#errorPanelText");
					throw new Exception("Invalid ecType (Can either be 'withEC' or 'noEC'): " + ecType + " .End calculating numExpectedDataPairsReliability");
				}
			}
			// For all other scores that are not reliability, the numExpectedFcstsPerScore should be in the opposite dimension that outputDimension
			else {
				// If dimension is space, # expected forecasts per score should be # dates of forecasts that make up score
				// and # expected scores should be # expected locations
				if (settingsObj.getOutputDimension().compareToIgnoreCase("space") == 0) {
					numExpectedFcstsPerScore[k] = numExpectedDates[k];
					numExpectedScores[k]= numExpectedLocations[k];
				}
				// If dimension is time, # expected forecasts per score should be # locations that make up score
				// and # expected scores should be # expected dates
				else if (settingsObj.getOutputDimension().compareToIgnoreCase("time") == 0) {
					numExpectedFcstsPerScore[k] = numExpectedLocations[k];
					numExpectedScores[k]= numExpectedDates[k];
				}
				// If it is not the reliability score, but dimension is neither space or time, invalid output dimension
				else {
					logger.fatal("Invalid outputDimension: " + settingsObj.getOutputDimension() + " . No way of getting # expected fcsts per score or # expected scores");
					Log.fatal("Invalid output dimension for score. Unable to perform QC.","#errorPanelText");
					throw new Exception("Invalid output dimension for score. Unable to perform QC.");
				}
				logger.debug("num expected fcsts per score: " + numExpectedFcstsPerScore[k] + " for fcst source " + k);
				logger.debug("num expected scores: " + numExpectedScores[k] + " for fcst source " + k);
			} // end if not reliability


		} // End fcst source loop
		// Calculate score section
		/////////////////////////////////////////////
		// Loop over each model and extract time and location info and put into a temporary array one dimension smaller
		for (int k=0; k<m; k++) {
			// QC method is called for each day or location and returns a 1-d array (2 values)
			// of # of good fcst-obs pairs and percentage of good fcst-ob pairs
			// corresponding to the scores.  It also does qc by category and total.
			// A separate version of the method is called for dry location correction that counts
			// fcst-ob-percentDry pairs.

			// Create temporary arrays for fcst cat and prob for the current model
			for (int i=0; i<r; i++) {
				for (int j=0; j<c; j++) {
					fcstCat2d[i][j] = fcstCat3d[k][i][j];
					for (int l=0; l<p; l++) {
						fcstProb3d[i][j][l] = fcstProb4d[k][i][j][l];
					}
				}
			}

			// Calculate score over time and space together for scores that have probability
			// as the output dimension, for example reliability scores.
			// goodDataCountArray dims are [model][category][probability bin]
			if (settingsObj.getScoreType().compareToIgnoreCase("reliability") == 0) {
				// ecType is set depending on fcstType for this score by settings class
				if (ecType.compareToIgnoreCase("noEC") == 0) {
					scoreCatFloatArray[k] = StatsLibrary.calcReliabilityNoEc(fcstProb3d, obsCat2d, probabilityBinLowerThreshold, probabilityBinUpperThreshold, bins);
					goodDataCountArray[k] = QCLibrary.countGoodDataPairsReliabilityNoEc(fcstProb3d, obsCat2d, probabilityBinLowerThreshold, probabilityBinUpperThreshold, bins);
				}
				else {
					scoreCatFloatArray[k] = StatsLibrary.calcReliabilityWithEc(fcstProb3d, fcstCat2d, obsCat2d, probabilityBinLowerThreshold, probabilityBinUpperThreshold, bins);
					goodDataCountArray[k] = QCLibrary.countGoodDataPairsReliabilityWithEc(fcstProb3d, fcstCat2d, obsCat2d, probabilityBinLowerThreshold, probabilityBinUpperThreshold, bins);
				}
				// calc ave prob per bin for x axis values
				aveFcstProbArray[k] = StatsLibrary.calcAverageProbability(fcstProb3d, obsCat2d, probabilityBinLowerThreshold, probabilityBinUpperThreshold, bins);
			}
			else {  // For non-probability dimension scores
				// Calculate score for the 2nd dimension (time or space depending on how arrays were loaded at the beginning of this method using the outputDimension)

				// For cat 2-D, arrays are broken down into 1-D arrays 1 day or location at a time
				// For prob 3-D, arrays are broken down into 2-D arrays 1 day or location at a time
				for (int i=0; i<r; i++) {
					for (int j=0; j<c; j++) { // For each of reference points
						fcstCat1d[j] = fcstCat2d[i][j];
						obsCat1d[j] = obsCat2d[i][j];
						// Do this only if dry location correction is enabled
						if (settingsObj.getDryLocationCorrection()) {
							percentDry1d[j] = percentDry2d[i][j];
						}
						for (int l=0; l<p; l++) {
							fcstProb2d[j][l] = fcstProb3d[i][j][l];
						}
					}
					// Calculate score over 1-d depending on score type
					// Score is put into an array based on # of models and day or location
					float[] tmpScore = new float[4];    // temp array for heidke and Brier scores by category
					if (settingsObj.getScoreType().compareToIgnoreCase("heidke") == 0) {
						if (ecType.compareToIgnoreCase("noEC") == 0 && !(settingsObj.getDryLocationCorrection()) ) {
							tmpScore=StatsLibrary.calcHeidkeNoEc(fcstCat1d, obsCat1d,settingsObj.getVariable());
						}
						// use dry station correction for heidke if applicable
						else if (ecType.compareToIgnoreCase("noEC") == 0 && settingsObj.getDryLocationCorrection() ) {
							tmpScore=StatsLibrary.calcHeidkeNoEcDryLocationCorrection(fcstCat1d, obsCat1d, percentDry1d);
						}
						else if (ecType.compareToIgnoreCase("withEC") == 0) {
							tmpScore=StatsLibrary.calcHeidkeWithEc(fcstCat1d, obsCat1d);
						}
						scoreCatFloatArray[k][0][i] = tmpScore[0];  // all categories
						scoreCatFloatArray[k][1][i] = tmpScore[1];  // for Below
						scoreCatFloatArray[k][2][i] = tmpScore[2];  // for Normal
						scoreCatFloatArray[k][3][i] = tmpScore[3];  // for Above
					} // end heidke if
					else if (settingsObj.getScoreType().compareToIgnoreCase("rpss") == 0) {
						// ecType is set to withEC for this score by settings class
						scoreCatFloatArray[k][0][i] = StatsLibrary.calcRpss(fcstProb2d, obsCat1d);
						// It doeqcsn't make statistical sense to calc rpss by category,
						// this is why we do Brier scores.  Set score by categories to NaNs.
						scoreCatFloatArray[k][1][i] = Float.NaN;
						scoreCatFloatArray[k][2][i] = Float.NaN;
						scoreCatFloatArray[k][3][i] = Float.NaN;
					} // end rpss if
					else if (settingsObj.getScoreType().compareToIgnoreCase("brier") == 0) {
						// ecType is set to noEC for this score by settings class
							tmpScore=StatsLibrary.calcBrier(fcstCat1d, fcstProb2d, obsCat1d);
							scoreCatFloatArray[k][0][i] = tmpScore[0];  // weighted category ave
							scoreCatFloatArray[k][1][i] = tmpScore[1];  // BrierSS for Below
							scoreCatFloatArray[k][2][i] = tmpScore[2];  // BrierSS for Normal
							scoreCatFloatArray[k][3][i] = tmpScore[3];  // BrierSS for Above
					} // end brier if


					// QC method is called for each day or location and returns a 1-d array (2 values)
					// of # of good fcst-obs pairs and percentage of good fcst-ob pairs
					// corresponding to the scores.  It also does qc by category and total.
					// A separate version of the method is called for dry location correction that counts
					// fcst-ob-percentDry pairs.
					float[][] tmpStats = new float[4][2]; // temp array for count and percent by category
					if ( !(settingsObj.getDryLocationCorrection()) ) {
						tmpStats=QCLibrary.countGoodDataPairs(fcstCat1d, obsCat1d, numExpectedFcstsPerScore[k],numDataByCategory[k][i][3],ecType);
					}
					// use dry station correction if applicable. See settingsObj.getDryLocationCorrection documentation for more info
					else if (settingsObj.getDryLocationCorrection() ) {
						tmpStats=QCLibrary.countGoodDataPairsDryCorrection(fcstCat1d, obsCat1d, percentDry1d, numExpectedFcstsPerScore[k],numDataByCategory[k][i][3],ecType);
					}

					// Output is put into an array based on # of models and day or location
					goodDataCountArray[k][0][i] = (int) tmpStats[0][0];  // count for all cats
					goodDataPercentArray[k][0][i] = tmpStats[0][1];      // percent for all cats
					logger.trace("For total category model " + k + " Percent good data is : " + goodDataPercentArray[k][0][i]);

					// Get good data counts and percents for scores except RPSS
					if (!(settingsObj.getScoreType().compareToIgnoreCase("rpss") == 0)) {
						goodDataCountArray[k][1][i] = (int) tmpStats[1][0];  // count for B
						goodDataCountArray[k][2][i] = (int) tmpStats[2][0];  // count for N
						goodDataCountArray[k][3][i] = (int) tmpStats[3][0];  // count for A
						goodDataPercentArray[k][1][i] = tmpStats[1][1];      // percent for B
						goodDataPercentArray[k][2][i] = tmpStats[2][1];      // percent for N
						goodDataPercentArray[k][3][i] = tmpStats[3][1];      // percent for A
						logger.trace("For category " + category[1] + ", Num good data for day/location " + refArray[i] + " = " +  goodDataCountArray[k][1][i]);
						logger.trace("For category " + category[2] + ", Num good data for day/location " + refArray[i] + " = " +  goodDataCountArray[k][2][i]);
						logger.trace("For category " + category[3] + ", Num good data for day/location " + refArray[i] + " = " +  goodDataCountArray[k][3][i]);
					}
					// If RPSS set counts to 0, percents to NaN since there are no scores by category for RPSS
					else {
						goodDataCountArray[k][1][i] = 0;
						goodDataPercentArray[k][1][i] = Float.NaN;
						goodDataCountArray[k][2][i] = 0;
						goodDataPercentArray[k][2][i] = Float.NaN;
						goodDataCountArray[k][3][i] = 0;
						goodDataPercentArray[k][3][i] = Float.NaN;
					}
				} // end for i loop for 1-d calculations
			} // end else loop for both non-probability output dimension based stats
		} // end k loop over models

		//for (int k=0; k<m; k++) {
		//	for (int i=0; i<goodDataCountArray(0).length;i++) {
		//		logger.trace("cat " + k + ", Num good data for each output dim " + goodDataCountArray[k] );
		//	}
		//}

		logger.debug("Rounding all arrays...");

		//////////////////////////////////////////////////////////////////////////////
		////// QC 1 Section - QC Each Score for Quality of Data //////////////////////
		///////(valid non-NaN fcst-obs, or fcst-obs-dryStation data pairs) ///////////
		//////////////////////////////////////////////////////////////////////////////

		// Round score array
		if (settingsObj.getScoreType().compareToIgnoreCase("heidke") == 0 || settingsObj.getScoreType().compareToIgnoreCase("reliability") == 0) {
			scoreCatFloatArray = FormatLibrary.roundToDecimal(scoreCatFloatArray,2);
		}
		else if (settingsObj.getScoreType().compareToIgnoreCase("rpss") == 0 || settingsObj.getScoreType().compareToIgnoreCase("brier") == 0) {
			scoreCatFloatArray = FormatLibrary.roundToDecimal(scoreCatFloatArray,3);
		}

		// For scores other than reliability:
		if (!(settingsObj.getScoreType().compareToIgnoreCase("reliability") == 0)) {
			// Round percent array (no percentage of good data for reliability diagrams)
          		goodDataPercentArray = FormatLibrary.roundToDecimal(goodDataPercentArray,2);
			// QC individual scores by datapoint
			// Remove scores with good data percent below specified threshold (too few fcst-ob pairs per time/location)
			scoreCatFloatArray = QCLibrary.removeScoresWithLowQuality(settingsObj, this, dataObj);
		}

		// For reliability, there is no qc for individual scores (bins) - it is done on all bins together in one QC (QC 2) below
		if (settingsObj.getScoreType().compareToIgnoreCase("reliability") == 0) {
			// Round average forecast probability array (only exists for reliability diagram)
			aveFcstProbArray = FormatLibrary.roundToDecimal(aveFcstProbArray,2);
		}

		////// QC 2 Section - QC Over All Scores ////////////////////////
		// QC all scores as a whole for all score data
		/////////////////////////////////////////////////////////////////////
		// For reliability
		// calculate % of good fcst-obs data pairs (over time, space, and category) for reliability
		//  Remove all scores for all probability bins for all categories (total,B,N, or A)
		// if the total category did not pass QC
		// that did not pass the threshold score
		if (settingsObj.getScoreType().compareToIgnoreCase("reliability") == 0) {
			float[][] goodDataCountArray2d = new float[m][4]; // [fcst source] [category total,b,n,a]

			// Count total count of good data pairs over all probability bins [model][category], use the goodDataCountArray to transform to 2-d
			// For each model and category, add # good data pairs from all the probability bin

			for (int i=0; i< goodDataCountArray.length; i++) { // each model
				for (int j=0; j< goodDataCountArray[0].length; j++) { // each cat
					for (int k=0; k< goodDataCountArray[0][0].length; k++) { // each bin
						if (k == 0) { // If first bin, set to first value
							goodDataCountArray2d[i][j] = goodDataCountArray[i][j][0];
						}
						else {
							goodDataCountArray2d[i][j] = (float) goodDataCountArray2d[i][j] + goodDataCountArray[i][j][k];
						}
					}
				logger.trace("For model index " + i + " category index " + j + " # good data is " + goodDataCountArray2d[i][j]);
				}

			}

			// For each model
			// Put # and % good data pairs for total. Separate cats would have same values for counts and % since
			// as each other because of data processing. Only assessing based on total but values are included in separate cats anyways even though not
			// expected to be used.
			for (int i=0; i<m; i++) {
				// Total count and %
				// This is not really the count of scores, really count of data points (fcst-obs pairs)
				goodScoreCountArray[i][0] = (int) goodDataCountArray2d[i][0]; // count all cats
				goodScorePercentArray[i][0] = goodDataCountArray2d[i][0]/numExpectedDataPairsReliability[i][0]  * 100;  // percent for all cats
				goodScoreCountArray[i][1] = (int) goodDataCountArray2d[i][1]; // count for B
				goodScorePercentArray[i][1] = goodDataCountArray2d[i][1]/numExpectedDataPairsReliability[i][1]  * 100;  // percent for B (this is NaN)
				goodScoreCountArray[i][2] = (int) goodDataCountArray2d[i][2];   // count for N
				goodScorePercentArray[i][2] = goodDataCountArray2d[i][2]/numExpectedDataPairsReliability[i][2]  * 100;  // percent for N (this is NaN)
				goodScoreCountArray[i][3] = (int) goodDataCountArray2d[i][3];  // count for A
				goodScorePercentArray[i][3] = goodDataCountArray2d[i][3]/numExpectedDataPairsReliability[i][3]  * 100; // percent for A (this is NaN)
				logger.trace("for Total cats: # good data pairs (total cat) / # expected data pairs * 100 = " + goodScoreCountArray[i][0] + " / " + numExpectedDataPairsReliability[i][0]  +  " * 100 = " + goodScorePercentArray[i][0]);
				logger.trace("for separate cats (each): # good data pairs (total cat): " + goodScoreCountArray[i][1] + " / " + numExpectedDataPairsReliability[i][1]  +  " * 100 = " + goodScorePercentArray[i][1]);
			}
			// Remove all scores if below QC Threshold
			scoreCatFloatArray = QCLibrary.removeAllScoresIfBelowQCThreshold(scoreCatFloatArray,goodScorePercentArray,scoreType);
		} // End if reliability
		// For all other scores (non-reliability)
		else {
			float[][][] tmpStats = new float[m][4][2]; // temp array for count and percent by category per model
			// tmpStats includes both the good score count and percent (3rd dimension)
                	tmpStats=QCLibrary.getCountGoodScores(scoreCatFloatArray, numExpectedScores, settingsObj);
			// Create array containing counts and percent of good scores for all cats
			for (int k=0; k<m; k++) {
				goodScoreCountArray[k][0] = (int) tmpStats[k][0][0];  // count for all cats
                		goodScorePercentArray[k][0] = tmpStats[k][0][1] * 100;  // percent for all cats
                		goodScoreCountArray[k][1] = (int) tmpStats[k][1][0];  // count for B
                		goodScorePercentArray[k][1] = tmpStats[k][1][1] * 100;  // percent for B (this is NaN)
                		goodScoreCountArray[k][2] = (int) tmpStats[k][2][0];  // count for N
                		goodScorePercentArray[k][2] = tmpStats[k][2][1] * 100;  // percent for N (this is NaN)
                		goodScoreCountArray[k][3] = (int) tmpStats[k][3][0];  // count for A
                		goodScorePercentArray[k][3] = tmpStats[k][3][1] * 100;  // percent for A (this is NaN)
			}
			// Round good score percent array
			goodScorePercentArray = FormatLibrary.roundToDecimal(goodScorePercentArray,2);

			// Remove all scores if percentage of scores is below good data percent threshold
			// Valid for total category only, scores by category left as is.
			// As a result, plots for total category may be blank, and plots for separate categories
			// will have all scores that pass qc for that category.
			// Note, the static plots do total category QC independently. They are
			// set up to not create any plots if the number of scores is too low by reading the
			// percent of good scores printed in the ascii file heading.
			scoreCatFloatArray = QCLibrary.removeAllScoresIfBelowQCThreshold(scoreCatFloatArray,goodScorePercentArray,scoreType);
		}

		///////// end score QC section ////////////////////

		///////// score stats section //////////////////////
		//
		// Calculate stats for each model
		// Calculate max and min and the index of these values
		// Note, this is done somewhere else, although it probably makes more sense to do it here
		// like what is done for calculating the average.

		// Calculate the average score for each model and the # of values making up average
		// Skip reliability, it doesn't make sense to do this
		if (!(settingsObj.getScoreType().compareToIgnoreCase("reliability") == 0)) {
			// If heidke, use minAllowedHeidkeValForAve as the min value allowed
			if (settingsObj.getScoreType().compareToIgnoreCase("heidke") == 0) {
				aveFloatArray = MathLibrary.calcAveValue(scoreCatFloatArray,minAllowedHeidkeValForAve);
			}
			// Otherwise just use -9999
			else {
				aveFloatArray = MathLibrary.calcAveValue(scoreCatFloatArray,-9999f);
			}
		}
		///////// end score stats section ////////////////////

		// Print scores and score stats for each model
		for (int i=0; i<m; i++) {
		for (int n=0; n<scoreCatFloatArray[0].length;n++) {
			logger.trace("scoreCatFloatArray, model " + i + ", category " + category[n] + Arrays.toString(scoreCatFloatArray[i][n]));
			logger.trace("goodDataCountStringArray, model " + i + ", category " + category[n] + Arrays.toString(getGoodDataCountArray()[i][n]));
			// Print good data percent
			// Print average score for each model and number of scores making up average
			// There is no good data percent or average score for reliability
			if (!(settingsObj.getScoreType().compareToIgnoreCase("reliability") == 0)) {
				logger.trace("goodDataPercentStringArray, model " + i + ", category " + category[n] + Arrays.toString(goodDataPercentArray[i][n]));
				logger.debug("average score and number of values in ave, model " + i + ", category " + category[n] + Arrays.toString(aveFloatArray[i][n]));
				// Print counts and percents for all scores together for entire plot
				logger.debug("model " + i + ", category " + category[n] + ", score count " + getGoodScoreCountArray()[i][n] + ", score percent " + getGoodScorePercentArray()[i][n]);
			}
			// Print average forecast probability array for reliability
			// This only exists for reliability
			else {
				logger.debug("aveFcstProbArray, model " + i + ", category " + category[n] + Arrays.toString(getAveFcstProbArray()[i][n]));
				// Print counts for all scores together for entire plot
				logger.debug("model " + i + ", category " + category[n] + ", score count " + getGoodScoreCountArray()[i][n]);
			}
		}
		} // end for
	} // end calcStats

	/**
	* Switches the second and third dimensions of a 4d array
	*
	* @param f 4-d float array
	* @return 4-d float array
	*/
	public float[][][][] switchDimensions4d(float[][][][] f) {
		logger = Logger.getLogger(Stats.class.getName());
		logger.debug("inside switchDimensions 4d");

		int m = f.length;
		int r = f[0].length;
		int c = f[0][0].length;
		int p = f[0][0][0].length;
		float[][][][] fs = new float[m][c][r][p];

		for (int k=0;k<m;k++) {
			for (int i=0;i<r;i++) {
				for (int j=0;j<c;j++) {
					for (int l=0;l<p;l++) {
						fs[k][j][i][l]=f[k][i][j][l];
					}
				}
			}
		}
		return fs;
	}

	/**
	* Switches the second and third dimensions of a 3d array
	*
    * @param f 3-d float array
	* @return 3-d float array
	*/
	public float[][][] switchDimensions3d(float[][][] f) {
		logger = Logger.getLogger(Stats.class.getName());
		logger.debug("inside switchDimensions 3d");

		int m = f.length;
		int r = f[0].length;
		int c = f[0][0].length;
		float[][][] fs = new float[m][c][r];

		for (int k=0;k<m;k++) {
			for (int i=0;i<r;i++) {
				for (int j=0;j<c;j++) {
					fs[k][j][i]=f[k][i][j];
				}
			}
		}
		return fs;
	}


	/**
		* Switches the first and second dimensions of a 2d array
	*
	* @param f 2-d float array
	* @return 2-d float array
		*/
		public float[][] switchDimensions2d(float[][] f) {
			logger = Logger.getLogger(Stats.class.getName());
			logger.debug("inside switchDimensions 2d");

			int m = f.length;
			int r = f[0].length;
			float[][] fs = new float[r][m];
			for (int k=0;k<m;k++) {
				for (int i=0;i<r;i++) {
					fs[i][k]=f[k][i];
				}
			}
			return fs;
		}


	////////////////////////////////////////
	// Get methods to return score related data
	//

	/**
	* Returns the average score for each model and category and the number of values
	* making up each average as a float.
	* This is not valid for reliability diagram.
	* The dimensions are [model][category][ave info] where the
	* first index of ave info is the average and the second index of ave
	* info is the number of values making up the average.
	* The category order is Total,B,N,A.
 The 'total' and 'separate' category scores are always calculated.
	The total categories score is always in the 0th index, then the 'B' (below average) is in the 1st index, 'N' (normal category) is in the 2nd index, and 'A' (above average) is in the 3rd category. Indices look like : [total][Below][Normal][Above].
	*
	* @return  3-d float array of average score
	*/
	public float[][][] getAveFloatArray() {
		return aveFloatArray;
	}

	/**
	* Returns the score calculated over 1 dimension for each model, category, and day or location as a float.
	* Scores exclude any pair with a NaN.
	* Dimensions are [model][category][day/location/bin] where category is Total,B,N,A.
 The 'total' and 'separate' category scores are always calculated.
	The total categories score is always in the 0th index, then the 'B' (below average) is in the 1st index, 'N' (normal category) is in the 2nd index, and 'A' (above average) is in the 3rd category. Indices look like : [total][Below][Normal][Above].
	*
	* @return  3-d float array of score
	*/
	public float[][][] getScoreCatFloatArray() {
		if ((scoreCatFloatArray) == null) {
			logger.warn("scoreCatFloatArray is NULL!");
		}
		return scoreCatFloatArray;
	}

	/**
	* Calls {@link #getScoreCatFloatArray}, converts scoreCatFloatArray to a string,
	* and returns the score calculated over 1 dimension for each model, category, and day
	* or location as a String.
	* Scores exclude any pair with a NaN.
    * Dimensions are [model][category][day/location/bin] where category is Total,B,N,A.
 The 'total' and 'separate' category scores are always calculated.
	The total categories score is always in the 0th index, then the 'B' (below average) is in the 1st index, 'N' (normal category) is in the 2nd index, and 'A' (above average) is in the 3rd category. Indices look like : [total][Below][Normal][Above].
	*
	* @return  3-d string array of score
	*/
	public String[][][] getScoreCatStringArray() {
	  if (getScoreCatFloatArray() == null)
	  {
	    return null;
	  }
		return FormatLibrary.toStringArray(getScoreCatFloatArray() );
	}

	/**
	 Returns the number of fcst-ob pairs used in score calculation.
	 This is the number of forecast-observation pairs excluding any pair with a NaN.
     Dimensions are [model][category][day/location] where category is Total,B,N,A.
	 The 'total' and 'separate' category scores are always calculated.
	The total categories score is always in the 0th index, then the 'B' (below average) is in the 1st index, 'N' (normal category) is in the 2nd index, and 'A' (above average) is in the 3rd category. Indices look like : [total][Below][Normal][Above].

	 @return	3-d integer array of number of fcst-ob pairs excluding NaNs
	*/
	public int[][][] getGoodDataCountArray() {
		return goodDataCountArray;
	}

	/**
	 Calls {@link #getGoodDataCountArray}, converts goodDataCountArray to a string,
	 and returns the number of fcst-ob pairs used on score calculation as a String.
	 This is the number of forecast-observation pairs excluding any pair with a NaN.
	 Dimensions are [model][category][day/location] where category is Total,B,N,A.
	 The 'total' and 'separate' category scores are always calculated.
	 The total categories score is always in the 0th index, then the 'B' (below average) is in the 1st index, 'N' (normal category) is in the 2nd index, and 'A' (above average) is in the 3rd category. Indices look like : [total][Below][Normal][Above].

	 @return  3-d string array of number of fcst-ob pairs excluding NaNs
	*/
	public String[][][] getGoodDataCountStringArray() {
	  if (getGoodDataCountArray() == null)
	  {
	    return null;
	  }
		return FormatLibrary.toStringArray(getGoodDataCountArray() );
	}

	/**
	 * Returns the ratio of fcst-ob pairs used in score calculation to total fcst-ob pairs.
	 * This is filled with NaNs for reliability diagrams (it is not possible to calculate).
i	* The probabilities are based on the total number of forecasts and
        * are only less than 100% if an observation is missing. These values are calculated in
        * QCLibrary.countGoodDataPairs based on the number of forecasts for each category and are put
        * into goodDataPercentArray for separate categories.
	 * These forecast-observation pairs exclude any pair with a NaN.
     * Dimensions are [model][category][day/location] where category is Total,B,N,A.
 The 'total' and 'separate' category scores are always calculated.
	The total categories score is always in the 0th index, then the 'B' (below average) is in the 1st index, 'N' (normal category) is in the 2nd index, and 'A' (above average) is in the 3rd category. Indices look like : [total][Below][Normal][Above].
	 *
	 * @return	3-d float array of percentage of fcst-ob pairs used to total fcst-ob pairs
	 */
	public float[][][] getGoodDataPercentArray() {
		return goodDataPercentArray;
	}

        /**
         * Returns the number of scores that passed quality control (if not reliability) OR the # of good (non-NaN) fcst-obs data pairs (reliability).
         * Dimensions are [model][category] where category is Total,B,N,A.
         * The 'total' and 'separate' category scores are always calculated.
         * The total categories score is always in the 0th index, then the 'B' (below average) is in the 1st index, 'N' (normal category) is in the 2nd index, and 'A' (above average) is in the 3rd category. Indices look like : [total][Below][Normal][Above].
         *
         * @return    2-d int array of number of "good" scores (non NaN scores) in dimension [fcst Source][total,B,N,A]
         */
        public int[][] getGoodScoreCountArray() {
                return goodScoreCountArray;
        }

        /**
         * Returns the percent of scores that passed quality control (non-reliability) OR the % of good (non-NaN) fcst-obs data pairs (reliability).  Number of expected used in the calculation is based on the # number of forecasts or # dates (# weekdays for ERF manual) for non-reliability scores, or based on # forecasts * # dates (* 3 categories) assessing all the fcst-obs pairs data used in the score calculation for reliability scores.
	 * For separate categories for non-reliability scores the percents are 'NaN's since the expected # of good scores are assumed to be unknown. For reliability, values are inserted for separate categories, but they would be the same to each other and total. Total is the only category used in all QC scores assessment.
         * Dimensions are [model][category] where category is Total,B,N,A.
         *
         * @return    2-d float array of percentage of # good scores to # expected scores  in dimension [fcst Source][total,B,N,A]
         */
        public float[][] getGoodScorePercentArray() {
                return goodScorePercentArray;
        }

	/**
	* Returns the number of expected forecasts per score for each model for the total category.
	* It excludes weekends for ERF for outputDimension of space, otherwise it assumes each day has a forecast
	* for outputDimensions of space.
	* For outputDimension of time, it is the number of locations. It assumes all locations have a
	* forecast each forecast time.
	* Not valid for reliability diagram. It is not possible to know the probability for each bin
 	* before the forecast is made.
	* For separate categories, the number of forecasts for each of the categories is not known before
	* the forecast is made.
	*
	* @return 1-d int array of number of expected forecasts per score for each model
	*/
	public int[] getNumExpectedFcstsPerScore() {
		return numExpectedFcstsPerScore;
	}

	/**
	* Returns the number of expected scores for each model for the total category.
	* It excludes weekends in the number for ERF manual for outputDimension of time, otherwise it assumes each day has a forecast
	* for outputDimension of time.
	* For outputDimension of space, it is the number of locations. It assumes all locations have a
	* forecast each forecast time.
	*
	* @return 1-d int array of number of expected scores per model
	*/
	public int[] getNumExpectedScores() {
		return numExpectedScores;
	}

	/**
	Returns the average forecast probability per model, category, and bin for reliability diagram.
	This does not exist for score types other than reliability diagram.
    Averages exclude any pair with a NaN.
	Dimensions are [model][category][day/location/bin] where category is Total,B,N,A.
	The 'total' and 'separate' category scores are always calculated.
	The total categories score is always in the 0th index, then the 'B' (below average) is in the 1st index, 'N' (normal category) is in the 2nd index, and 'A' (above average) is in the 3rd category. Indices look like : [total][Below][Normal][Above].
	* @return  3-d float array of ave fcst prob
	*/
	public float[][][] getAveFcstProbArray() {
		return aveFcstProbArray;
	}

	/**
	Calls {@link #getAveFcstProbArray}, converts aveFcstProbArray to a string, and returns
	the average forecast probability per model, category, and bin for reliability diagram as a String.
	This does not exist for score types other than reliability diagram.
	Averages exclude any pair with a NaN.
	Dimensions are [model][category][day/location/bin] where category is Total,B,N,A.
	The 'total' and 'separate' category scores are always calculated.
	The total categories score is always in the 0th index, then the 'B' (below average) is in the 1st index, 'N' (normal category) is in the 2nd index, and 'A' (above average) is in the 3rd category. Indices look like : [total][Below][Normal][Above].
	* @return  3-d String array of ave fcst prob
	*/
	public String[][][] getAveFcstProbStringArray() {
	  if (getAveFcstProbArray() == null)
	  {
	    return null;
	  }
		return FormatLibrary.toStringArray(getAveFcstProbArray() );
	}

    /**
    * Returns the number of probability threshold bins for extended range forecasts
	* used for reliability diagram.
	* This version of this method must be used if program has not yet run through
	* the section that sets the reliability diagram variables depending on
	* forecast type (near the beginning of calcStats), otherwise use getBins().
    *
    * @return integer of number of bins
    */
    public static int getBinsExtRange() {
		int bins = 10;
        return bins;
    }
	/**
	* Returns the number of probability threshold bins for long range forecasts
	* used for reliability diagram.
	* This version of this method must be used if program has not yet run through
	* the section that sets the reliability diagram variables depending on
	* forecast type (near the beginning of calcStats), otherwise use getBins().
	*
	* @return integer of number of bins
	*/
	public static int getBinsLongRange() {
		int bins = 11;
		return bins;
	}
	/**
	* Returns the number of probability threshold bins used for reliability diagram.
	* This version of this method can be used if program has already run through
	* the section that sets the reliability diagram variables depending on
	* forecast type (near the beginning of calcStats), otherwise use
	* getBinExtRange() or getBinsLongRange().
	*
    * @return integer of number of bins
	*/
	public int getBins() {
		return bins;
	}

    /**
    * Returns the lower limit probability bin threshold values of the bins
	* for extended range forecasts used for reliability diagram.
	* The length must be the same as the corresponding number of bins.
	* This version of this method must be used if program has not yet run through
	* the section that sets the reliability diagram variables depending on forecast
	* type (near the beginning of calcStats), otherwise use getProbabilityBinLowerThreshold().
    *
    * @return 1-d float array
    */
    public static float[] getProbabilityBinLowerThresholdExtRange() {
		// must be same length as corresponding version of bins
		float[] probabilityBinLowerThreshold = {0f,.1f,.2f,.3334f,.4f,.5f,.6f,.7f,.8f,.9f};
    	return probabilityBinLowerThreshold;
    }

    /**
	* Returns the lower limit probability bin threshold values of the bins
	* for long range forecasts used for reliability diagram.
	* The length must be the same as the corresponding number of bins.
	* This version of this method must be used if program has not run through
	* the section that sets the reliability diagram variables depending on forecast
	* type (near the beginning of calcStats), otherwise use getProbabilityBinLowerThreshold().
	*
	* @return 1-d float array
	*/
	public static float[] getProbabilityBinLowerThresholdLongRange() {
		// must be same length as corresponding version of bins
		float[] probabilityBinLowerThreshold = {0f,.1f,.2f,.3333f,.3334f,.4f,.5f,.6f,.7f,.8f,.9f};
		return probabilityBinLowerThreshold;
	}

    /**
	* Returns the lower limit probability bin threshold values of the bins
	* used for reliability diagram.
	* This version of this method can be used if program has already run through
	* the section that sets the reliability diagram variables depending on forecast
	* forecast type (near the beginning of calcStats), otherwise use
	* getProbabilityBinLowerThresholdExtRange() or getProbabilityBinLowerThresholdLongRange().
	*
    * @return 1-d float array
	*/
	public float[] getProbabilityBinLowerThreshold() {
		return probabilityBinLowerThreshold;
	}

    /**
    * Returns the upper limit probability bin threshold values of the bins
	* for extended range forecasts used for reliability diagram.
	* The length must be the same as the corresponding number of bins.
	* This version of this method must be used if program has not run through
	* the section that sets the reliability diagram variables depending on forecast
	* type (near the beginning of calcStats), otherwise use getProbabilityBinUpperThreshold().
    *
    * @return 1-d float array
    */
    public static float[] getProbabilityBinUpperThresholdExtRange() {
		// must be same length as corresponding version of bins
		float[] probabilityBinUpperThreshold = {.1f,.2f,.3334f,.4f,.5f,.6f,.7f,.8f,.9f,1.0f};
        return probabilityBinUpperThreshold;
    }

	/**
	* Returns the upper limit probability bin threshold values of the bins
	* for long range forecasts used for reliability diagram.
	* The length must be the same as the corresponding number of bins.
	* This version of this method must be used if program has not run through
	* the section that sets the reliability diagram variables depending on forecast
	* type (near the beginning of calcStats), otherwise use getProbabilityBinUpperThreshold().
	*
	* @return 1-d float array
	*/
	public static float[] getProbabilityBinUpperThresholdLongRange() {
		// must be same length as corresponding version of bins
		float[] probabilityBinUpperThreshold = {.1f,.2f,.3333f,.3334f,.4f,.5f,.6f,.7f,.8f,.9f,1.0f};
		return probabilityBinUpperThreshold;
	}

	/**
	* Returns the upper limit probability bin threshold values of the bins
	* used for reliability diagram.
	* This version of this method can be used if program has already run through
	* the section that sets the reliability diagram variables depending on forecast
	* forecast type (near the beginning of calcStats), otherwise use
	* getProbabilityBinUpperThresholdExtRange() or getProbabilityBinUpperThresholdLongRange().
	*
    * @return 1-d float array
	*/
	public float[] getProbabilityBinUpperThreshold() {
		return probabilityBinUpperThreshold;
	}


    /**
    Returns a String array of the range of probability bin values for extended range forecasts
	used for reliability diagram.
	These are associated with bins of threshold values used for statistics scores, such as reliability.
	The length must be the same as the corresponding number of bins.
	This version of this method must be used if program has not run through
	the section that sets the reliability diagram variables depending on forecast
	type (near the beginning of calcStats), otherwise use getProbabilityBinLabels().

    @return 1-d String array of probability values associated with probabilistic forecasts.
    */
    public static String[] getProbabilityBinLabelsExtRange() {
		// must be same length as corresponding version of bins
		String[] probabilityBinLabels = {"0-0.1","0.1-0.2","0.2-0.3334","0.3334-0.4","0.4-0.5","0.5-0.6","0.6-0.7","0.7-0.8","0.8-0.9","0.9-1.0"};
        return probabilityBinLabels;
    }

	/**
	Returns a String array of the range of probability bin values for long range forecasts
	used for reliability diagram.
    These are associated with bins of threshold values used for statistics scores, such as reliability.
	The length must be the same as the corresponding number of bins.
	This version of this method must be used if program has not run through
	the section that sets the reliability diagram variables depending on forecast
	type (near the beginning of calcStats), otherwise use getProbabilityBinLabels().

	@return 1-d String array of probability values associated with probabilistic forecasts.
	*/
	public static String[] getProbabilityBinLabelsLongRange() {
		// must be same length as corresponding version of bins
		String[] probabilityBinLabels = {"0-0.1","0.1-0.2","0.2-0.3333","0.3333","0.3334-0.4","0.4-0.5","0.5-0.6","0.6-0.7","0.7-0.8","0.8-0.9","0.9-1.0"};
		return probabilityBinLabels;
	}

	/**
	Returns a String array of the range of probability bin values used for reliability diagram.
	These are associated with bins of threshold values used for statistics scores, such as reliability.
    This version of this method can be used if program has already run through
	the section that sets the reliability diagram variables depending on forecast
	forecast type (near the beginning of calcStats), otherwise use
	getProbabilityBinLabelsExtRange() or getProbabilityBinLabelsLongRange().

	@return 1-d String array of probability values associated with probabilistic forecasts.
	*/
	public String[] getProbabilityBinLabels() {
		return probabilityBinLabels;
	}

   /**
   * Returns the probability axis labels for extended range forecasts used for reliability diagram.
   * These are associated with bins of threshold values used for statistics scores, such as reliability.
   * The length must be one longer than the corresponding version of bins. This is because the labels
   * correspond to the end points of the bins, so there is an extra value.
   * JClass needs the axes to be longer than the last plotted value. This allows labels from 0 to 1.
   * This version of this method must be used if program has not run through
   * the section that sets the reliability diagram variables depending on forecast
   * type (near the beginning of calcStats), otherwise use getProbabilityBinAxisLabels().
   *
   * @return 1-d float array of probability values associated with probabilistic forecasts.
   */
   public static float

   [] getProbabilityBinAxisLabelsExtRange() {
	   // length must be one longer than the corresponding version of bins
	   float[] probabilityBinAxisLabels = {0f,.1f,.2f,.33f,.4f,.5f,.6f,.7f,.8f,.9f,1.0f};
       return probabilityBinAxisLabels;
   }

   /**
   * Returns the probability axis labels for long range forecasts used for reliability diagram.
   * These are associated with bins of threshold values used for statistics scores, such as reliability.
   * The length must be one longer than the corresponding version of bins. This is because the labels
   * correspond to the end points of the bins, so there is an extra value.
   * JClass needs the axes to be longer than the last plotted value. This allows labels from 0 to 1.
   * As a result, .33 must be used twice as a label so a tick mark is not drawn at .34. The plot
   * looks messy with a tick mark at .34. The reference line also uses .33 twice which does not
   * affect anything.
   * This version of this method must be used if program has not run through
   * the section that sets the reliability diagram variables depending on forecast
   * type (near the beginning of calcStats), otherwise use getProbabilityBinAxisLabels().
   *
   * @return 1-d float array of probability values associated with probabilistic forecasts.
   */
   public float[] getProbabilityBinAxisLabelsLongRange() {
	   // length must be one longer than the corresponding version of bins
	   float[] probabilityBinAxisLabels = {0f,.1f,.2f,.33f,.33f,.4f,.5f,.6f,.7f,.8f,.9f,1.0f};
	   return probabilityBinAxisLabels;
   }

   /**
   * Returns the probability axis labels used for reliability diagram.
   * These are associated with bins of threshold values used for statistics scores, such as reliability.
   * This version of this method can be used if program has already run through
   * the section that sets the reliability diagram variables depending on forecast
   * forecast type (near the beginning of calcStats), otherwise use
   * getProbabilityBinAxisLabelsExtRange() or getProbabilityBinAxisLabelsLongRange().
   *
   * @return 1-d float array of probability values associated with probabilistic forecasts.
   */
   public float[] getProbabilityBinAxisLabels() {
       return probabilityBinAxisLabels;
   }

	public float[][][] getTempFcstCat() {
		float[][][] TempfcstCat3d = {{{3f,2f,1f,0f},{2f,2f,0f,0f},{3f,0f,0f,0f},{1f,0f,0f,0f}},{{0f,2f,1f,1f},{3f,0f,0f,2f},{1f,2f,2f,1f},{2f,1f,1f,3f}}};
		return TempfcstCat3d;
	}

	public float[][][][] getTempFcstProb() {
		float[][][][] TempfcstProb4d = {{{{.6f,.3f,.1f},{.5f,.4f,.1f},{.8f,.1f,.1f},{.5f,.4f,.1f}},{{.6f,.3f,.1f},{.8f,.1f,.1f},{.5f,.4f,.1f},{.5f,.4f,.1f}},{{.6f,.3f,.1f},{.8f,.1f,.1f},{.5f,.4f,.1f},{.5f,.4f,.1f}},{{.6f,.3f,.1f},{.8f,.1f,.1f},{.5f,.4f,.1f},{.5f,.4f,.1f}}},{{{.8f,.3f,.2f},{.5f,.4f,.1f},{.3f,Float.NaN,Float.NaN},{Float.NaN,Float.NaN,Float.NaN}},{{.6f,.3f,.1f},{.5f,.4f,.1f},{.8f,.1f,.1f},{.5f,.4f,.1f}},{{.6f,.3f,.1f},{.8f,.1f,.1f},{.5f,.4f,.1f},{.5f,.4f,.1f}},{{.6f,.3f,.1f},{.5f,.4f,.1f},{.8f,.1f,.1f},{.5f,.4f,.1f}}}};
		return TempfcstProb4d;
	}

	public float[][] getTempObsCat() {
		float[][] TempobsCat2d = {{3,1,1,2},{3,1,1,2},{3,2,3,1},{3,1,3,2}};
		return TempobsCat2d;
	}


    ////////////////////////////////////////
    // Set methods
    //

    /**
    * Sets aveFloatArray
    */
	public void setAveFloatArray(float[][][] aveFloatArray)
	{
		this.aveFloatArray = aveFloatArray;
	}

    /**
    * Sets scoreCatFloatArray
    */
	public void setScoreCatFloatArray(float[][][] scoreCatFloatArray)
	{
		this.scoreCatFloatArray = scoreCatFloatArray;
	}

    /**
    * Sets goodDataCountArray
    */
	public void setGoodDataCountArray(int[][][] goodDataCountArray)
	{
		this.goodDataCountArray = goodDataCountArray;
	}

    /**
    * Sets goodDataPercentArray
    */
	public void setGoodDataPercentArray(float[][][] goodDataPercentArray)
	{
		this.goodDataPercentArray = goodDataPercentArray;
	}

    /**
    * Sets goodScoreCountArray
    */
        public void setGoodScoreCountArray(int[][] goodScoreCountArray)
        {
                this.goodScoreCountArray = goodScoreCountArray;
        }

    /**
    * Sets goodScorePercentArray
    */
        public void setGoodScorePercentArray(float[][] goodScorePercentArray)
        {
                this.goodScorePercentArray = goodScorePercentArray;
        }


    /**
    * Sets numExpectedFcstsPerScore
    */
        public void setNumExpectedFcstsPerScore(int[] numExpectedFcstsPerScore)
        {
                this.numExpectedFcstsPerScore = numExpectedFcstsPerScore;
        }

    /**
    * Sets numExpectedScores
    */
        public void setNumExpectedScores(int[] numExpectedScores)
        {
                this.numExpectedScores = numExpectedScores;
        }

    /**
    * Sets aveFcstProbArray
    */
	public void setAveFcstProbArray(float[][][] aveFcstProbArray)
	{
		this.aveFcstProbArray = aveFcstProbArray;
	}

    /**
    * Sets bins
    */
	public void setBins(int bins)
	{
		this.bins = bins;
	}

    /**
    * Sets probabilityBinLowerThreshold
    */
	public void setProbabilityBinLowerThreshold(float[] probabilityBinLowerThreshold)
	{
		this.probabilityBinLowerThreshold = probabilityBinLowerThreshold;
	}

    /**
    * Sets probabilityBinUpperThreshold
    */
	public void setProbabilityBinUpperThreshold(float[] probabilityBinUpperThreshold)
	{
		this.probabilityBinUpperThreshold = probabilityBinUpperThreshold;
	}

    /**
    * Sets probabilityBinAxisLabels
    */
	public void setProbabilityBinAxisLabels(float[] probabilityBinAxisLabels)
	{
		this.probabilityBinAxisLabels = probabilityBinAxisLabels;
	}

    /**
    * Sets probabilityBinLabels
    */
	public void setProbabilityBinLabels(String[] probabilityBinLabels)
	{
		this.probabilityBinLabels = probabilityBinLabels;
	}


} // end Stats class


