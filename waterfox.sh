#! /bin/sh

bspc rule -a Waterfox -o desktop='Primary:^1'
bspc rule -a Waterfox -o desktop='East:^3'
/usr/bin/waterfox
