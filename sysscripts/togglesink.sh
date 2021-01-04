#! /bin/sh

HEADPHONES="alsa_output.usb-Corsair_CORSAIR_VOID_ELITE_Wireless_Gaming_Dongle-00.analog-stereo"
case $(hostname) in
	"freja")
		SPEAKERS="alsa_output.pci-0000_08_00.4.iec958-stereo"
		;;
	"TUE009888")
		SPEAKERS="alsa_output.pci-0000_00_1f.3.analog-stereo"
		;;
esac

pacmd info | grep -e "Default sink.*${SPEAKERS}" && pacmd set-default-sink ${HEADPHONES} || pacmd set-default-sink ${SPEAKERS}

~/.config/bspwm/panel_resources/volume > "$PANEL_FIFO"

