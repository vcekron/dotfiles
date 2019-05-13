#! /bin/sh

[[ $(xdo id -a "$PANEL_WM_NAME" | head -n 1) ]] && pkill -fo "bspwm/panel"

~/.config/bspwm/panel &!
