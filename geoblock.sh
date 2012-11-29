#!/bin/bash

# custom ip ranges
ranges=$(cat iptables.ranges)

# curling file
for ip in `curl -s http://www.okean.com/sinokoreacidr.txt | grep -v "#" | awk '{print $1}'` $ranges
do 
	echo "Blocking $ip"
	iptables -I INPUT -s $ip -p tcp --dport 22 -j DROP
done
