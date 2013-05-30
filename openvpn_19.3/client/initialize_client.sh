#!/bin/sh 

# IP of the server machine, this value is taken from $HOME/tactics/config file
ip=$(cat $HOME/tactics/config | grep server_ip | awk '{ print $2 }')

#Specifies the port on which openvpn client listens to. This value is taken from $HOME/tactics/openvpn_19.3/client/parameters
port=$(cat `dirname $0`/parameters | grep Port | awk '{ print $2 }')

# Name of the client which server has mentioned while generating keys in its parameters file. This value is taken from $HOME/tactics/openvpn_19.3/client/parameters
su=$(cat `dirname $0`/parameters | grep Host_name | awk '{ print $2 }')

#removing any xisting client.conf so that everytime a new file is generated with new parameters
if [ -e $HOME/ov_me_client/client.conf ]; then
	rm -rf $HOME/ov_me_client/client.conf
fi

# reading parameters from above arguements and making custom client.conf file 
cat `dirname $0`/client.conf.template |\
    sed -e "s/\\\$port\\\$/$port/g" -e "s/\\\$ip\\\$/$ip/g" -e "s/\\\$su\\\$/$su/g"|\
    tee $HOME/ov_me_client/client.conf


echo "openvpn started"

cd $HOME/ov_me_client

echo "cding"

#starting openvpn
openvpn client.conf &
