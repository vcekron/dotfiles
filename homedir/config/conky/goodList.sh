#!/bin/bash
if [[ "$HOSTNAME" = freja ]]; then
	offsetLeft=150; offsetRight=0
else
	offsetLeft=75; offsetRight=75
fi

arrayEvents=(); 							arrayDates=()
arrayEvents+=('* Christmas Eve'); 			arrayDates+=('2019-12-24 00:00:00')
arrayEvents+=('* New Year'"'"'s Eve'); 		arrayDates+=('2019-12-31 00:00:00')
arrayEvents+=('* Silvia Neuchâtel'); 		arrayDates+=('2020-01-10 00:00:00')
arrayEvents+=('* Prognosis Festival'); 		arrayDates+=('2020-03-20 00:00:00')
arrayEvents+=('* Silvia Belgrade'); 		arrayDates+=('2020-04-10 00:00:00')
#arrayEvents+=('* Silvia Genzano'); 			arrayDates+=('2020-06-26 00:00:00')
arrayEvents+=('* Dynamo Metalfest'); 		arrayDates+=('2020-06-17 00:00:00')

for i in $(seq ${#arrayEvents[@]}); do
	# Convert the dates into time-until-event.
	arrayDates[$i-1]=$(~/.config/conky/timeToEvent.sh ${arrayDates[$i-1]})

	# Decide the correct color (${color}$ and ${color2}$ for odd and even rows, respectively).
	if (( $i % 2 )); then
		color='${color}'
	else
		color='${color2}'
	fi
	
	# Echo the final string.
	echo ${color}'${offset '${offsetLeft}'}'${arrayEvents[$i-1]}'${alignr}${offset -'${offsetRight}'}'${arrayDates[$i-1]}
done
