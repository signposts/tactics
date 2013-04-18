#!/bin/sh

dev_num=14

ip link set tun$dev_num up
ip addr add 10.0.0.10 peer 10.0.0.20 dev tun$dev_num
