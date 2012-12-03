#!/bin/bash

if [ -z "$@" ]
then
	echo "Give me something to search for."
	exit 1
fi

if [ "$(echo `iptables -L -v -n | grep "$@" | grep DROP`)" ]
then
	echo "$@ will be dropped"
else
	echo "$@ will not be dropped"
fi
