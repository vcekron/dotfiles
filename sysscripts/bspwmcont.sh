#! /bin/sh

USAGE="usage: bspwmcont [-h] focus-next-monitor|node-to-next-monitor|fetch-active-node|bubble-desktop-next|bubble-desktop-prev|bubble-desktop-monitor"

# Input flags
while getopts "h" opt; do

	case $opt in
		h)
			echo "$USAGE"
			exit
			;;
		\?)
			>&2 echo -e "bspwmcont: invalid option -- '$OPTARG'\n$USAGE"
			exit 1
			;;
	esac

done

# Fetch IDs
SCRATCHID=$(cat /tmp/scratchid)

# Check for proper scratchpad
[[ $(xprop -id $SCRATCHID WM_CLASS | cut -d'"' -f2) = "scratchpad" ]] && SCRATCHPAD=1

# Shift argument indices
shift $((OPTIND-1))

# Input argument
COMMAND=$1

# Remove scratchpad sitcky flag
[[ $SCRATCHPAD ]] && bspc node $SCRATCHID --flag sticky=off

case $COMMAND in
	"focus-next-monitor")
		bspc monitor -f next
		[[ $SCRATCHPAD ]] && bspc node $SCRATCHID -m focused -f
		;;
	"node-to-next-monitor")
		bspc node -m next --follow
		[[ $SCRATCHPAD ]] && bspc node $SCRATCHID -m focused
		;;
	"fetch-active-node")
		bspc node @next:focused:.active -m focused
		;;
	"bubble-desktop-next")
		bspc node @focused:/ -s @next.local:/ --follow || bspc node @/ -d next.local --follow
		;;
	"bubble-desktop-prev")
		bspc node @focused:/ -s @prev.local:/ --follow || bspc node @/ -d prev.local --follow
		;;
	"bubble-desktop-monitor")
		bspc node @focused:/ -s @next:focused:/ --follow || bspc node @/ -d next:focused --follow
		;;
	"")
		>&2 echo -e "bspwmcont: no command\n$USAGE"
		;;
	*)
		>&2 echo -e "bspwmcont: invalid command -- '$COMMAND'\n$USAGE"
		;;
esac

# Set scratchpad sticky flag
[[ $SCRATCHPAD ]] && bspc node $SCRATCHID --flag sticky=on
