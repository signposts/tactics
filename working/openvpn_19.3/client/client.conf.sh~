#!/bin/sh 

ip=$(cat $HOME/tactics/config | grep server_ip | awk '{ print $2 }')
port=5060

if [ -e $HOME/ov_me_client/client.conf ]; then
	rm -rf $HOME/ov_me_client/client.conf
fi


cat `dirname $0`/client.conf.template |\
    sed -e "s/\\\$port\\\$/$port/g" -e "s/\\\$ip\\\$/$ip/g" -e "s/\\\$su\\\$/$SUDO_USER/g"|\
    tee $HOME/ov_me_client/client.conf

#/etc/init.d/openvpn start

echo "openvpn started"

cd $HOME/ov_me_client

echo "cding"

openvpn client.conf
