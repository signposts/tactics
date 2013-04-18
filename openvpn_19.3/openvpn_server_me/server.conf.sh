#!/bin/sh 

#removing already existing server.conf file and creating a new one
if [ -e $HOME/ov_me/server.conf ]; then
	rm -rf $HOME/ov_me/server.conf
fi

#give port number on which server should listen, 5060 here
port=5060

cat `dirname $0`/server.conf.template |\
    sed -e "s/\\\$port\\\$/$port/g" |\
    tee $HOME/ov_me/server.conf

#/etc/init.d/openvpn start

cd $HOME/ov_me

#starting openvpn for server
openvpn server.conf
