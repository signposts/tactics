#!/bin/sh

port=$(cat `dirname $0`/parameters | grep Port | awk '{ print $2 }')

# Kill tor
kill `sudo lsof -t -i:9050`

# Kill hidden_service
kill `sudo lsof -t -i:$port`
