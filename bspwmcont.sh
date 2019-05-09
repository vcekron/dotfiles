#! /bin/sh

USAGE="usage: bspwmcont [-h] focus_next_monitor|node_to_next_monitor|fetch_active_node|bubble_desktop_next|bubble_desktop_prev|bubble_desktop_monitor"

# Input flags
while getopts "h" opt; do

	case $opt in
		h)
			echo "$USAGE"
			exit
			;;
		\?)
			>&2 echo -e "invalid option -- '$OPTARG'\n$USAGE"
			exit 1
			;;
	esac

done

# Fetch IDs
SCRATCHID=$(cat /tmp/scratchid)
MONITORS=$(bspc query -M)
FOCUSED=$(bspc query -N -n)

# Check for proper scratchpad
if [[ $(xprop -id $SCRATCHID WM_CLASS | cut -d'"' -f2) = "scratchpad" ]]; then
	SCRATCHPAD=1
fi

# Shift argument indices
shift $((OPTIND-1))

# Input argument
COMMAND=$1

# Set sequencial desktop names
rename () {
	for monitor in $MONITORS; do
		desktops=$(eval bspc query -m $monitor -D | wc -l)
		eval bspc monitor $monitor -d $(seq -s ' ' $desktops)
	done
}

# Remove scratchpad sitcky flag
[[ -z $SCRATCHPAD ]] || bspc node $SCRATCHID --flag sticky=off

case $COMMAND in
	"focus_next_monitor")
		bspc monitor -f next
		[[ -z $SCRATCHPAD ]] || bspc node $SCRATCHID -m focused
		if [[ $SCRATCHPAD && $FOCUSED = $SCRATCHID ]];then
			bspc node -f $SCRATCHID
		fi
		;;
	"node_to_next_monitor")
		bspc node -m next --follow
		[[ -z $SCRATCHPAD ]] || bspc node $SCRATCHID -m focused
		;;
	"fetch_active_node")
		bspc node @next:focused:.active -m focused
		;;
	"bubble_desktop_next")
		#bspc desktop focused -s next.local
		#rename
		bspc node @focused:/ -s @next.local:/ --follow
		if [[ $? = 1 ]]; then
			bspc node @/ -d next.local --follow
		fi
		;;
	"bubble_desktop_prev")
		#bspc desktop focused -s prev.local
		#rename
		bspc node @focused:/ -s @prev.local:/ --follow
		if [[ $? = 1 ]]; then
			bspc node @/ -d prev.local --follow
		fi
		;;
	"bubble_desktop_monitor")
		#bspc desktop focused -s next:focused --follow
		#rename
		bspc node @focused:/ -s @next:focused:/ --follow
		if [[ $? = 1 ]]; then
			bspc node @/ -d next:focused --follow
		fi
		;;
	\?)
		>&2 echo -e "invalid command -- '$COMMAND'\n$USAGE"
		;;
esac

# Set scratchpad sticky flag
[[ -z $SCRATCHPAD ]] || bspc node $SCRATCHID --flag sticky=on
