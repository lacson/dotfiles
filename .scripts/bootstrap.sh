#!/bin/sh

# init repository
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
old_dir=$(pwd)
cd
dotfiles submodule update --init --recursive

# get YCMD ready
cd .vim/bundle/YouCompleteMe
./install.py
