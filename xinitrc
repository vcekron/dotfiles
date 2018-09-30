#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

#Merge in defaults and keymaps

if [ -f $sysresources ]; then

    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then

    xmodmap $sysmodmap

fi

if [ -f "$userresources" ]; then

    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then

    xmodmap "$usermodmap"

fi

#Startup

if [ -d /etc/X11/xinit/xinitrc.d ] ; then

 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f

fi

export MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

export QT_QPA_PLATFORMTHEME='qt5ct'
export QT_AUTO_SCREEN_SCALE_FACTOR=0

export SSH_PORT=$(cat ~/.ssh_port)

eval $(keychain --eval --quiet --noask --nogui --confhost)
eval $(dircolors -b ~/.dir_colors)

xset s off -dpms &
xsetroot -cursor_name left_ptr &
udiskie &
dropbox &
numlockx &
redshift &
unclutter --timeout 1 &
urxvtd -q -f -o &
~/dotfiles/VPN_check &
pgrep -x compton > /dev/null || allow_rgb10_configs=false compton -t -8 -l -9 -r 6 -o 0.7 &
exec bspwm
