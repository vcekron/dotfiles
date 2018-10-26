#! /bin/zsh

RUN=$(ps -cax | grep redshift)

if [[ $RUN ]] ; then
	pkill redshift
else
	nohup redshift >/dev/null 2>&1 &
fi
