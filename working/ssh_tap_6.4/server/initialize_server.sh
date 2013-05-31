#!/bin/sh

# Specify number for the tap interface. This value is taken from $HOME/tactics/ssh_tap_6.4/server/parameters
dev_num1=$(cat `dirname $0`/parameters | grep Dev_num1 | awk '{ print $2 }')
dev_num2=$(cat `dirname $0`/parameters | grep Dev_num2 | awk '{ print $2 }')

#Setting tap interfaces with the specified numbers as persistent
tunctl -t tap$dev_num1 -u $SUDO_USER
tunctl -t tap$dev_num2 -u $SUDO_USER

#Configuiring the interfaces. Both clients should be in different networks/subnetworks
#ifconfig tap$dev_num1 10.0.0.100/24 up
#ifconfig tap$dev_num2 192.168.1.1/24 up
