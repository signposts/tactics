#!/bin/sh

dev_num=$(cat `dirname $0`/parameters | grep Dev_num | awk '{ print $2 }')
#host_name=$2
host_ip=$(cat $HOME/tactics/config | grep server_ip | awk '{ print $2 }')

if [ -e /proc/sys/net/ipv4/ip_forward ]; then
  echo 1 > /proc/sys/net/ipv4/ip_forward 
fi

#tunctl -u $SUDO_USER -t tun$dev_num

ssh -v -f -w $dev_num:$dev_num -o Tunnel=point-to-point root@$host_ip true

dev_num=$(cat `dirname $0`/parameters | grep Dev_num | awk '{ print $2 }')

# For client 1....comment this for client1
ip link set tun$dev_num up
ip addr add 10.0.1.200 peer 10.0.1.100 dev tun$dev_num

#For client2......comment this for client1
#ip link set tun$dev_num up
#ip addr add 192.168.2.1 peer 192.168.2.2 dev tun$dev_num
