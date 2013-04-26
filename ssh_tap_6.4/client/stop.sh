#!/bin/sh

dev_num=$(cat `dirname $0`/parameters | grep Dev_num | awk '{ print $2 }')

#kill `sudo lsof -t -i:22`

tunctl -d tap$dev_num

killall -e ssh
