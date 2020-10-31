#! /bin/sh

USAGE="usage: bspwmcont [-h] focus-desktop <monitor> <desktop>|focus-next-monitor|node-to-next-monitor|fetch-active-node|bubble-desktop-next|bubble-desktop-prev|bubble-desktop-monitor"

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

# Shift argument indices
shift $((OPTIND-1))

# Input arguments
COMMAND=$1

case $COMMAND in
	"focus-desktop")
		TARGET=$2
		bspc desktop -a "$TARGET" && exit
		[[ $(bspc query -D -d "$TARGET".active) ]] && exit
		bspc desktop -f "$TARGET"
		exit
		;;
esac

# Fetch IDs
SCRATCHID=$(cat /tmp/scratchid)

# Check for proper scratchpad
[[ $(xprop -id $SCRATCHID WM_CLASS | cut -d'"' -f2) = "scratchpad" ]] && SCRATCHPAD=1

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
		focused=$(bspc query -D -d --names)
		next=$(bspc query -D -d next.local --names)
		bspc desktop -s next.local --follow -n ${next} && bspc desktop prev.local -n ${focused}
		;;
	"bubble-desktop-prev")
		focused=$(bspc query -D -d --names)
		prev=$(bspc query -D -d prev.local --names)
		bspc desktop -s prev.local --follow -n ${prev} && bspc desktop next.local -n ${focused}
		;;
	"bubble-desktop-monitor")
		focused=$(bspc query -D -d --names)
		next=$(bspc query -D -d next:focused --names)
		bspc desktop -s next:focused --follow -n ${next} && bspc desktop next:focused -n ${focused}
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
