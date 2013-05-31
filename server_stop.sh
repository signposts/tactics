#!/bin/sh

for dir in $HOME/tactics/working/*/
do
	if [ -e $dir/server/stop.sh ]; then
		sh $dir/server/stop.sh
	fi
	sleep 10
done
