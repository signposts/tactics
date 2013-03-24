#!/bin/sh 

if [ -e $HOME/ov_me_client/client.conf ]; then
	rm -rf $HOME/ov_me_client/client.conf
fi

ip=$1
port=$2

cat $HOME/openvpn_client_me/client.conf.template |\
    sed -e "s/\\\$port\\\$/$port/g" -e "s/\\\$ip\\\$/$ip/g" -e "s/\\\$su\\\$/$SUDO_USER/g"|\
    tee $HOME/ov_me_client/client.conf

#/etc/init.d/openvpn start

echo "openvpn started"

cd $HOME/ov_me_client

echo "cding"

openvpn client.conf
