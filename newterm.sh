#! /bin/zsh

dir=${$(xprop -id $(xdotool getactivewindow) WM_ICON_NAME | sed 's/WM_ICON_NAME(STRING) = \".*: //; s,\~.\?,'"$HOME"'/,')%\"}

if [[ $(echo $dir | head -c 1) == "/" ]]
then
	urxvt -cd $dir
else
	urxvt
fi

