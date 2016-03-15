#! /bin/sh

sudo aura -Aa $(pacman -Qqm | grep git)
