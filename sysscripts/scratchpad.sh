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

if [[ "$HOSTNAME" == TUE009888 ]] ; then
	case $(xrandr | grep " connected " | wc -l) in
		2)
			if [[ $(xrandr | grep DP-4 | grep "disconnected") ]]; then
				RES=$(xrandr | grep DP-0 | cut -d " " -f 3) # NVIDIA HDMI
			else
				RES=$(xrandr | grep DP-4 | cut -d " " -f 3) # NVIDIA USB-C
			fi
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
		urxvt -name scratchpad -g 132x29+650-0 -e $SCRIPTPATH/scratchid.sh &
		;;
	'2560x1440+1920+0')
		if [[ "$HOSTNAME" == TUE009888 ]] ; then
			urxvt -name scratchpad -g 124x29+326-360 -e $SCRIPTPATH/scratchid.sh &
		else
			urxvt -name scratchpad -g 124x29+326+629 -e $SCRIPTPATH/scratchid.sh &
		fi
		;;
	'1920x1200+1920+0')
		urxvt -name scratchpad -g 124x29+326-120 -e $SCRIPTPATH/scratchid.sh &
		;;
	'1920x1200+0+0')
		urxvt -name scratchpad -g 124x29+326-0 -e $SCRIPTPATH/scratchid.sh &
		;;
	'1920x1080+0+0'|'1920x1080+1920+0')
		urxvt -name scratchpad -g 124x26+326-0 -e $SCRIPTPATH/scratchid.sh &
		;;
esac
