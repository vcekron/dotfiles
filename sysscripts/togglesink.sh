#! /bin/sh

#HEADPHONES="alsa_output.usb-Corsair_CORSAIR_VOID_ELITE_Wireless_Gaming_Dongle-00.analog-stereo"
HEADPHONES="alsa_output.usb-Corsair_CORSAIR_VIRTUOSO_SE_Wireless_Gaming_Headset_15ad45cd000700dc-00.iec958-stereo"
case $(hostname) in
	"freja")
		SPEAKERS="alsa_output.pci-0000_08_00.4.iec958-stereo"
		;;
	"TUE009888")
		SPEAKERS="alsa_output.pci-0000_00_1f.3.analog-stereo"
		;;
esac

#pacmd info | grep -e "Default sink.*${SPEAKERS}" && pacmd set-default-sink ${HEADPHONES} && headsetcontrol -l 0 || pacmd set-default-sink ${SPEAKERS}
pacmd info | grep -e "Default sink.*${SPEAKERS}" && pacmd set-default-sink ${HEADPHONES} || pacmd set-default-sink ${SPEAKERS}

~/.config/bspwm/panel_resources/volume > "$PANEL_FIFO"

