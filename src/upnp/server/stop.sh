#!/bin/sh

# Specify internal interface of the router which is connected to NAT. This value is taken from $HOME/tactics/upnp/server/parameters
int_if=$(cat `dirname $0`/parameters | grep int_if | awk '{ print $2 }')

killall upnpd

# Deleting the existing route for multicasting
route del -net 239.0.0.0 netmask 255.0.0.0 $int_if
