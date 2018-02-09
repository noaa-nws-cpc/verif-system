#!/bin/sh

usage() {
    printf "$(basename "$0") VARNAME\n"
    printf "  where:\n"
    printf "    VARNAME variable to process (tmax-ptile-X-and-Y, tmin-ptile-X-and-Y, or precip-ptile-X-and-Y)\n"
}

var=$1

if [[ "$#" -lt 1 ]] ; then
    usage ; exit
fi

rm output/ave_scores_${var}_*.txt
# Determine leads
if [[ "$var" == tmin* || "$var" == tmax* ]] ; then
    leads="08d 09d 10d 11d 12d 13d 14d"
else
    leads="09d 11d 13d"
fi
for lead in $leads ; do
    # for score in heidke rpss reliability ; do
    for score in heidke reliability ; do
        # Determine dimension
        if [[ "$score" == "reliability" ]] ; then
                dimension=probability
        else
                dimension=time
        fi
        # Determine category
        if [[ "$score" == "rpss" ]] ; then
                category="total"
        else
            if [[ "$var" == tmin* ]] ; then
                category="B"
            else
                category="A"
            fi
        fi
        # Determine datesValid
        if [[ "$var" == tmin* ]] ; then
            datesValid="10,11,12,01,02,03;2014,2015,2016,2017"
        elif [[ "$var" == tmax* ]]; then
            datesValid="04,05,06,07,08,09;2014,2015,2016,2017"
        elif [[ "$var" == precip* ]]; then
            datesValid="01,02,03,04,05,06,07,08,09,10,11,12;2016,2017"
        fi
        # Determine window
        if [[ "$var" == tmin* || "$var" == tmax* ]] ; then
            window="01d"
        else
            window="03d"
        fi
        echo "Calculating ${score} for lead ${lead}..."
        # Modify settings.xml
        jinja2 -D lead=$lead -D window=$window -D dimension=$dimension -D score=$score -D category=$category -D datesValid=$datesValid -D var=$var settings.xml.j2 > input/settings.xml
        # Verify
        ant run_command_line_direct_access >& vwt.log
        cat vwt.log
        # Get average score from log file
        echo "${lead}: " $( grep -o -P "average score and number of values in ave, model 0, category ${category}\[.*\]" logs/static.log ) >> output/ave_scores_${var}_${score}.txt
    done
done
