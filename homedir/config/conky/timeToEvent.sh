#!/bin/bash
#
# Usage: `timeToEvent "2019-11-27 00:00:00` will return the number of days or hours and minutes starting fro 24 hours.

# The time of the event.
TIME="${1}"

# Define a function which takes the number of seconds and converts it to days, hours, etc.
convertsecs() {
	((d=${1}/86400))
	((h=(${1}%86400)/3600))
	((m=(${1}%3600)/60))
	((s=${1}%60))
	if [[ $d -gt 0 ]] ; then
		printf "%02d days\n" $((d + 1))
	elif [[ $m -ge 0 ]]; then
		if [[ $m == 59 ]]; then
			printf "%02d:00\n" $((h + 1))
		else
			printf "%02d:%02d\n" $h $((m + 1))
		fi
	else
		printf "Past Time"
	fi
}

# Convert the times to seconds from the Epoch.
SEC1=`date +%s`
SEC2=`date +%s -d "$TIME"`

# Use expr to do the math.
DIFFSEC=`expr ${SEC2} - ${SEC1}`

# Echo the current difference in time.
echo $(convertsecs $DIFFSEC)
