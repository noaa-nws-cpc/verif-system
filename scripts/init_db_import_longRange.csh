#!/bin/csh

# Source the .cshrc file
source ~/.cshrc
# Change to the process directory
cd $VERIF_HOME
# Initiate the data import script
scripts/db_import_daily.pl -fcstType longRange -startdate `date -d '1 year ago' +\%Y\%m` -enddate `date +\%Y\%m` -validdate

