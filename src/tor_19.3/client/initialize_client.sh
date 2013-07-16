#!/usr/bin/env bash 

# name of the server machine, this value is taken from $HOME/tactics/config file 
host_name=$(cat $HOME/tactics/config | grep server_name | awk '{ print $2 }')

# IP of the server machine, this value is taken from $HOME/tactics/config file
host_ip=$(cat $HOME/tactics/config | grep server_ip | awk '{ print $2 }')

#Specifies the port on which hidden service is running at server. This value is taken from $HOME/tactics/tor_19.3/client/parameters
port=$(cat `dirname $0`/parameters | grep Port | awk '{ print $2 }')

# Key which was generated to connect client and server without password. This value is taken from $HOME/tactics/config file
key=$(cat $HOME/tactics/config | grep path_to_key | awk '{ print $2 }')

#creating a directory `tor_client` where `hostname` containing domain name of hidden-service is copied
if [ -d $HOME/tor_client ]; then
	rm -rf $HOME/tor_client
fi

mkdir $HOME/tor_client

#chmod 777 $HOME/tor_client

#if [ ! -e $HOME/Desktop/tor_client/hostname ]; then
	#scp -i ~/.ssh/bishkey.pem -r $host_name@$host_ip:/home/$host_name/hostname $HOME/tor_client/
	scp -i $key -r $host_name@$host_ip:/home/$host_name/hostname $HOME/tor_client/
#fi

#echo "file copied"

h_s_file="$HOME/tor_client/hostname"

h_s=`cat $h_s_file`

#echo "contents pasted"


/etc/init.d/tor start
 
#all the traffic from hidden-service(given in h_s running at $port=5061 on server) is redirected to port 9050
curl --socks4a localhost:9050 http://$h_s:$port


