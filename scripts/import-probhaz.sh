#!/bin/sh

start_date=20130101
end_date=20170227
for lead in 09d 10d 11d 12d 13d ; do
	./db_import_data.pl -d forecast -v precip-ptile-15-and-85 -a 03d -g grid2deg -s $start_date -e $end_date -f tool -l $lead -t rfcstCal -m gefs -c 00z -validdate
done

