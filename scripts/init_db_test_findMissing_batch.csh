#!/bin/csh

# Source the .cshrc file
source ~/.cshrc
# Change to the process directory
cd $VERIF_HOME
# Pass all arguments to the driver script and execute it
./scripts/db_test_findMissing_batch.pl $argv
