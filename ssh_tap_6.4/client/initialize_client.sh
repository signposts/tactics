#!/bin/sh

dev_num=$(cat `dirname $0`/parameters | grep Dev_num | awk '{ print $2 }')
host_name=$(cat $HOME/tactics/config | grep server_name | awk '{ print $2 }')
host_ip=$(cat $HOME/tactics/config | grep server_ip | awk '{ print $2 }')

tunctl -t tap$dev_num -u $SUDO_USER

ifconfig tap$dev_num 10.0.0.200 up

if [ -e /proc/sys/net/ipv4/ip_forward ]; then
  echo 1 > /proc/sys/net/ipv4/ip_forward 
fi


ssh -v -f -w $dev_num:$dev_num -o Tunnel=Ethernet $host_name@$host_ip true