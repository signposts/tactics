#!/usr/bin/env bash 

#dir=$1
port=$(cat `dirname $0`/parameters | grep Port | awk '{ print $2 }')

#running server at port 5061
python -m SimpleHTTPServer $port &

cat `dirname $0`/tor.conf.template |\
    sed -e "s|\\\$dir\\\$|$HOME/tor/hidden_service|g" -e "s/\\\$port\\\$/$port/g" |\
    tee `dirname $0`/tor.conf

#creating directory where hidden service folder containing hostname will be placed
if [ -d $HOME/tor ]; then
	rm -rf $HOME/tor
fi

mkdir $HOME/tor

#changing pemission for the folder so that hidden_service folder can be placed by tor when tor starts
chmod 777 $HOME/tor

#echo "Permission changedddd"

#if [ -d $HOME/tor/hidden_service ]; then
#	rm -rf $HOME/tor/hidden_service
#fi

#mkdir $HOME/tor/hidden_service

#echo "Directory createdddddd"

#chown -R $USER $HOME/tor_me/hidden_service
#chmod 777 $HOME/tor/hidden_service

#eecho "Permission changed"
tor -f `dirname $0`/tor.conf
#starting tor
#/etc/init.d/tor start 

sleep 10

chmod 777 $HOME/tor/hidden_service/

if [ -e $HOME/hostname ]; then
	rm $HOME/hostname
fi

cp $HOME/tor/hidden_service/hostname $HOME/

chmod 777 $HOME/hostname








