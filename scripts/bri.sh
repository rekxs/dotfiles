#!/usr/bin/env sh

#
# ~/Documents/cs/scripts/wm/bri.sh
#

xbacklight -get &> /dev/null
[ $? -gt 0 ] && exit

case "$1" in
	dec)
		xbacklight -dec 5
		;;
	inc)
		xbacklight -inc 5
		;;
	*)
		exit 1
		;;
esac

id=`cat ~/.cache/osd_id`
if [ $id -gt 0 ]; then
	dunstify -p -r $id -t 200 "  `xbacklight -get | awk '{ print int($1 + 0.5) }'`%" > ~/.cache/osd_id
else
	dunstify -p -t 200 "  `xbacklight -get | awk '{ print int($1 + 0.5) }'`%" > ~/.cache/osd_id
fi

exit 0