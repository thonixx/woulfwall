#!/bin/sh
iptables-restore < iptables.up.rules && echo "restored iptables rules"
echo ""
echo "**** NOW THE GEOBLOCK/RANGES FILE ****"
echo ""
for i in `seq 1 5`
do
	echo -n "$i .. "
	sleep 1
done

./geoblock.sh
