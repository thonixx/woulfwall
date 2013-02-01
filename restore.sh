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

# give me script name
script=$(basename $0)
# give me directory where script is in and remove script name
dir=$(echo $0 | sed -e "s/$script//g")

"$dir"geoblock.sh
