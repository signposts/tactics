#!/bin/sh

sudo sh `dirname $0`/prior.sh

cd $HOME/ov_me

#sudo mkdir abc
. $HOME/ov_me/vars

sh `dirname $0`/keygen.sh  


