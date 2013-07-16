#!/bin/sh

# Specify number for the tap interface. This value is taken from $HOME/tactics/ssh_tap_6.4/client/parameters 
dev_num=$(cat `dirname $0`/parameters | grep Dev_num | awk '{ print $2 }')

# name of the server machine, this value is taken from $HOME/tactics/config file
host_name=$(cat $HOME/tactics/config | grep server_name | awk '{ print $2 }')

# IP of the server machine, this value is taken from $HOME/tactics/config file
host_ip=$(cat $HOME/tactics/config | grep server_ip | awk '{ print $2 }')

# Key which was generated to connect client and server without password. This value is taken from $HOME/tactics/config file
key=$(cat $HOME/tactics/config | grep path_to_key | awk '{ print $2 }')

#setting tap interface with given number as persistent
tunctl -t tap$dev_num -u $SUDO_USER

#For client1...comment this for client2
ifconfig tap$dev_num 10.0.0.200/24 up

#For client2...comment this for client1
#ifconfig tap$dev_num 192.168.1.2/24 up

if [ -e /proc/sys/net/ipv4/ip_forward ]; then
  echo 1 > /proc/sys/net/ipv4/ip_forward 
fi

#Starting ssh
ssh -v -f -i $key -w $dev_num:$dev_num -o Tunnel=Ethernet $host_name@$host_ip true
