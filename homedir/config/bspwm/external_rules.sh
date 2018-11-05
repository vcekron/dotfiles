#! /bin/sh

WID=$1
CLASS=$2
INSTANCE=$3

#Debug
#TITLE=$(xtitle "$WID")
#echo "$WID $CLASS $INSTANCE $TITLE" > /tmp/bspc-external-rules

#Telegram

case $CLASS in
	"TelegramDesktop")
		TITLE=$(xtitle "$WID")
		case $TITLE in
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
