#! /bin/sh

read -p "This will rename all the .srt-files in this folder to match the names of any .mkv-files in alphabetical order. Continue? [y/N] " -n 1 -r

echo #

if [[ $REPLY =~ ^[Yy]$ ]]; then

	LIST=$(ls | grep .mkv)
	for file in *.srt; do
		read line
		mv -nv "${file}" "${line%.mkv}".srt | tee subren.log
	done <<< "$LIST"

	echo "done"

	read -p "Keep log-file? [Y/n] " -n 1 -r

	[[$REPLY =~ ^[Nn]$ ]] && rm subren.log

else
	echo -e "\nScrew it then!"

fi
