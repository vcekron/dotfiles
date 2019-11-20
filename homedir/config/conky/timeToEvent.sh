#!/bin/bash

#TIME="2020-01-10 00:00:00" # The time of the next event.
TIME="${1}" # The time of the next event.

# Define a function which takes the number of seconds and converts it to days, hours, etc.
convertsecs() {
	((d=${1}/86400))
	((h=(${1}%86400)/3600))
	((m=(${1}%3600)/60))
	((s=${1}%60))
	if [[ $d -gt 0 ]] ; then
		printf "%02d days\n" $d
	elif [[ $m -ge 0 ]]; then
		printf "%02d:%02d\n" $h $((m + 1))
	else
		printf "Past Time"
	fi
}

# Convert the times to seconds from the Epoch.
SEC1=`date +%s`
SEC2=`date +%s -d "$TIME"`

# Use expr to do the math.
DIFFSEC=`expr ${SEC2} - ${SEC1}`

echo $(convertsecs $DIFFSEC) # Echo the current difference in time.
