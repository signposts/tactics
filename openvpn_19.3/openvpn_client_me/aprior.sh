#!/bin/sh 

#this will create keys with $SUDO_USER name of the client

host_name=$(cat $HOME/tactics/config | grep server_name | awk '{ print $2 }')
host_ip=$(cat $HOME/tactics/config | grep server_ip | awk '{ print $2 }')

if [ -d $HOME/ov_me_client ]; then
	rm -rf $HOME/ov_me_client
fi

mkdir $HOME/ov_me_client

scp -i ~/.ssh/bishkey.pem -r $host_name@$host_ip:/home/$host_name/ov_me/ca.crt $HOME/ov_me_client/
echo "ca.crt copied"

scp -i ~/.ssh/bishkey.pem -r $host_name@$host_ip:/home/$host_name/ov_me/keys/$SUDO_USER.crt $HOME/ov_me_client/
echo "$SUDO_USER.crt copied"

scp -i ~/.ssh/bishkey.pem -r $host_name@$host_ip:/home/$host_name/ov_me/keys/$SUDO_USER.key $HOME/ov_me_client/
echo "$SUDO_USER.key copied"

scp -i ~/.ssh/bishkey.pem -r $host_name@$host_ip:/home/$host_name/ov_me/ta.key $HOME/ov_me_client/
echo "ta.key copied"
