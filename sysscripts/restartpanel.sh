#! /bin/sh

[[ $(xdo id -a "$PANEL_WM_NAME") ]] && pkill -fo "bspwm/panel"

~/.config/bspwm/panel &!
