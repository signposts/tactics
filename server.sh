#!/bin/sh

for dir in $HOME/tactics/*/
do
    #dir=${dir%*/}
    #echo ${dir##*/}
	echo $dir	
	#sh $dir/install.sh
	#echo "starting apriror"
	if [ -e $dir/server/aprior.sh ]; then
		sh $dir/server/aprior.sh
	fi
	#echo "starting initialize"
	if [ -e $dir/server/initialize_server.sh ]; then
		sh $dir/server/initialize_server.sh
	fi
	#echo "ending initialize"
	sleep 10
done


