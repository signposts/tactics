#!/usr/bin/env bash 

#this script change permission of hidden_service. Note: hidden_service folder is created after tor is started, so run this script after tor_s. Also, this script copies hostname to the HOME directory.

chmod 777 $HOME/tor/hidden_service/

if [ -e $HOME/hostname ]; then
	rm $HOME/hostname
fi

cp $HOME/tor/hidden_service/hostname $HOME/

chmod 777 $HOME/hostname
echo "hiii"
