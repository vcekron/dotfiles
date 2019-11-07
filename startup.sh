#! /bin/sh

case $(hostname) in
	"amunet")
		APPS=("waterfox-current" "spotify" "telegram-desktop" "qbittorrent" "SVPManager")
		;;
	"hathor")
		APPS=("waterfox" "spotify" "telegram-desktop")
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
