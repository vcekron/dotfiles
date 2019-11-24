#!/bin/bash
if [[ $HOSTNAME="freja" ]]; then
	offsetLeft=150; offsetRight=0
else
	offsetLeft=75; offsetRight=75
fi

arrayEvents=(); arrayDates=()
arrayEvents+=('* Christmas Eve ${alignr}${offset -'${offsetRight}'}${texeci 60 ~/.config/conky/timeToEvent.sh "2019-12-24 00:00:00"}')
#arrayEvents+=('* Christmas Eve'); arrayDates=('2019-12-24 00:00:00')
arrayEvents+=('* New Year'"'"'s Eve ${alignr}${offset -'${offsetRight}'}${texeci 60 ~/.config/conky/timeToEvent.sh "2019-12-31 00:00:00"}')
arrayEvents+=('* Silvia Neuchâtel ${alignr}${offset -'${offsetRight}'}${texeci 60 ~/.config/conky/timeToEvent.sh "2020-01-10 00:00:00"}')
arrayEvents+=('* Prognosis Festival ${alignr}${offset -'${offsetRight}'}${texeci 60 ~/.config/conky/timeToEvent.sh "2020-03-20 00:00:00"}')
arrayEvents+=('* Silvia Belgrade ${alignr}${offset -'${offsetRight}'}${texeci 60 ~/.config/conky/timeToEvent.sh "2020-04-10 00:00:00"}')
#arrayEvents+=('* Silvia Genzano ${alignr}${offset -'${offsetRight}'}${texeci 60 ~/.config/conky/timeToEvent.sh "2020-06-26 00:00:00"}')
arrayEvents+=('* Dynamo Metalfest ${alignr}${offset -'${offsetRight}'}${texeci 60 ~/.config/conky/timeToEvent.sh "2020-06-17 00:00:00"}')

for i in $(seq ${#arrayDates[@]}); do
	~/.config/conky/timeToEvent.sh ${arrayDates[$i-1]}
	${arrayDates[$i-1]}="~/.config/conky/timeToEvent.sh ${arrayDates[$i-1]}"
done

for i in $(seq ${#arrayEvents[@]}); do
	if (( $i % 2 )); then
		echo '${color}${offset '${offsetLeft}'}'${arrayEvents[$i-1]}
		#'${alignr}${offset -'${offsetRight}'}'${arrayDates[$i-1]}
	else
		echo '${color2}${offset '${offsetLeft}'}'${arrayEvents[$i-1]}
	fi
done
