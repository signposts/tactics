#!/bin/sh

dev_num=14

if [ -e /proc/sys/net/ipv4/ip_forward ]; then
  echo 1 > /proc/sys/net/ipv4/ip_forward 
fi

ip link set tun$dev_num up
ip addr add 10.0.0.20 peer 10.0.0.10 dev tun$dev_num
