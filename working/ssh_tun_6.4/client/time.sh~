#!/bin/sh

present_dir=`dirname $0`
echo $present_dir
time1=`date '+%s'`
echo $time1
	
if [ -e $present_dir/aprior.sh ]; then
	sh $present_dir/aprior.sh
fi

if [ -e $present_dir/initialize_client.sh ]; then
	sh $present_dir/initialize_client.sh
fi

time2=`date '+%s'`
echo $time2

echo "time taken by ssh_tap_client: `expr $time2 - $time1`"
