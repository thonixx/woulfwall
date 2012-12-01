#!/bin/bash

if [ -z "$@" ]
then
	echo "Give me something to search for."
	exit 1
fi

echo `iptables -L -v -n | grep "$@" | grep DROP` > /dev/null && echo "$@ will be dropped"
