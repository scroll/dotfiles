#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################
dir=`pwd`
files="emacs.d cshrc bashrc bash_aliases gitconfig floorc.json"

if [ ! -d "~/dotfiles_old" ]; then
	rm -rf ~/dotfiles_old
    mkdir ~/dotfiles_old
fi

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo "Moving $file in home directory."
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -sf "$dir/$file" ~/.$file
done

