#!/bin/sh

# IP of the server machine, this value is taken from $HOME/tactics/config file
server_ip=$(cat $HOME/tactics/config | grep server_ip | awk '{ print $2 }')

# Password to connect to server. This value is taken from $HOME/tactics/iodine_15.4/server/parameters file
password=$(cat `dirname $0`/parameters | grep Password | awk '{ print $2 }')

#Domain name to which server will respond to. Client can only query about this domain name to server. This value is taken from $HOME/tactics/iodine_15.4/server/parameters file
domain=$(cat `dirname $0`/parameters | grep Domain | awk '{ print $2 }')

iodined -n $server_ip -P $password -c 172.16.1.1 $domain #Here, server will establish tunnel with IP 172.16.1.1 of dns interface at server side and clients will be given Ip in the network 172.16.1.0/24. You can change this to any other private network.
