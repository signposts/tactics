#!/bin/sh 

#removing already existing server.conf file and creating a new one so that it can have modified parameters
if [ -e $HOME/ov_me/server.conf ]; then
	rm -rf $HOME/ov_me/server.conf
fi

#Specifies the port on which openvpn server listens to. This value is taken from $HOME/tactics/openvpn_19.3/server/parameters
port=$(cat `dirname $0`/parameters | grep Port | awk '{ print $2 }')

# reading parameters from above arguements and making custom server.conf file 
cat `dirname $0`/server.conf.template |\
    sed -e "s/\\\$port\\\$/$port/g" |\
    tee $HOME/ov_me/server.conf



cd $HOME/ov_me

#starting openvpn for server
openvpn server.conf &
