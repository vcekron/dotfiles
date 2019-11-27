#! /bin/zsh
#
# usage: `foo.pdf`.
# description: this script attempts to optimise `foo.pdf` in terms of footprint.

file="$1"
filebase="$(basename "$file" .pdf)"
optfile="/tmp/$$-${filebase}_opt.pdf"
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -r200000 \
        -sOutputFile="${optfile}" "${file}"

if [ $? -eq 0 ]; then
    optsize=$(stat -c "%s" "${optfile}")
    orgsize=$(stat -c "%s" "${file}")
    if [ "${optsize}" -eq 0 ]; then
        echo "No output!  Keeping original"
        rm -f "${optfile}"
        exit;
    fi
    if [ ${optsize} -ge ${orgsize} ]; then
        echo "Didn't make it smaller! Keeping original"
        rm -f "${optfile}"
        exit;
    fi
    bytesSaved=$(expr $orgsize - $optsize)
    percent=$(expr $optsize '*' 100 / $orgsize)
    echo Saving $bytesSaved bytes \(now ${percent}% of old\)
    rm "${file}"
    mv "${optfile}" "${file}"
fi
