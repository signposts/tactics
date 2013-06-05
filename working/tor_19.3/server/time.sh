#!/bin/sh

present_dir=`dirname $0`
echo $present_dir
time1=`date '+%s'`
echo $time1
	
if [ -e $present_dir/aprior.sh ]; then
	sh $present_dir/aprior.sh
fi

if [ -e $present_dir/initialize_server.sh ]; then
	sh $present_dir/initialize_server.sh
fi

time2=`date '+%s'`
echo $time2

echo "time taken by tor_server: `expr $time2 - $time1`"
