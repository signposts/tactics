#!/bin/csh

#cd $HOME/ov_me

#source vars

#generating keys for server, and client

host_name=$(cat `dirname $0`/parameters | grep Host_name | awk '{ print $2 }')

./clean-all

./build-dh

./pkitool --initca

./pkitool --server server



cd keys

openvpn --genkey --secret ta.key

cp server.crt server.key ca.crt dh1024.pem ta.key $HOME/ov_me

cd ..

./pkitool $host_name  # give hostaname(name by which it has account in machine, should be same as $SUDO_USER) of the CLIENT

chmod -R 777 $HOME/ov_me
