#!/bin/sh
num=$1
if [ $# -ge 2 ];
then
	startpid=$2
else
	startpid=10000
fi

robert="./script/test/test_robert.lua"
i=0
while [ $i -lt $num ];
do
	i=`expr $i + 1`
	pid=`expr $i + $startpid`
	lua ./script/init.lua -f $robert $pid &
done
