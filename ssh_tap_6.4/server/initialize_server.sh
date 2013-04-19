#!/bin/sh

dev_num=$(cat `dirname $0`/parameters | grep Dev_num | awk '{ print $2 }')

tunctl -t tap$dev_num -u $SUDO_USER

ifconfig tap$dev_num 10.0.0.100 up
