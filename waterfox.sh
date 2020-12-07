#! /bin/sh

bspc rule -a Waterfox -o desktop='Primary:^1'
bspc rule -a Waterfox -o desktop='East:^1'
/usr/bin/waterfox-g3
