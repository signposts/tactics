#!/bin/sh

cp -R `dirname $0`/ $HOME/tactics/working

tactic_name=$1

#echo $tactic_name
temp=$(grep -wci "$tactic_name" $HOME/tactics/index)
#echo $temp
if [ $temp = 0 ]; then
	echo $tactic_name >> $HOME/tactics/index
else
	echo "Tactic already exist"
fi

