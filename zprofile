PANEL_FIFO=/tmp/panel-fifo
if [[ $(hostname) == 'amunet' ]]
then 
	PANEL_HEIGHT=20
else
	PANEL_HEIGHT=18
fi
PANEL_WM_NAME=bspwm_panel
PANEL_FONT="Liberation Sans:style=bold:size=9"
ICON_FONT="FontAwesome:size=11"
ICON_FONT2="Ionicons:size=11"
export PANEL_FIFO PANEL_HEIGHT PANEL_WM_NAME PANEL_FONT ICON_FONT ICON_FONT2
