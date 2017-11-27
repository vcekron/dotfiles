#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="gtkrc-2.0 makepkg.conf zlogin zprofile zshrc Xresources xinitrc Xmodmap"    # list of files/folders to symlink in homedir
conf_files="bspwm sxhkd compton.conf redshift.conf"

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
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

echo "Moving existing settings.ini from ~/.config/gtk-3.0 to $olddir."
mv ~/.config/gtk-3.0/settings.ini ~/$olddir
mkdir -p ~/.config/gtk-3.0
echo "Creating symlink to settings.ini in ~/.config/gtk-3.0 directory."
ln -s $dir/settings.ini ~/.config/gtk-3.0/

echo "Moving any existing dotfiles from ~/.config/nvim to $olddir."
mv ~/.config/nvim/colors ~/$olddir/
mv ~/.config/nvim/init.vim ~/$olddir
echo "Creating symlink to init.vim and colors in ~/.config/nvim directory."
mkdir -p ~/.config/nvim
ln -s $dir/colors ~/.config/nvim/
ln -s $dir/init.vim ~/.config/nvim/

echo "Moving any existing zathurarc from ~/.config/zathura to $olddir."
mv ~/.config/zathura/zathurarc ~/$olddir
echo "Creating symlink to zathurarc in ~/.config/zathura directory."
mkdir -p ~/.config/zathura
ln -s $dir/zathurarc ~/.config/zathura/

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

<<install
install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone my oh-my-zsh repository from GitHub only if it isn't already present
    #if [[ ! -d $dir/oh-my-zsh/ ]]; then
    #    git clone http://github.com/robbyrussell/oh-my-zsh.git
    #fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
        if [[ -f /etc/redhat-release ]]; then
            sudo yum install zsh
            install_zsh
        fi
        if [[ -f /etc/debian_version ]]; then
            sudo apt-get install zsh
            install_zsh
        fi
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
        echo "Please install zsh, then re-run this script!"
        exit
    fi
fi
}

install_zsh
install
