#!/bin/sh
dir="$(dirname $0)"

iptables-restore < "$dir"/iptables.up.rules && echo "restored iptables rules"
echo ""
echo "**** NOW THE GEOBLOCK/RANGES FILE ****"
echo ""
for i in `seq 1 5`
do
	echo -n "$i .. "
	sleep 1
done

# skip geoblock per default
if [ ! "$1" == "geoblock" ]
then
	echo "no geoblock"
	exit 0
fi

# give me script name
script=$(basename $0)
# give me directory where script is in and remove script name
dir=$(echo $0 | sed -e "s/$script//g")

"$dir"geoblock.sh
