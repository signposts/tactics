#!/bin/sh

server_ip=$(cat $HOME/tactics/config | grep server_ip | awk '{ print $2 }')
password=$(cat `dirname $0`/parameters | grep Password | awk '{ print $2 }')
domain=$(cat `dirname $0`/parameters | grep Domain | awk '{ print $2 }')

iodine -r $server_ip -P $password $domain
