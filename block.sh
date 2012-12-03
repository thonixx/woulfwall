#!/bin/bash

echo $(echo $@ | egrep -o '[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}') >> iptables.ranges
