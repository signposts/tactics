#!/bin/sh

dev_num=$(cat `dirname $0`/parameters | grep Dev_num | awk '{ print $2 }')

ip link set tun$dev_num up
ip addr add 10.0.0.10 peer 10.0.0.20 dev tun$dev_num
