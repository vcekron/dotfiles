#! /bin/sh

ID=$(cat /tmp/scratchid)

# Check for proper scratchpad
[[ $(xprop -id $ID WM_CLASS | cut -d'"' -f2) = "scratchpad" ]] || exit 1

# Make sure scratchpad is on the focused monitor
[[ $(bspc query -m focused -N | grep "$ID") ]] || bspc node $ID --flag sticky=off -m focused --flag sticky=on

# Show and focus scratchpad
bspc node $ID --flag hidden;bspc node -f $ID
