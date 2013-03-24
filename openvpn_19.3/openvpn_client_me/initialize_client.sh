#!/bin/sh 

#this will create keys with $SUDO_USER name of the client

host_name=$1
host_ip=$2

if [ -d $HOME/ov_me_client ]; then
	rm -rf $HOME/ov_me_client
fi

mkdir $HOME/ov_me_client

scp -i ~/.ssh/bishkey.pem -r $1@$2:/home/$1/ov_me/ca.crt $HOME/ov_me_client/
echo "ca.crt copied"

scp -i ~/.ssh/bishkey.pem -r $1@$2:/home/$1/ov_me/keys/$SUDO_USER.crt $HOME/ov_me_client/
echo "$SUDO_USER.crt copied"

scp -i ~/.ssh/bishkey.pem -r $1@$2:/home/$1/ov_me/keys/$SUDO_USER.key $HOME/ov_me_client/
echo "$SUDO_USER.key copied"

scp -i ~/.ssh/bishkey.pem -r $1@$2:/home/$1/ov_me/ta.key $HOME/ov_me_client/
echo "ta.key copied"
