#! /bin/zsh

RUN=$(ps -cax | grep redshift)

if [[ $RUN ]] ; then
	pkill redshift
else
	redshift &!
fi
