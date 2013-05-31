#!/bin/sh

# Specify full path to jar file. This value is taken from $HOME/tactics/upnp/client/parameters
path=$(cat `dirname $0`/parameters | grep path_jar | awk '{ print $2 }')

# Specify Private IP of the internal upnp client.This value is taken from $HOME/tactics/upnp/client/parameters
ip=$(cat `dirname $0`/parameters | grep IP_client | awk '{ print $2 }')

# Specify internal port on which request is forwarded by upnp router to upnp client. This value is taken from $HOME/tactics/upnp/client/parameters
int_port=$(cat `dirname $0`/parameters | grep int_port | awk '{ print $2 }')

# Specify external port on upnp router which request comes from internet. This value is taken from $HOME/tactics/upnp/client/parameters
ext_port=$(cat `dirname $0`/parameters | grep ext_port | awk '{ print $2 }')

#Specify protocol for which port mapping is added. This value is taken from $HOME/tactics/upnp/client/parameters
protocol=$(cat `dirname $0`/parameters | grep Protocol | awk '{ print $2 }')

# Adding port mapping
java -jar $path -a $ip $int_port $ext_port $protocol
