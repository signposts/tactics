#!/bin/sh

sudo sh `dirname $0`/prior.sh

cd $HOME/ov_me

ln -s openssl-1.0.0.cnf openssl.cnf  #This is for ubuntu version 12.04 and higher

#equivalent to 'source vars'
. $HOME/ov_me/vars

sh `dirname $0`/keygen.sh  


