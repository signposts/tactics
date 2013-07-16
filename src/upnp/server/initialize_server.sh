#!/bin/sh

# Specify internal interface of the router which is connected to NAT. This value is taken from $HOME/tactics/upnp/server/parameters
int_if=$(cat `dirname $0`/parameters | grep int_if | awk '{ print $2 }')

# Specify external interface of the router which is connected to internet. This value is taken from $HOME/tactics/upnp/server/parameters
ext_if=$(cat `dirname $0`/parameters | grep ext_if | awk '{ print $2 }')

# Multicast route to the internal interface is added so that device dicovery can function properly
route add -net 239.0.0.0 netmask 255.0.0.0 $int_if

# This is needed as libupnp was installed in /usr/local/lib instead of /usr/lib 
export LD_LIBRARY_PATH=/usr/local/lib

# Starting upnp daemon
upnpd $ext_if $int_if
#Use upnpd -f $ext_if $int_if to start upnpd on terminal. This is good for debugging as error msgs will be seen on terminal.
