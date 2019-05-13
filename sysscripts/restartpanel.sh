#! /bin/sh

xdo kill $(xdo id -m -a "$PANEL_WM_NAME" | head -n 1)

./.config/bspwm/panel &!

wids=$(xdo id -m -a "$PANEL_WM_NAME")
for wid in $wids; do
	xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" "$wid"
done
