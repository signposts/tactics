#!/bin/csh

#cd $HOME/ov_me

#source vars

#generating keys for server, and client

#Keys are generated for the name specified in this parameter. This value is taken from HOME/tactics/openvpn_19.3/server/parameters
client1_name=$(cat `dirname $0`/parameters | grep Host_name1 | awk '{ print $2 }') # Name of client 1
client2_name=$(cat `dirname $0`/parameters | grep Host_name2 | awk '{ print $2 }') # Name of client 1

./clean-all

./build-dh

./pkitool --initca

./pkitool --server server



cd keys

openvpn --genkey --secret ta.key

cp server.crt server.key ca.crt dh1024.pem ta.key $HOME/ov_me

cd ..

#generating keys specific to each client
./pkitool $client1_name  
./pkitool $client2_name

chmod -R 777 $HOME/ov_me

# NOTE: Name of both the clients should be DIFFERENT
