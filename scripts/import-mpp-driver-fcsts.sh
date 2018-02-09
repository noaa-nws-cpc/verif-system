#!/bin/bash

start_date=20160101
#end_date=20160228
end_date=20180131
models="ecens"
#tools="rfcstCalPy-PyStats rfcstCalPy-PyStatsUnsmoothed rfcstCalPy-MatlabStats"
tools="rfcstCalPy-MatlabStats"
vars="precip"

for model in $models ; do
	for tool in $tools ; do
		for var in $vars ; do
			./db_import_data.pl -d forecast -v $var -a 05d -g stn -s $start_date -e $end_date -f tool -l 08d -t $tool -m $model -c 00z -validdate
		done
	done
done

