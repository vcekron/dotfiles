#! /bin/zsh

RUN=$(pgrep redshift)

if [[ $RUN ]] ; then
	pkill redshift
else
	redshift &!
fi
