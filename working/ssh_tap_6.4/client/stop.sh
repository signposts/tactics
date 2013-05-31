#!/bin/sh

dev_num=$(cat `dirname $0`/parameters | grep Dev_num | awk '{ print $2 }')

#Destroying interface
tunctl -d tap$dev_num

killall -e ssh
