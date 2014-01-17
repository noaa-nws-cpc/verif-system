#!/bin/csh

# Source the .cshrc file
source ~/.cshrc
# Change to the process directory
cd $VERIF_HOME
# Initiate the data import script
scripts/db_import_climPhenom.pl -i http://www.cpc.ncep.noaa.gov/data/indices/oni.ascii.txt -c ENSO -t seasonal -m 1 -y 2 -v 3 -f MMM -hasheader

