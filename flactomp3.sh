#! /bin/bash

IFS=$'\n'
FILES=( "$@" )
FLACS=$( printf '%s\n' "${FILES[@]}" | grep '.flac$')
UNKONWNS=$( printf '%s\n' "${FILES[@]}" | grep -v '.flac$')

for flac in $FLACS; do
	< /dev/null ffmpeg -i "$flac" -qscale:a 0 "${flac[@]/%flac/mp3}"
done

if [[ $UNKONWNS ]]; then
	echo -e "\nUnknown files:"
	for unknown in $UNKONWNS; do
		echo -e "$unknown"
	done
fi
