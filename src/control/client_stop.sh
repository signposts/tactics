#!/bin/sh

for dir in $HOME/tactics/working/*/
do
	if [ -e $dir/client/stop.sh ]; then
		sh $dir/client/stop.sh
	fi
	sleep 10
done
