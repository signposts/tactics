#!/bin/sh

server_ip=$(cat $HOME/tactics/config | grep server_ip | awk '{ print $2 }')

default_gw=$(route | grep UG | grep default | awk '{ print $2}')  #check what is the exist‌ing default gateway

route add -host $server_ip gw $default_gw
route del default
route add default gw 172.16.1.1
