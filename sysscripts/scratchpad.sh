#! /bin/sh

SCRIPTPATH="$0"
while [ -h "$SCRIPTPATH" ]; do
	SCRIPTDIR="$(cd -P "$(dirname "$SCRIPTPATH")" >/dev/null && pwd)"
	SCRIPTPATH="$(readlink "$SCRIPTPATH")"
	[[ $SCRIPTPATH != /* ]] && SOURCE="$SCRIPTDIR/$SCRIPTPATH"
done
SCRIPTPATH="$(cd -P "$(dirname "$SCRIPTPATH")" >/dev/null && pwd)"

if [[ ! -f "$SCRIPTPATH/scratchid.sh" ]]; then
	>&2 echo "could not find scratchid.sh"
	exit 1
fi

OLD=$(xdo id -n "scratchpad")

if [[ $OLD ]] ; then
	bspc node $OLD --flag locked=off
	xdo close $OLD
	rm /tmp/scratchid
fi

if [[ "$HOSTNAME" == fjorgyn ]] ; then
	case $(xrandr | grep " connected " | wc -l) in
		2)
			RES=$(xrandr | grep HDMI-1 | cut -d " " -f 3)
			;;
		*)
			RES=$(xrandr | grep primary | cut -d " " -f 4)
			;;
	esac
else
	RES=$(xrandr | grep primary | cut -d " " -f 4)
fi

case $RES in
	'2560x1440+0+0')
		urxvt -name scratchpad -g 132x26+650-0 -e $SCRIPTPATH/scratchid.sh &
		;;
	'1920x1200+1920+0')
		urxvt -name scratchpad -g 124x29+326-120 -e $SCRIPTPATH/scratchid.sh &
		;;
	'1920x1200+0+0')
		urxvt -name scratchpad -g 124x29+326-0 -e $SCRIPTPATH/scratchid.sh &
		;;
	'1920x1080+0+0')
		urxvt -name scratchpad -g 124x26+326-0 -e $SCRIPTPATH/scratchid.sh &
		;;
esac
