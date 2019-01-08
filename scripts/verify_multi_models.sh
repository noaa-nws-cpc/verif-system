#!/bin/sh

startDate='20160101'
endDate='20171231'
leadTimes='08d'
scoreTypes='heidke rpss reliability'
variables='precip'
spatialType='station'
#fcstSources='rfcstCal_ecens_00z rfcstCalPy-PyStatsUnsmoothed_ecens-legacy_00z rfcstCalPy-PyStats_ecens-legacy_00z rfcstCalPy-MatlabStats_ecens-legacy_00z'
fcstSources='rfcstCal_ecens_00z'
#fcstSources='rfcstCal_ecens_00z rfcstCalPy-MatlabStats_ecens-legacy_00z'
verifType='temporal'
regionType='climateRegion'
regions='CONUS'
#regions='HP,S,SE,MW,NE'
# regions='W'

if [[ $spatialType == 'gridded' ]] ; then
    spatialTypeFile='grid2deg'
else
    spatialTypeFile='stn'
fi

# Loop over lead
for leadTime in $leadTimes ; do
	# Determine average window
	if [ $leadTime == '08d' ] ; then
		aveWindow='05d'
	else
		aveWindow='07d'
	fi
	# Loop over score
	for scoreType in $scoreTypes ; do
		# Determine lead & average window
		if [ $scoreType == 'reliability' ] ; then
			outputDimension='probability'
		else
            if [[ $verifType == 'spatial' ]] ; then
                outputDimension='space'
            else
    			outputDimension='time'
            fi
		fi
		# Loop over variable
		for variable in $variables ; do
			# Loop over forecast source
            outfile_list=''
			for fcstSource in $fcstSources ; do
				# Write the XML to the settings.xml file
				cat > ../input/settings.xml <<EOF
<?xml version="1.0"?>
<data>
	<settings>
	    <variable>$variable</variable>
	    <fcstSources>$fcstSource</fcstSources>
	    <leadTime>$leadTime</leadTime>
	    <aveWindow>$aveWindow</aveWindow>
	    <datesValidType>dateRange</datesValidType>
	    <datesValid>$startDate,$endDate</datesValid>
	    <regionType>$regionType</regionType>
	    <regions>$regions</regions>
	    <spatialType>$spatialType</spatialType>
	    <outputType>ascii</outputType>
	    <outputDimension>$outputDimension</outputDimension>
	    <scoreType>$scoreType</scoreType>
	    <categoryType>total</categoryType>
	    <ECType>default</ECType>
	</settings>
</data>
EOF
				# Run the VWT
                if [[ $verifType == 'spatial' ]] ; then
                    echo "Running VWT static plots for ${variable}_${fcstSource}_${leadTime}_${aveWindow}_${spatialTypeFile}_${scoreType}..."
                    $VERIF_STATICPLOTS/scripts/Generate_staticPlots.pl -l $endDate -format xml -file ../input/settings.xml
                else
                    echo "Running VWT for ${variable}_${fcstSource}_${leadTime}_${aveWindow}_${spatialTypeFile}_${scoreType}..."
	    			ant -f ../build.xml run_command_line_direct_access >& ../logs/vwt.log
                fi
                # Strip the skill column from the text file
                if [[ $scoreType == 'reliability' ]] ; then
                    header_lines=21
                    left_column_name='FcstProb'
                else
                    header_lines=25
                    left_column_name='Date'
                fi
                infile="verif_${variable}_${fcstSource}_${leadTime}_${aveWindow}_${spatialTypeFile}_${scoreType}_CombinedCategories_${outputDimension}_dateRange_${startDate}-${endDate}.txt"
                outfile="verif_${variable}_${fcstSource}_${leadTime}_${aveWindow}_${spatialTypeFile}_${scoreType}_${startDate}-${endDate}.txt"
                tail -n +$header_lines ../output/$infile | awk '{print $3}' > ../output/$outfile
                sed -i "1s/^/${fcstSource}\n/" ../output/$outfile

                # Build a list of outputfiles for the paste command below
                outfile_list="$outfile_list ../output/$outfile"
			done
            # Create a date/probability column text file
            tail -n +$header_lines ../output/$infile | awk '{print $1}' > ../output/left-column.txt
            sed -i "1s/^/${left_column_name}\n/" ../output/left-column.txt
            # Combine all the text files into one text file
            echo "paste -d ',' ../output/left-column.txt $outfile_list > ../output/verif_${variable}_${leadTime}_${aveWindow}_${spatialTypeFile}_${scoreType}_${startDate}-${endDate}.txt"
            paste -d ',' ../output/left-column.txt $outfile_list > ../output/verif_${variable}_${leadTime}_${aveWindow}_${spatialTypeFile}_${scoreType}_${startDate}-${endDate}.csv
            # Shorten column headers and remove all-NaN lines
            sed -i 's/uncalibratedProb/raw/g;s/calibratedProb/BC/g;/^,*$/d' ../output/verif_${variable}_${leadTime}_${aveWindow}_${spatialTypeFile}_${scoreType}_${startDate}-${endDate}.csv
		done
	done
done
