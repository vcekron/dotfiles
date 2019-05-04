#! /bin/sh

case $(hostname) in
	"freya")
		APPS=("waterfox" "spotify" "telegram-desktop" "qbittorrent" "SVPManager")
		;;
	"nerthus")
		APPS=("waterfox" "telegram-desktop")
		;;
esac

PS=$(ps -ax)

for app in ${APPS[@]}; do
	if [[ ! $(echo "$PS" | grep "$app") ]]; then
		echo "launching $app"
		eval "$app &"
	else
		echo "$app already running"
	fi
done
