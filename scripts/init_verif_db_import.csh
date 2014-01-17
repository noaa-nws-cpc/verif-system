#!/bin/csh

# Source the .cshrc file
source ~/.cshrc
# Change to the process directory
cd $VERIF_HOME
# Initiate the extendedRange call
echo "##########################################################################"
echo "                              Extended Range"
echo "##########################################################################"
./scripts/db_import_daily.pl -fcstType extendedRange -startdate `date -d '2 weeks ago' +\%Y\%m\%d` -enddate `date +\%Y\%m\%d` -validdate
# Initiate the longRange call
echo "##########################################################################"
echo "                                Long Range"
echo "##########################################################################"
./scripts/db_import_daily.pl -fcstType longRange -startdate `date -d '1 year ago' +\%Y\%m` -enddate `date +\%Y\%m` -validdate

