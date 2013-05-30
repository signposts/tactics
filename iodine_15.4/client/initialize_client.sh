#!/bin/sh

# IP of the server machine, this value is taken from $HOME/tactics/config file
server_ip=$(cat $HOME/tactics/config | grep server_ip | awk '{ print $2 }') 

# Password to connect to server. This value is taken from $HOME/tactics/iodine_15.4/client/parameters file
password=$(cat `dirname $0`/parameters | grep Password | awk '{ print $2 }') 

#Domain name to which server will respond to. Client can only query about this domain name to server. This value is taken from $HOME/tactics/iodine_15.4/client/parameters file
domain=$(cat `dirname $0`/parameters | grep Domain | awk '{ print $2 }')

iodine -r -P $password $domain # In this iodine query will pass through nameserver in /etc/resolv.conv to reach fakens which is the iodine server.

#iodine -r IP_of_NS -P $password $domain #If you want iodine query to pass through a specific Nameserver other than a default, mention its Ip as IP_of_NS

#subd.mooo.com # this domain name is registered at freedns.afraid.org/subdomain/edit.php


