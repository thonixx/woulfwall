#!/bin/bash

if [ "$(echo $@ | egrep -o '[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}')" ]
then
	ip=$(echo $@ | egrep -o '[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}')
	echo "$ip" >> iptables.ranges
	iptables -I INPUT -s $ip -p tcp --dport 22 -j DROP
	iptables -I INPUT -s $ip -p tcp --dport 25 -j DROP
	iptables -I INPUT -s $ip -p tcp --dport 993 -j DROP
	iptables -I INPUT -s $ip -p tcp --dport 995 -j DROP
	echo "added to block list"
	exit 0
else
	echo "not an ip?"
	exit 1
fi
