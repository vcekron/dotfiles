#! /bin/zsh

echo $(xprop -id $(xdo id) WM_CLASS) | read foo bar baz CLASS

case $CLASS in
	'"URxvt"')
		DIR=${$(xprop -id $(xdo id) WM_ICON_NAME | sed 's/WM_ICON_NAME(STRING) = \".*: //; s,\~.\?,'"$HOME"'/,')%\"}
		;;
	'"tabbed"'|'"Zathura"')
		echo $(xprop -id $(xdo id) WM_NAME) | read foo bar NAME
		DIR=${$(dirname $NAME)#\"}
		;;
esac

echo "$CLASS"
echo "$DIR"

case $(echo $DIR | head -c 1) in
	"/")
		urxvt -cd $DIR
		;;
	*)
		urxvt
		;;
esac
