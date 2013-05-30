#!/bin/sh 

#if there already exists ov_me directory containing files for keys and vars, remove it and create a new one
if [ -d $HOME/ov_me ]; then
	rm -rf $HOME/ov_me
fi

mkdir $HOME/ov_me

#copy all scripts which help in generating keys to the directory created above
cp -r /usr/share/doc/openvpn/examples/easy-rsa/2.0/* $HOME/ov_me

#this will change owner to hostname of the machine (ubuntu in this case)
chown -R $SUDO_USER $HOME/ov_me

#removing by default created vars file so that user can create his own with parameters given on command line
rm -rf $HOME/ov_me/vars

#This value is taken from $HOME/tactics/openvpn_19.3/server/parameters
KC=$(cat `dirname $0`/parameters | grep Country_name | awk '{ print $2 }')
KP=$(cat `dirname $0`/parameters | grep Province_name | awk '{ print $2 }')
Kc=$(cat `dirname $0`/parameters | grep City_name | awk '{ print $2 }')
KO=$(cat `dirname $0`/parameters | grep Origin_name | awk '{ print $2 }')
KE=$(cat `dirname $0`/parameters | grep Email | awk '{ print $2 }')


#making vars with user's own parameters
cat `dirname $0`/vars.template |\
    sed -e "s/\\\$KC\\\$/$KC/g" -e "s/\\\$KP\\\$/$KP/g" -e "s/\\\$Kc\\\$/$Kc/g"\
    -e "s/\\\$KO\\\$/$KO/g" -e "s/\\\$KE\\\$/$KE/g" |\
    tee $HOME/ov_me/vars




