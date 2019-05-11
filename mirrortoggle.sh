#! /bin/sh

MONITORS=$(bspc query -M | wc -l)

case $MONITORS in
	1)
		mons -m
		mirror=$(bspc query -M --names | grep -v "Primary")
		eval bspc monitor $mirror -d "Mirror"
		;;
	2)
		desktops=$(bspc query -m Primary -D | wc -l)
		mons -o
		eval bspc monitor Primary -d $(seq -s' ' $desktops)
		;;
	*)
		echo "Invalid number of monitors detected"
		;;
esac 
