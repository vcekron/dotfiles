#! /bin/sh

SPEAKERS="alsa_output.usb-GFEC_ASSP_DigiHug_USB_Audio-01.analog-stereo"
HEADPHONES="alsa_output.usb-SteelSeries_SteelSeries_Arctis_7-00.stereo-game"

pacmd info | grep -e "Default sink.*${SPEAKERS}" && pacmd set-default-sink ${HEADPHONES} || pacmd set-default-sink ${SPEAKERS}

~/.config/bspwm/panel_resources/volume > "$PANEL_FIFO"

