#! /bin/sh

id=$(xdo id -a "$PANEL_WM_NAME" | head -n 1)
[[ $id ]] && xdo kill $id

~/.config/bspwm/panel &!
