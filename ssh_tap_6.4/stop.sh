#!/bin/sh

dev_num=3

kill `sudo lsof -t -i:22`

tunctl -d tap$dev_num
