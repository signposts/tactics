#!/bin/sh

killall -e sshd

dev_num1=$(cat `dirname $0`/parameters | grep Dev_num1 | awk '{ print $2 }')
dev_num2=$(cat `dirname $0`/parameters | grep Dev_num2 | awk '{ print $2 }')

#kill `sudo lsof -t -i:22`

tunctl -d tap$dev_num1
tunctl -d tap$dev_num2

killall -e sshd
