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

# get value for reverse lookup
if [ "$2" == "rev" ]
then
	reverse=true
	revtext="Reverse"
	revstar="*******"
else
	reverse=false
	revtext=""
	revstart=""
fi

# list all failed ips
list=$(grep Failed /var/log/auth.log | egrep -o '[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}' | sort -n | uniq -c | sort -n)

echo ""
# printf used for column thing
printf "  %10s   %-40s %s\n" "Counter" "IP address" "$revtext"
printf "  %10s   %-40s %s\n" "*******" "**********" "$revstar"
for ipl in $list
do
	# take the IP
	ipaddr=$(echo $ipl | egrep -o '[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}')

        # give me the reverse output
	if [ "`which resolveip`" ]
	then
		ipreverse=$(resolveip -s $ipaddr 2> /dev/null)
	else
		ipreverse="No \"resolveip\" installed."
	fi
        
        # check the reverse output
        if [ -z "$ipreverse" ]
        then
                ipreverse="No reverse entry specified"
        fi
	
	# take the counter
	counter=$(echo $ipl | awk -F\  '{print $1}')
	
	if [ "$counter" -gt $threshold ]
	then
		# check if IP will be dropped
		if [ "$(iptables -L -v -n | grep $ipaddr | grep DROP)" ]
		then
			if [ $reverse == true ]
			then
				printf "  %10s   %-40s %s\n" "$counter" "$ipaddr (blocked)" "$ipreverse"
			else
				printf "  %10s   %-40s\n" "$counter" "$ipaddr (blocked)"
			fi
		else
			if [ $reverse == true ]
			then
				printf "  %10s   %-40s %s\n" "$counter" "$ipaddr" "$ipreverse"
			else
				printf "  %10s   %-40s\n" "$counter" "$ipaddr"
			fi
		fi
	fi
done
echo ""
