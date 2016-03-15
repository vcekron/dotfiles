#! /bin/zsh

setxkbmap -print -verbose 7 | sed -n '4p'| {read foo kbl }

if [[ $kbl == "se" ]]
then
	out=KSE
elif [[ $kbl == "us" ]]
then
	out=KUS
fi

echo $out > "$PANEL_FIFO" & 
