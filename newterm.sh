#! /bin/zsh

echo $(xprop -id $(xdotool getactivewindow) WM_CLASS) | read foo bar baz class

if [[ $class == '"URxvt"' ]]
then
	dir=${$(xprop -id $(xdotool getactivewindow) WM_ICON_NAME | sed 's/WM_ICON_NAME(STRING) = \".*: //; s,\~.\?,'"$HOME"'/,')%\"}
elif [[ $class == '"tabbed"' || $class == '"Zathura"' ]]
then
	echo $(xprop -id $(xdotool getactivewindow) WM_NAME) | read foo bar name
	dir=${$(dirname $name)#\"}
fi

if [[ $(echo $dir | head -c 1) == "/" ]]
then
	urxvt -cd $dir
else
	urxvt
fi 
