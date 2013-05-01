#!/bin/sh

dev_num1=$(cat `dirname $0`/parameters | grep Dev_num1 | awk '{ print $2 }')
dev_num2=$(cat `dirname $0`/parameters | grep Dev_num2 | awk '{ print $2 }')

tunctl -t tap$dev_num1 -u $SUDO_USER
tunctl -t tap$dev_num2 -u $SUDO_USER

ifconfig tap$dev_num1 10.0.0.100/24 up
ifconfig tap$dev_num2 192.16.1.1/24 up
