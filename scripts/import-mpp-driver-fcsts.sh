#!/bin/bash

start_date=20130701
#end_date=20151231
end_date=20180630
models="gefsPyObs gefsPyD0"
# models="gefs-legacy"
#tools="rfcstCalPy-PyStats rfcstCalPy-PyStatsUnsmoothed rfcstCalPy-MatlabStats"
# tools="rfcstCalPy-PyStats rfcstCalPy-MatlabStats"
tools="bc"
# tools="rfcstCalPy-PyStats rfcstCalPy-MatlabStats"
vars="temp"
geotype="stn"

for model in $models ; do
	for tool in $tools ; do
		for var in $vars ; do
			./db_import_data.pl -d forecast -v $var -a 07d -g $geotype -s $start_date -e $end_date -f tool -l 11d -t $tool -m $model -c 00z -validdate
		done
	done
done

for var in $vars ; do
	./db_import_data.pl -d forecast -v $var -a 07d -g $geotype -s $start_date -e $end_date -f tool -l 11d -t BC -m gefs -c al -validdate --skip-header
#	./db_import_data.pl -d observation -v $var -a 07d -g $geotype -s $start_date -e $end_date --skip-header
done

