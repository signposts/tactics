#!/bin/sh 

#this will create keys with $SUDO_USER name of the client

# name of the server machine, this value is taken from $HOME/tactics/config file 
host_name=$(cat $HOME/tactics/config | grep server_name | awk '{ print $2 }')

# IP of the server machine, this value is taken from $HOME/tactics/config file
host_ip=$(cat $HOME/tactics/config | grep server_ip | awk '{ print $2 }')

# Name of the client which server has mentioned while generating keys in its parameters file. This value is taken from $HOME/tactics/openvpn_19.3/client/parameters
su=$(cat `dirname $0`/parameters | grep Host_name | awk '{ print $2 }')

# Key which was generated to connect client and server without password. This value is taken from $HOME/tactics/config file
key=$(cat $HOME/tactics/config | grep path_to_key | awk '{ print $2 }')

#remove any existing openvpn folder at client so that everytime new keys are stored in this folder.
if [ -d $HOME/ov_me_client ]; then
	rm -rf $HOME/ov_me_client
fi

mkdir $HOME/ov_me_client

#Copying files generated at server. These files contain certificates and keys

scp -i $key -r $host_name@$host_ip:/home/$host_name/ov_me/ca.crt $HOME/ov_me_client/
echo "ca.crt copied"


scp -i $key -r $host_name@$host_ip:/home/$host_name/ov_me/keys/$su.crt $HOME/ov_me_client/
echo "$su.crt copied"


scp -i $key -r $host_name@$host_ip:/home/$host_name/ov_me/keys/$su.key $HOME/ov_me_client/
echo "$su.key copied"


scp -i $key -r $host_name@$host_ip:/home/$host_name/ov_me/ta.key $HOME/ov_me_client/
echo "ta.key copied"
