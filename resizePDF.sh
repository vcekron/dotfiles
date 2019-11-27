#!/bin/bash
#
# usage: `resizePDF foo bar.pdf`.
# description: this script will resize `bar.pdf` to size `foo` and save the resulting PDF as `bar_foo.pdf`.

size="$1"
filebase="$(basename "$2" .pdf)"

pdfjam --outfile "${filebase}_${size}.pdf" --paper "$size"paper "$filebase.pdf"
