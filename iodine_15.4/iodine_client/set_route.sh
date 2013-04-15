#!/bin/sh

server_ip=$1

default_gw=$(route | grep UG | grep default | awk '{ print $2}')  #check what is the exist‌ing default gateway

route add -host $server_ip gw $default_gw
route del default
route add default gw 172.16.1.1
