#!/bin/sh

port=5061

kill `sudo lsof -t -i:9050`

kill `sudo lsof -t -i:$port`
