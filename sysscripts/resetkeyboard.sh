#! /bin/zsh

ERROR=$(xmodmap ~/.Xmodmap 2>&1 >/dev/null)
SUCC=$(echo $ERROR | grep "error")

if [[ $SUCC ]] ; then
	notify-send "Keyboard layout already sent" -t 5000 -i /usr/share/icons/HighContrast/256x256/devices/input-keyboard.png
else
	notify-send "Keyboard layout succesfully set" -t 5000 -i /usr/share/icons/HighContrast/256x256/devices/input-keyboard.png
fi
