#!/usr/bin/env bash 

host_name=$1
host_ip=$2
port=$3

#creating a directory `tor_client` where `hostaname` containing domain name of hidden-service is copied
if [ -d $HOME/tor_client ]; then
	rm -rf $HOME/tor_client
fi

mkdir $HOME/tor_client

chmod 777 $HOME/tor_client

#if [ ! -e $HOME/Desktop/tor_client/hostname ]; then
	scp -i ~/.ssh/bishkey.pem -r $1@$2:/home/$1/hostname $HOME/tor_client/
#fi

echo "file copied"

h_s_file="$HOME/tor_client/hostname"

h_s=`cat $h_s_file`

echo "contents pasted"

/etc/init.d/tor start
 
#all the traffoc from hidden-service(given in h_s running at $port=5061 on server) is redirected to port 9050
curl --socks4a localhost:9050 http://$h_s:$port


