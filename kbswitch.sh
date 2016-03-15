#! /bin/zsh

setxkbmap -print -verbose 7 | sed -n '4p'| {read foo kbl }

if [[ $kbl == "se" ]]
then
	setxkbmap us
elif [[ $kbl == "us" ]]
then
	setxkbmap se
fi 
