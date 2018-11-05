#! /bin/zsh

if [ -f /tmp/battwarn ] ; then
	pkill $(cat /tmp/battwarn)
	rm /tmp/battwarn
fi

if [[ $(battery | grep "Discharging" | awk '$2<11') ]]; then
	$$ > /tmp/battwarn
fi

while [[ $(battery | read CHAR BATT; echo "$CHAR $BATT" | grep "Discharging" | awk '$2<11') ]]; do
	zenity --warning --text "<span font_size='large' font_weight='bold'>Low battery</span>\n$BATT% of battery remaining" --title "Low battery warning" --width=150
	sleep 300
done

rm /tmp/battwarn 2>/dev/null
