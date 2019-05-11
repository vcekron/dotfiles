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

RES=$(xrandr | grep primary | cut -d " " -f 4)

if [[ $RES == '2560x1440+0+0' ]] ; then
	urxvt -name scratchpad -g 180x26+650-0 -e $SCRIPTPATH/scratchid.sh &
elif [[ $RES == '1920x1080+0+0' ]] ; then
	urxvt -name scratchpad -g 180x26+326-0 -e $SCRIPTPATH/scratchid.sh &
fi
