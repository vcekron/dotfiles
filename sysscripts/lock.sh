#!/bin/bash
# ┏━┓┳  o┏┓┓┏━┓┳ ┳┳  ┏━┓┏━┓┳┏
# ┃ ┳┃  ┃ ┃ ┃  ┃━┫┃  ┃ ┃┃  ┣┻┓
# ┇━┛┇━┛┇ ┇ ┗━┛┇ ┻┇━┛┛━┛┗━┛┇ ┛
#
# author: xero <x@xero.nu> http://xero.nu
# modified by: scekron
# requires: i3lock-color, imagemagick, maim

maim -u /tmp/lock.png # Take a screenshot.
convert -quality 100 /tmp/lock.png /tmp/lock.jpg # Convert it to jpg for the mapulations.
file=/tmp/lock.jpg # This is the temporary file we will manipulate.

# Create a datamosh function, which will perturb the data.
function datamosh() {
	fileSize=$(wc -c < "$file") # File size in bytes..
	headerSize=1000 # How many bytes before we start messing with the data.
	skip=$(shuf -i "$headerSize"-"$fileSize" -n 1) # The start of the byte to mess with.
	count=$(shuf -i 1-10 -n 1) # The number of bytes to manipulate.
	# Loop over the number of bytes and generate a byte string.
	for i in $(seq 1 $count); do
		byteStr=$byteStr'\x'$(shuf -i 0-255 -n 1)
	done
	printf $byteStr | dd of="$file" bs=1 seek=$skip count=$count conv=notrunc >/dev/null 2>&1 # Copy the byte string into the file, overriding the previous data.
}

steps=$(shuf -i 30-50 -n 1) # The number of datamosh applications.
for i in $(seq 1 $steps); do

	# Rotate the image 90 degrees with a certain probability before messing with it.
	tempVar=$(shuf -i 0-100 -n 1)
	if [[ $tempVar -lt 11 ]]; then
		convert -rotate 90 -quality 100 $file $file >/dev/null 2>&1
		(( k++ ))
	fi

	datamosh "$file" # Just fuck my shit up.
done

# Rotate the image to the correct orientation again.
remainingDegrees=$(( k*90 % 360 ))
convert -rotate -$remainingDegrees -quality 100 /tmp/lock.jpg /tmp/lock.jpg >/dev/null 2>&1

# The paramaters for i3lock-color.
PARAM=(
	--inside-color=1d1f21ff \
	--ring-color=c5c8c6ff \
	--line-uses-inside \
	--keyhl-color=8c9440ff \
	--bshl-color=a54242ff \
	--separator-color=c5c8c6ff \
	--insidever-color=1d1f21ff \
	--ringver-color=b264bbff \
	--insidewrong-color=a54242ff \
	--ringwrong-color=a54242ff \
	--time-color=c5c8c6ff \
	--date-color=c5c8c6ff \
	--time-str="%H:%M" \
	--time-font="Source Sans Pro" \
	--time-size=38 \
	--date-str="%A %d %b" \
	--date-font="Source Sans Pro" \
	--date-size=16 \
	--verif-text="" \
	--wrong-font="Source Sans Pro" \
	--ring-width=4 \
	--clock \
	--indicator \
	--verif-text="" --wrong-text="" --noinput-text=""
)

# Convert our fucked up jpg back to png and remove temp files.
convert -quality 100 /tmp/lock.jpg /tmp/lock.png >/dev/null 2>&1
rm /tmp/lock.jpg
file=/tmp/lock.png

# Lock the device.
i3lock -n "${PARAM[@]}" -i "$file" > /dev/null 2>&1 &

# If requested, also put the device to sleep.
if [[ $1 == s ]]; then
	sleep 1
	systemctl suspend
fi
