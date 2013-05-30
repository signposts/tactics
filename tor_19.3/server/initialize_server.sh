#!/usr/bin/env bash 

#Specifies the port on which hidden service is running at server. This value is taken from $HOME/tactics/tor_19.3/server/parameters
port=$(cat `dirname $0`/parameters | grep Port | awk '{ print $2 }')

#running server at port 5061
python -m SimpleHTTPServer $port &

#Creating tor.conf with changed parameters
cat `dirname $0`/tor.conf.template |\
    sed -e "s|\\\$dir\\\$|$HOME/tor/hidden_service|g" -e "s/\\\$port\\\$/$port/g" |\
    tee `dirname $0`/tor.conf

#creating directory where hidden service folder containing hostname will be placed
if [ -d $HOME/tor ]; then
	rm -rf $HOME/tor
fi

mkdir $HOME/tor

#changing permission for the folder so that hidden_service folder can be placed by tor when tor starts
chmod 777 $HOME/tor

#----------------------------------------------------------------------------------------------------------#
						#### NOT IN USE ###
#echo "Permission changedddd"

#if [ -d $HOME/tor/hidden_service ]; then
#	rm -rf $HOME/tor/hidden_service
#fi

#mkdir $HOME/tor/hidden_service

#echo "Directory createdddddd"

#chown -R $USER $HOME/tor_me/hidden_service
#chmod 777 $HOME/tor/hidden_service

#eecho "Permission changed"
#--------------------------------------------------------------------------------------------------------#
tor -f `dirname $0`/tor.conf

# Needed to give time in order to run tor and generate hostname file
sleep 10

chmod 777 $HOME/tor/hidden_service/

# Remove already existing hostname file because the domain name changes with every new connection
if [ -e $HOME/hostname ]; then
	rm $HOME/hostname
fi

cp $HOME/tor/hidden_service/hostname $HOME/

chmod 777 $HOME/hostname









