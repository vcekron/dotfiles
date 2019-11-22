#!/bin/bash
#
# Usage: resizePDF foo bar.pdf
# Descrition: This script will resize bar.pdf to size foo and save the resulting PDF as bar_foo.pdf.

size="$1"
filebase="$(basename "$2" .pdf)"

pdfjam --outfile "${filebase}_${size}.pdf" --paper "$size"paper "$filebase.pdf"
