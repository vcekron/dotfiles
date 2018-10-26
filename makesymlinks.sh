#!/bin/bash

# Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="gtkrc-2.0 makepkg.conf zlogin zprofile zshrc Xresources xinitrc Xmodmap"    # list of files/folders to symlink in homedir
conf_files="bspwm gkt-3.0 rofi sxhkd zathura compton.conf redshift.conf"

# Create symlinks

##Create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

##Move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
	echo "Moving any existing dotfiles from ~ to $olddir."
	mv ~/.$file ~/$olddir
	echo "Creating symlink to $file in home directory."
	ln -s $dir/$file ~/.$file
done

for file in $conf_files; do
	echo "Moving any existing dotfiles from ~ to $olddir."
	mv ~/.config/$file ~/$olddir
	echo "Creating symlink to $file in ~/.config directory."
	mkdir -p ~/.config
	ln -s $dir/$file ~/.config/
done

echo "Moving any existing dotfiles from ~/.config/nvim to $olddir."
mv ~/.config/nvim/colors ~/$olddir/
mv ~/.config/nvim/init.vim ~/$olddir
echo "Creating symlink to init.vim and colors in ~/.config/nvim directory."
mkdir -p ~/.config/nvim
ln -s $dir/colors ~/.config/nvim/
ln -s $dir/init.vim ~/.config/nvim/

echo "Moving any existing mpv.conf from ~/.config/mpv to $olddir."
mv ~/.config/mpv/mpv.conf ~/$olddir
echo "Creating symlink to mpv.conf in ~/.config/mpv directory."
mkdir -p ~/.config/mpv
ln -s $dir/mpv.conf ~/.config/mpv/

echo "Moving any existing rc.conf from ~/.config/ranger to $olddir."
mv ~/.config/ranger/rc.conf ~/$olddir
echo "Creating symlink to rc.conf in ~/.config/ranger directory."
mkdir -p ~/.config/ranger
ln -s $dir/rc.conf ~/.config/ranger/

echo "Creating symlink to startup script."
ln -s $dir/startup /usr/local/bin/
