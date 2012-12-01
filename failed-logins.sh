#!/bin/bash

cat /var/log/auth.log | grep Failed | egrep -o '[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}' | sort -n | uniq -c | sort -n
