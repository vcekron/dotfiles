#! /bin/zsh
#
# Usage: extractFrames foo.gif
# Description: This script will extract the frames of foo.gif to foo/frames-x.png, where x = 1,2,3...

file="$1"
filebase="$(basename "$file" .gif)"

mkdir $filebase
convert -coalesce $filebase.gif $filebase/frame.png
