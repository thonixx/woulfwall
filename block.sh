#!/bin/bash

# give me script name
script=$(basename $0)
# give me directory where script is in and remove script name
dir=$(echo $0 | sed -e "s/$script//g")

if [ "$(echo $@ | egrep -o '[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}')" ]
then
	# simple test for ip
	ip=$(echo $@ | egrep -o '[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}')
	# write to custom ranges file for restore
	echo "$ip" >> "$dir"iptables.ranges

	# go through the ports which should be blocked instead of total block
	for port in 22 25 465 993 995
	do
		iptables -I INPUT -s $ip -p tcp --dport $port -j DROP
	done
	# print some message
	echo "added to block list"
	exit 0
else
	# print if it doesnt look like an ip
	echo "not an ip?"
	exit 1
fi
