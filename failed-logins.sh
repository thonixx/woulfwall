#!/bin/bash

# use break as delimiter
IFS="
"

# set threshold
if [ -z "$1" ]
then
	threshold="10"
else
	threshold=$1
fi

# list all failed ips
list=$(grep Failed /var/log/auth.log | egrep -o '[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}' | sort -n | uniq -c | sort -n)

echo ""
printf "  %10s   %s\n" "Counter" "IP address"
for ipl in $list
do
	# take the IP
	ipaddr=$(echo $ipl | egrep -o '[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}')
	
	# take the counter
	counter=$(echo $ipl | awk -F\  '{print $1}')
	
	if [ "$counter" -gt $threshold ]
	then
		# check if IP will be dropped
		if [ "$(iptables -L -v -n | grep $ipaddr | grep DROP)" ]
		then
			printf "  %10s   %s\n" "$counter" "$ipaddr (blocked)"
		else
			printf "  %10s   %s\n" "$counter" "$ipaddr (not yet blocked)"
		fi
	fi
done
echo ""
