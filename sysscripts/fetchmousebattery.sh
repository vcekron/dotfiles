#! /bin/zsh

solaar show | grep -e "Battery" | head -1 | read -r BATTTEMP
#BATTTEMP="Battery: 100%, discharging, next level 50%."
#BATTTEMP="Battery: N/A, recharging, next level 0%."

CHARGING=$(echo $BATTTEMP | grep -e "recharging")
BATTM=$(echo $BATTTEMP | grep -o -E '[0-9]+' | head -1 | sed -e 's/^0\+//')

if [[ $CHARGING ]] ; then
	notify-send "Mouse is charging" -t 5000 -i /usr/share/icons/HighContrast/256x256/devices/input-mouse.png
elif [[ $BATTM ]] ; then
	notify-send "Battery level: $BATTM%" -t 5000 -i /usr/share/icons/HighContrast/256x256/devices/input-mouse.png
else
	notify-send "Mouse is disconnected" -t 5000 -i /usr/share/icons/HighContrast/256x256/devices/input-mouse.png
fi
