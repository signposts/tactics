#!/bin/sh

dev_num1=$(cat `dirname $0`/parameters | grep Dev_num1 | awk '{ print $2 }')
dev_num2=$(cat `dirname $0`/parameters | grep Dev_num2 | awk '{ print $2 }')


if [ -e /proc/sys/net/ipv4/ip_forward ]; then
  echo 1 > /proc/sys/net/ipv4/ip_forward 
fi

ip link set tun$dev_num1 up
ip addr add 10.0.1.100 peer 10.0.1.200 dev tun$dev_num1

ip link set tun$dev_num2 up
ip addr add 192.168.2.1 peer 192.168.2.2 dev tun$dev_num2
