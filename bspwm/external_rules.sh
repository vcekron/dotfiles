#! /bin/sh

wid=$1
class=$2
instance=$3

#Debug
#title=$(xtitle "$wid")
#echo "$wid $class $instance $title" > /tmp/bspc-extenral-rules

#Telegram

if [ "$class" = TelegramDesktop ] ; then
	title=$(xtitle "$wid")
	if [ "$title" = "Media viewer" ] ; then
		echo "state = fullscreen"
	else
		echo "state = pseudo_tiled"
		echo "locked = on"
	fi
fi
