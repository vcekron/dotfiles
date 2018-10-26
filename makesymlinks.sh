#!/bin/sh

# Variables

# dotfiles directory
SOURCEDIR=~/dotfiles
# old dotfiles backup directory
OLDDIR=~/dotfiles_old
# list of files/folders to symlink in homedir
HOME_FILES=("gtkrc-2.0" "makepkg.conf" "xinitrc" "Xmodmap" "Xresources" "zlogin" "zprofile" "zshrc")
CONF_DIRS=("gtk-3.0" "nvim/colors" "ranger" "rofi" "zathura")
CONF_FILES=("bspwm" "compton.conf" "gkt-3.0/settings.ini" "nvim/colors/hybrid.vim" "nvim/colors/hybrid-light.vim" "nvim/init.vim" "ranger/rc.conf" "redshift.conf" "rofi/config" "sxhkd" "zathura/zathurarc")

# Create symlinks

##Create dotfiles_old in homedir
echo -n "Creating $OLDDIR for backup of any existing dotfiles in ~ ..."
mkdir -p $OLDDIR
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $SOURCEDIR directory ..."
cd $SOURCEDIR
echo "done"

# Move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $HOME_FILES
for file in ${HOME_FILES[@]}; do
	echo -n "Moving any existing dotfiles from ~ to $OLDDIR ..."
	mv ~/.$file ~/$OLDDIR
	echo "done"
	echo -n "Creating symlink to $file in home directory ..."
	ln -s $SOURCEDIR/$file ~/.$file
	echo "done"
done

for dir in ${CONF_DIRS[@]}; do
	echo -n "Creating folders where needed ..."
	mkdir -p ~/.config/$dir
	echo "done"
done

for file in ${CONF_FILES[@]}; do
	echo -n "Moving any existing dotfiles from ~ to $OLDDIR ..."
	mv ~/.config/$file ~/$OLDDIR
	echo "done"
	echo -n "Creating symlink to $file in ~/.config directory ..."
	ln -s $SOURCEDIR/$file ~/.config/
	echo "done"
done

echo -n "Creating symlink to startup script ..."
ln -s $SOURCEDIR/startup /usr/local/bin/
echo "done"
