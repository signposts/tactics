#!/bin/sh

# This shell script will start all the available tactics at client side simultaneously, creating all the tunnels by the available tactics. 

#This will look for all the tactics folder present in 'working' directory
for dir in $HOME/tactics/working/*/
do
    	echo $dir	
	#sh $dir/install.sh     # UNCOMMENT this if you want to install softwares for tactics
	
	if [ -e $dir/client/aprior.sh ]; then  #Search for any aprior.sh script which need to run before main script 
		sh $dir/client/aprior.sh
	fi
	
	if [ -e $dir/client/initialize_client.sh ]; then #Running main script which will start client
		sh $dir/client/initialize_client.sh
	fi
	
	sleep 10  #Sleep added so that tactic which was started before the other tactic is completed
done


