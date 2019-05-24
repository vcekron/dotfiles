#! /bin/sh

echo -n "$(ip link | grep azirevpn | cut -d' ' -f2) "
cat /tmp/vpn_state /tmp/vpn_err
