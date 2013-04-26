#!/bin/csh

#cd $HOME/ov_me

#source vars

#generating keys for server, and client

client1_name=$(cat `dirname $0`/parameters | grep Host_name1 | awk '{ print $2 }')
client2_name=$(cat `dirname $0`/parameters | grep Host_name2 | awk '{ print $2 }')

./clean-all

./build-dh

./pkitool --initca

./pkitool --server server



cd keys

openvpn --genkey --secret ta.key

cp server.crt server.key ca.crt dh1024.pem ta.key $HOME/ov_me

cd ..

./pkitool $client1_name  
./pkitool $client2_name

chmod -R 777 $HOME/ov_me
