#!/bin/bash

# Get the forecast type
fcst_type=$1
# Source the .profile file
. $HOME/.profile
# Change to the process directory
cd $VERIF_HOME
# Run the Perl driver with args based on the forecast type
if [[ $fcst_type == 'ERF' ]] ; then
	./scripts/db_test_findMissing_batch.pl -f ERF -loglevel error -email > $VERIF_HOME/logs/db_test_findMissing_ERF.log 2>&1
elif [[ $fcst_type == 'monthly' ]] ; then
	./scripts/db_test_findMissing_batch.pl -f monthly -loglevel error -email > $VERIF_HOME/logs/db_test_findMissing_monthly.log 2>&1
elif [[ $fcst_type == 'monthly_revised' ]] ; then
	./scripts/db_test_findMissing_batch.pl -f monthly_revised -loglevel error -email > $VERIF_HOME/logs/db_test_findMissing_monthly_revised.log 2>&1
elif [[ $fcst_type == 'seasonal' ]] ; then
	./scripts/db_test_findMissing_batch.pl -f seasonal -loglevel error -email > $VERIF_HOME/logs/db_test_findMissing_seasonal.log 2>&1
else
	echo "Usage: "`basename $0`" [FCST_TYPE]"
	echo "  where [FCST_TYPE] = (ERF, monthly, revised_monthly, or seasonal)"
	exit 1
fi
