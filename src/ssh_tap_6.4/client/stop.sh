#!/bin/sh
killall -e ssh
dev_num=$(cat `dirname $0`/parameters | grep Dev_num | awk '{ print $2 }')

#Destroying interface
tunctl -d tap$dev_num


