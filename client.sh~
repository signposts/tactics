#!/bin/sh

for dir in $HOME/tactics/*/
do
    #dir=${dir%*/}
    #echo ${dir##*/}
	echo $dir	
	sh $dir/install.sh
	#echo "starting apriror"
	if [ -e $dir/client/aprior.sh ]; then
		sh $dir/client/aprior.sh
	fi
	#echo "starting initialize"
	if [ -e $dir/client/initialize_client.sh ]; then
		sh $dir/client/initialize_client.sh
	fi
	#echo "ending initialize"
	sleep 10
done


