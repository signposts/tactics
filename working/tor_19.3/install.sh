#!/bin/sh

apt-get install tor
apt-get install curl

kill `sudo lsof -t -i:9050`
