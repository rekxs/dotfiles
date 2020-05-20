#!/usr/bin/env sh

#
# ~/Documents/cs/scripts/wm/mpd.sh
#

mpc &> /dev/null
[ $? -gt 0 ] && exit

case "$1" in
	get)
		;;
	toggle)
		mpc toggle &> /dev/null
		echo "`mpc`" | tail -n 2 | grep -q "playing" || exit
		;;
	stop)
		mpc stop &> /dev/null
		exit 0
		;;
	prev)
		mpc prev &> /dev/null
		;;
	next)
		mpc next &> /dev/null
		;;
	*)
		exit 1
		;;
esac

mpc | head -n 1 | grep -q "consume:"
if [ $? -eq 0 ]; then
	mps=""
else
	mps="  `mpc | head -n 1 | tr -d '\n'`"
fi

if [ $1 == "get" ]; then
	echo -n "$mps"
else
	id=`cat ~/.cache/osd_id`
	if [ $id -gt 0 ]; then
		dunstify -p -r $id -t 200 "$mps" > ~/.cache/osd_id
	else
		dunstify -p -t 200 "$mps" > ~/.cache/osd_id
	fi
fi

exit 0