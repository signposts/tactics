#!/bin/sh

port=$(cat `dirname $0`/parameters | grep Port | awk '{ print $2 }')

kill `sudo lsof -t -i:$port`
