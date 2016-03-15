#!/bin/sh

#Backup zsh settings
mkdir -p ~/Dropbox/Linux\ backup/"$(hostname)"
cp --parents ~/.zshrc ~/Dropbox/Linux\ backup/"$(hostname)"/
cp --parents /etc/zsh/zshrc ~/Dropbox/Linux\ backup/"$(hostname)"/
cp --parents ~/.clnpkg.sh ~/Dropbox/Linux\ backup/"$(hostname)"/

#Backup xinitrc
cp --parents ~/.xinitrc ~/Dropbox/Linux\ backup/"$(hostname)"/

#Backup user systemd timers
cp -ar --parents ~/.config/systemd/user/*.service ~/Dropbox/Linux\ backup/"$(hostname)"/
cp -ar --parents ~/.config/systemd/user/*.timer ~/Dropbox/Linux\ backup/"$(hostname)"/

#Backup xmodmap settings
#cp --parents ~/.Xmodmap ~/Dropbox/Linux\ backup/"$(hostname)"/

#Backup Xresources
cp --parents ~/.Xresources ~/Dropbox/Linux\ backup/"$(hostname)"/ 

#Backup lockscreens
cp -ar --parents ~/.i3lock ~/Dropbox/Linux\ backup/"$(hostname)"/

#Backup xSwipe settings
cp --parents ~/.xswipe/eventKey.cfg ~/Dropbox/Linux\ backup/"$(hostname)"/

#Backup gtkrc-2.0
cp --parents ~/.gtkrc-2.0 ~/Dropbox/Linux\ backup/"$(hostname)"/

#Backup bspwm & sxhkd config etc.
cp -ar --parents ~/.config/bspwm ~/Dropbox/Linux\ backup/"$(hostname)"/
cp -ar --parents ~/.config/sxhkd ~/Dropbox/Linux\ backup/"$(hostname)"/
cp --parents ~/.zprofile ~/Dropbox/Linux\ backup/"$(hostname)"/

#Backup keyboard layout switcher
cp --parent ~/.kbswitch.sh ~/Dropbox/Linux\ backup/"$(hostname)"/

#Backup compton config
cp --parents ~/.config/compton.conf ~/Dropbox/Linux\ backup/"$(hostname)"/

#Backup makepkg.conf
cp --parents ~/.makepkg.conf ~/Dropbox/Linux\ backup/"$(hostname)"/

#Backup startup script
#cp --parents ~/.startup.sh ~/Dropbox/Linux\ backup/"$(hostname)"/

#Backup battery-check script
cp --parents ~/.battery.sh ~/Dropbox/Linux\ backup/"$(hostname)"/

#Backup Vim settings
cp --parents ~/.vimrc ~/Dropbox/Linux\ backup/"$(hostname)"/ 
cp -ar --parents ~/.vim/colors ~/Dropbox/Linux\ backup/"$(hostname)"/ 

#Backup VLC settings
cp -ar --parents ~/.config/vlc/ ~/Dropbox/Linux\ backup/"$(hostname)"/

#Backup swappiness etc.
cp --parents /etc/sysctl.d/99-sysctl.conf ~/Dropbox/Linux\ backup/"$(hostname)"/

#Create list of installed packages
pacman -Qqe > ~/Dropbox/Linux\ backup/"$(hostname)"/packages.txt

#Backup self
cp "$0" ~/Dropbox/Linux\ backup/"$(hostname)"

echo Backup complete.
