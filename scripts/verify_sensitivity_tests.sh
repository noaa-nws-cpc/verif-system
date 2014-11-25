#!/bin/sh

startdate='20110101'
enddate='20131231'
vars='precip'
scores='heidke rpss reliability'
seasons='all DJF MAM JJA SON'
cases='0 1 2 3 4 5 6 7 8 9 10 11'
skip_verif=0

# Check for VERIF_HOME environment variable
[ -z $VERIF_HOME ] && { echo "\$VERIF_HOME environment variable needs to be defined first..."; exit 1; }

cd $VERIF_HOME

# Loop over seasons
for season in $seasons; do
	# Set dates
	if [[ $season == 'DJF' ]] ; then
		datesValidType='selectMonthsYears'
		datesValid='01,02,12;2011,2012,2013'
		datesInFile='01-02-12_2011-2012-2013'
	elif [[ $season == 'MAM' ]] ; then
		datesValidType='selectMonthsYears'
		datesValid='03,04,05;2011,2012,2013'
		datesInFile='03-04-05_2011-2012-2013'
	elif [[ $season == 'JJA' ]] ; then
		datesValidType='selectMonthsYears'
		datesValid='06,07,08;2011,2012,2013'
		datesInFile='06-07-08_2011-2012-2013'
	elif [[ $season == 'SON' ]] ; then
		datesValidType='selectMonthsYears'
		datesValid='09,10,11;2011,2012,2013'
		datesInFile='09-10-11_2011-2012-2013'
	else
		datesValidType='dateRange'
		datesValid="$startdate,$enddate"
		datesInFile="$startdate-$enddate"
	fi

	if [[ $skip_verif == 0 ]]; then
		#------------------------------------------------------------------------------
		# Verify all sensitivity cases
		#
		# Loop over variables
		for var in $vars; do
			# Loop over score types
			for score in $scores; do
				echo "<-------------------------------- Processing $var $score for season $season -------------------------------->"
				# Set outputDimension
				if [ $score == 'reliability' ]; then
					outputDimension='probability'
				else
					outputDimension='time'
				fi

				# Loop over all cases
				for case in $cases; do
					# Create settings.xml
					xml="
					<settings>
					<variable>$var</variable>
					<fcstSources>rfcstCalProb${case}_gfsensm_00z</fcstSources>
					<leadTime>11d</leadTime>
					<aveWindow>07d</aveWindow>
					<datesValidType>$datesValidType</datesValidType>
					<datesValid>$datesValid</datesValid>
					<regionType>climateRegion</regionType>
					<regions>NE,SE,MW,S,HP,W</regions>
					<spatialType>station</spatialType>
					<outputType>ascii</outputType>
					<outputDimension>$outputDimension</outputDimension>
					<scoreType>$score</scoreType>
					<categoryType>total</categoryType>
					<ECType>default</ECType>
					</settings>
					"
					echo $xml > input/settings.xml
					# Run VWT
					ant run_command_line_direct_access
				done
			done
		done
	fi

	cd work

	#------------------------------------------------------------------------------
	# Combine all cases into one CSV
	#
	# Create empty files to store final verif
	for score in $scores; do
		> ../output/temp_${score}_${season}.csv
		> ../output/precip_${score}_${season}.csv
		if [[ $score == 'reliability' ]]; then
			> ../output/temp_reliability_count_${season}.csv
			> ../output/precip_reliability_count_${season}.csv
		fi
	done
	# Loop over score
	for score in $scores; do
		# Set outputDimension
		if [ $score == 'reliability' ]; then
			outputDimension='probability'
			first_col_header='probability'
		else
			outputDimension='time'
			first_col_header='date'
		fi
		# Loop over variables
		for var in temp precip ; do
			# Create date/probability column
			tail -n +21 ../output/verif_${var}_rfcstCalProb0_gfsensm_00z_11d_07d_stn_${score}_CombinedCategories_${outputDimension}_${datesValidType}_${datesInFile}.txt | awk "BEGIN {print \"$first_col_header\"} {print \$1}" | sed '/^$/d' > temp1.txt
			# Loop over cases
			filecount=2
			filelist="temp1.txt"
			for case in $cases; do
				# Create score column for this case
				tail -n +21 ../output/verif_${var}_rfcstCalProb${case}_gfsensm_00z_11d_07d_stn_${score}_CombinedCategories_${outputDimension}_${datesValidType}_${datesInFile}.txt | awk "BEGIN {print \"case$case\"} {print \$3}" | sed '/^$/d' > temp${filecount}.txt
				# Add this file to the file list
				filelist="$filelist temp${filecount}.txt"
				filecount=$((filecount+1))
			done
			# Combine all columns into one file
			paste -d"," $filelist > ../output/${var}_${score}_${season}.csv
			# For reliability, make a file with counts as well
			if [ $score == 'reliability' ]; then
				# Create probability column
				tail -n +21 ../output/verif_${var}_rfcstCalProb0_gfsensm_00z_11d_07d_stn_${score}_CombinedCategories_${outputDimension}_${datesValidType}_${datesInFile}.txt | awk "BEGIN {print \"probability\"} {print \$1}" | sed '/^$/d' > temp1.txt
				# Loop over cases
				filecount=2
				filelist="temp1.txt"
				for case in $cases; do
					# Create score column for this case
					tail -n +21 ../output/verif_${var}_rfcstCalProb${case}_gfsensm_00z_11d_07d_stn_${score}_CombinedCategories_${outputDimension}_${datesValidType}_${datesInFile}.txt | awk "BEGIN {print \"case$case\"} {print \$4}" | sed '/^$/d' > temp${filecount}.txt
					# Add this file to the file list
					filelist="$filelist temp${filecount}.txt"
					filecount=$((filecount+1))
				done
				# Combine all columns into one file
				paste -d"," $filelist > ../output/${var}_reliability_count_${season}.csv
			fi
		done
	done
	# Cleanup
	rm -f *

	cd ../
done
