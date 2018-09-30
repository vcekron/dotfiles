#! /bin/sh

VPN_IF=azirevpn
VPN_CHECK="curl -sS https://api.azirevpn.com/v1/check --max-time 2"
VPN_CHECK_FILTER="grep '\"connected\": true'"
POLL_INTERVAL=15
POLL_DELAY_TICK=0

while true ; do

	VPN_UP=$(ip r | grep ${VPN_IF})

	if [[ $VPN_UP && $POLL_DELAY_TICK == 0 ]] ; then
		VPN_CHECK_RESULT=$(eval ${VPN_CHECK} 2> /tmp/vpn_err)
		VPN_CONNECTED=$(echo "${VPN_CHECK_RESULT}" | eval ${VPN_CHECK_FILTER})
		#echo "Check ran"
	fi

	if [[ $VPN_UP && $VPN_CONNECTED ]] ; then
		VPN_STATE="Connected"
		POLL_DELAY_TICK=$(((POLL_DELAY_TICK + 1) % POLL_INTERVAL))
	elif [[ $VPN_UP ]] ; then
		VPN_STATE="Error"
		POLL_DELAY_TICK=0
	else
		VPN_STATE="Disconnected"
		unset VPN_CHECK_RESULT
		POLL_DELAY_TICK=0
	fi

	echo "$VPN_STATE" > /tmp/vpn_state

	#Debug
	#echo "$VPN_STATE"
	#echo "$POLL_DELAY_TICK"
	#echo "$VPN_CHECK_RESULT"

	sleep 1

done
