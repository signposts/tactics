#!/bin/sh

dev_num=$1

tunctl -t tap$dev_num -u $SUDO_USER

ifconfig tap$dev_num 10.0.0.100 up
