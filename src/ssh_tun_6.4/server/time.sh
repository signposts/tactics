#!/bin/sh

present_dir=`dirname $0`
echo $present_dir
time1=`date '+%s'`
echo $time1
	
if [ -e $present_dir/config_iface.sh ]; then
	sh $present_dir/config_iface.sh
fi

time2=`date '+%s'`
echo $time2

echo "time taken by ssh_tun_server: `expr $time2 - $time1`"
