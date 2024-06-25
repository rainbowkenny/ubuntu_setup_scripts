#!/bin/bash

pushd $HOME 

SCRIPT_DIR="setup_scripts"
BASH_PATH="$HOME/.bashrc"
VIM_PATH="$HOME/.vim"


if [ -d "$SCRIPT_DIR" ]; then
    echo "Directory $SCRIPT_DIR exists. Deleting it..."
    rm -rf "$SCRIPT_DIR"
    echo "Directory $SCRIPT_DIR has been deleted."
fi

mkdir $SCRIPT_DIR;cd $SCRIPT_DIR

git clone git@github.com:rainbowkenny/vimrc.git
git clone git@github.com:rainbowkenny/dotfiles.git



if [ -e "$BASH_PATH" ]; then
    # Check if the file is a symbolic link
    if [ -L "$BASH_PATH" ]; then
        echo "The file $BASH_PATH is a symbolic link. It will not be replaced."
    else
        echo "The file $BASH_PATH is not a symbolic link. Replacing it..."
	mv $HOME/.bashrc $HOME/.bashrc.backup
	ln -s dotfiles/.bashrc $HOME/.bashrc
        echo "File $BASH_PATH has been replaced."
    fi
else
    echo "The file $BASH_PATH does not exist."
fi

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

if [ -e "$VIM_PATH" ]; then
    # Check if the file is a symbolic link
    if [ -L "$VIM_PATH" ]; then
        echo "The file $VIM_PATH is a symbolic link. It will not be replaced."
    else
        echo "The file $VIM_PATH is not a symbolic link. Replacing it..."
	rm -rf "$VIM_PATH.backup"
	mv -f $VIM_PATH "$VIM_PATH.backup"
        echo "File $VIM_PATH has been backed up."
    fi
else
    echo "The file $VIM_PATH does not exist. Will create one now..."
    cp -r vimrc "$VIM_PATH"
fi


vim +'PlugInstall --sync' +qa

source ~/.bashrc
echo "File $BASH_PATH has been sourced."

popd
