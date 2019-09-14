#! /bin/sh

case $(hostname) in
	"freja")
		APPS=("waterfox" "spotify" "telegram-desktop" "qbittorrent")
		;;
	"gefjon")
		APPS=("waterfox" "telegram-desktop")
		;;
	"fjorgyn")
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
