#! /bin/sh

wid=$1
class=$2
instance=$3

#Debug
#title=$(xtitle "$wid")
#echo "$wid $class $instance $title" > /tmp/bspc-external-rules

#Telegram

case $class in
	"TelegramDesktop")
		title=$(xtitle "$wid")
		case $title in
			"Media viewer")
				echo "state = fullscreen"
				;;
			*)
				echo "state = pseudo_tiled"
				echo "locked = on"
				;;
		esac
		;;
esac
