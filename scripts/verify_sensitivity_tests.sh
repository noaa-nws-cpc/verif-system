#!/bin/sh

startdate='20110601'
enddate='20130531'
vars='temp precip'
scores='heidke rpss reliability'
skip_verif=1
scores='reliability'

# Check for VERIF_HOME environment variable
[ -z $VERIF_HOME ] && { echo "\$VERIF_HOME environment variable needs to be defined first..."; exit 1; }

cd $VERIF_HOME

if [[ skip_verif == 0 ]]; then
	#------------------------------------------------------------------------------
	# Verify all sensitivity cases
	#
	# Loop over variables
	for var in $vars; do
		# Loop over score types
		for score in $scores; do
			# Set outputDimension
			if [ $score == 'reliability' ]; then
				outputDimension='probability'
			else
				outputDimension='time'
			fi
			# Loop over all cases
			for case in $(seq 0 11); do
				# Create settings.xml
				xml="
	<settings>
	    <variable>$var</variable>
	    <fcstSources>rfcstCalProb${case}_gfsensm_00z</fcstSources>
	    <leadTime>11d</leadTime>
	    <aveWindow>07d</aveWindow>
	    <datesValidType>dateRange</datesValidType>
	    <datesValid>$startdate,$enddate</datesValid>
	    <regionType>climateRegion</regionType>
	    <regions>All</regions>
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

cd $VERIF_HOME/work

#------------------------------------------------------------------------------
# Combine all cases into one CSV
#
# Create empty files to store final verif
for score in $scores; do
	> ../output/temp_${score}.csv
	> ../output/precip_${score}.csv
	if [[ $score == 'reliability' ]]; then
		> ../output/temp_reliability_count.csv
		> ../output/precip_reliability_count.csv
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
		tail -n +21 ../output/verif_${var}_rfcstCalProb0_gfsensm_00z_11d_07d_stn_${score}_totalCats_${outputDimension}_dateRange_${startdate}-${enddate}.txt | awk "BEGIN {print \"$first_col_header\"} {print \$1}" | sed '/^$/d' > temp1.txt
		# Loop over cases
		filecount=2
		filelist="temp1.txt"
		for case in $(seq 0 11); do
			# Create score column for this case
			tail -n +21 ../output/verif_${var}_rfcstCalProb${case}_gfsensm_00z_11d_07d_stn_${score}_totalCats_${outputDimension}_dateRange_${startdate}-${enddate}.txt | awk "BEGIN {print \"case$case\"} {print \$3}" | sed '/^$/d' > temp${filecount}.txt
			# Add this file to the file list
			filelist="$filelist temp${filecount}.txt"
			filecount=$((filecount+1))
		done
		# Combine all columns into one file
		paste -d"," $filelist > ../output/${var}_${score}.csv
		# For reliability, make a file with counts as well
		if [ $score == 'reliability' ]; then
			# Create probability column
			tail -n +21 ../output/verif_${var}_rfcstCalProb0_gfsensm_00z_11d_07d_stn_${score}_totalCats_${outputDimension}_dateRange_${startdate}-${enddate}.txt | awk "BEGIN {print \"probability\"} {print \$1}" | sed '/^$/d' > temp1.txt
			# Loop over cases
			filecount=2
			filelist="temp1.txt"
			for case in $(seq 0 11); do
				# Create score column for this case
				tail -n +21 ../output/verif_${var}_rfcstCalProb${case}_gfsensm_00z_11d_07d_stn_${score}_totalCats_${outputDimension}_dateRange_${startdate}-${enddate}.txt | awk "BEGIN {print \"case$case\"} {print \$4}" | sed '/^$/d' > temp${filecount}.txt
				# Add this file to the file list
				filelist="$filelist temp${filecount}.txt"
				filecount=$((filecount+1))
			done
			# Combine all columns into one file
			paste -d"," $filelist > ../output/${var}_reliability_count.csv
		fi
	done
done
# Cleanup
rm -f *


