#!/bin/sh

server_ip=$1
password=$2
domain="a.exam.ple"

iodined -f -n $server_ip -P $password -c 172.16.1.1 $domain
