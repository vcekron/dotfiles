#!/bin/bash

#declare -i ID
#ID=`xinput list | grep -Ei '(touchpad|GlidePoint|ALP00)\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'` # Only works if GlidePoint is at the end of the name string.
ID=`xinput list | grep 'ALP00' | grep -Eio '\s*id=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'` # More general, ut currently hardcoded to ALP00 from fjorgyn.
declare -i STATE
STATE=`xinput list-props $ID|grep 'Device Enabled'|awk '{print $4}'`
if [ $STATE -eq 1 ]
then
    xinput disable $ID
    #echo "Touchpad disabled."
    notify-send -a 'Touchpad' 'Disabled' -i /usr/share/icons/HighContrast/48x48/devices/input-touchpad.png
else
    xinput enable $ID
    #echo "Touchpad enabled."
    notify-send -a 'Touchpad' 'Enabled' -i /usr/share/icons/HighContrast/48x48/devices/input-touchpad.png
fi
