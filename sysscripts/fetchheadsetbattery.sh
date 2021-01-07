#! /bin/zsh

headsetcontrol -cb | read -r BATTH

if [[ $BATTH == "-2" ]] ; then
	notify-send "Headset is disconnected" -t 2000 -i /usr/share/icons/Adwaita/48x48/devices/audio-headset.png
elif [[ $BATTH == "-1" ]] ; then
	notify-send "Headset is charging" -t 2000 -i /usr/share/icons/Adwaita/48x48/devices/audio-headset.png
else
	notify-send "Battery Level: $BATTH%" -t 2000 -i /usr/share/icons/Adwaita/48x48/devices/audio-headset.png
fi
