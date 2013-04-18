#!/bin/sh

dev_num=14
#host_name=$2
host_ip=$(cat $HOME/tactics/config | grep server_ip | awk '{ print $2 }')

if [ -e /proc/sys/net/ipv4/ip_forward ]; then
  echo 1 > /proc/sys/net/ipv4/ip_forward 
fi

#tunctl -u $SUDO_USER -t tap$dev_num

ssh -v -w $dev_num:$dev_num -o Tunnel=point-to-point root@$host_ip
