#!/bin/bash
#
# usage: standalone.
# descritpion: outputs an appropriately formatted string for Conky to interpret and render.

# Set the appropriate offsets per machine.
if [[ "$HOSTNAME" = freja ]]; then
	offsetLeft=150; offsetRight=0
else
	offsetLeft=75; offsetRight=75
fi

# Consider the end of the working day when appropriate (i.e. a working day and on fjorgyn).
if [[ $(date +%u) -lt 6 && "$HOSTNAME" = fjorgyn ]] ; then
	echo ${color}'${offset '${offsetLeft}'}* End of The Working Day${alignr}${offset -'${offsetRight}'}'$(~/.config/conky/timeToEvent.sh "17:00:00")
	echo # Echo an empty line.
fi

# Create and fill an array with the events, and one with the corresponding dates.
arrayEvents=(); 							arrayDates=()
#arrayEvents+=('Christmas Eve'); 			arrayDates+=('2019-12-24 00:00:00')
#arrayEvents+=('New Year'"'"'s Eve');		arrayDates+=('2019-12-31 00:00:00')
#arrayEvents+=('Silvia Neuchâtel'); 			arrayDates+=('2020-01-09 17:00:00')
arrayEvents+=('Joanna, Sanna & Felicia');	arrayDates+=('2020-03-06 17:00:00')
arrayEvents+=('Prognosis Festival'); 		arrayDates+=('2020-03-20 00:00:00')
arrayEvents+=('Silvia Belgrade'); 			arrayDates+=('2020-04-10 00:00:00')
arrayEvents+=('Dynamo Metalfest'); 			arrayDates+=('2020-06-17 00:00:00')
arrayEvents+=('Kendrick Lamar Rome'); 		arrayDates+=('2020-07-07 00:00:00')
arrayEvents+=('South Korea');	 			arrayDates+=('2020-08-01 00:00:00')
arrayEvents+=('Nightwish Düsseldorf'); 		arrayDates+=('2020-11-21 00:00:00')

# Loop over all of the events.
for i in $(seq ${#arrayEvents[@]}); do
	# Convert the dates into time-until-event.
	arrayDates[$i-1]=$(~/.config/conky/timeToEvent.sh "${arrayDates[$i-1]}")

	# Decide the correct color (${color}$ and ${color2}$ for odd and even rows, respectively).
	if (( $i % 2 )); then
		color='${color}'
	else
		color='${color2}'
	fi

	# Echo the final strings.
	echo ${color}'${offset '${offsetLeft}'}* '${arrayEvents[$i-1]}'${alignr}${offset -'${offsetRight}'}'${arrayDates[$i-1]}
done
