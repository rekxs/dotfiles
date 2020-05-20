#!/usr/bin/env sh

#
# ~/Documents/cs/scripts/wm/vol.sh
#

case "$1" in
	get)
		;;
	mute)
		amixer set Master toggle
		;;
	dec)
		amixer set Master 5%-
		;;
	inc)
		amixer set Master 5%+
		;;
	*)
		exit 1
		;;
esac

vol_lvl=`amixer sget Master | awk -F '[%[]' '/Left/ { print $2 }'`

if [ "`amixer sget Master | awk -F '[][]' '/Left/ { print $4 }'`" == "off" ] || [ $vol_lvl -lt 1 ]; then
	vol="  $vol_lvl%"
elif [ $vol_lvl -lt 50 ]; then
	vol="  $vol_lvl%"
else
	vol="  $vol_lvl%"
fi

if [ $1 == "get" ]; then
	echo -n "$vol"
else
	id=`cat ~/.cache/osd_id`
	if [ $id -gt 0 ]; then
		dunstify -p -r $id -t 200 "$vol" > ~/.cache/osd_id
	else
		dunstify -p -t 200 "$vol" > ~/.cache/osd_id
	fi
fi

exit 0
