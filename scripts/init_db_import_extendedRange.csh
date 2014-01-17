#!/bin/csh

# Source the .cshrc file
source ~/.cshrc
# Change to the process directory
cd $VERIF_HOME
# Initiate the data import script
scripts/db_import_daily.pl -fcstType extendedRange -startdate `date -d '2 weeks ago' +\%Y\%m\%d` -enddate `date +\%Y\%m\%d` -validdate

