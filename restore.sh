#!/bin/sh
iptables-restore < iptables.up.rules && echo "restored iptables rules"
