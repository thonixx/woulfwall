#!/bin/bash
for ip in `curl -s http://www.okean.com/sinokoreacidr.txt | grep -v "#" | awk '{print $1}'` ; do iptables -I INPUT -s $ip -p tcp --dport 22 -j DROP ; done
