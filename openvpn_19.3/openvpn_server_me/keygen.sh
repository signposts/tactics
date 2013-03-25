#!/bin/csh

#cd $HOME/ov_me

#source vars

#generating keys for server, and client

./clean-all

./build-dh

./pkitool --initca

./pkitool --server server

cd keys

openvpn --genkey --secret ta.key

cp server.crt server.key ca.crt dh1024.pem ta.key $HOME/ov_me

cd ..

./pkitool $1  # give hostaname(name by which it has account in machine, should be same as $SUDO_USER) of the CLIENT

