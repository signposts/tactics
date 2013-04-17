#!/bin/sh

dev_num=4

ip link set tun$dev_num up
ip addr add 10.0.0.1 peer 10.0.0.2 dev tun$dev_num
