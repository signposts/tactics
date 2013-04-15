#!/bin/sh

server_ip=$1
password=$2
domain="a.exam.ple"

iodine -f -r $server_ip -P $password $domain
