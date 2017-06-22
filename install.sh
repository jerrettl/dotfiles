#!/bin/bash

curl -s https://gist.githubusercontent.com/Tadly/0e65d30f279a34c33e9b/raw/pacaur_install.sh | bash

pacaur -Syyu
pacaur -S git i3 i3-bars vim npm

ln -s ~/dotfiles/.compton.conf ~/.compton.conf
ln -s ~/dotfiles/.config/i3/config ~/.config/i3/config
ln -s ~/dotfiles/.config/i3blocks/config ~/.config/i3blocks/config
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.vim ~/.vim
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.Xresources ~/.Xresources
ln -s ~/dotfiles/.zshrc ~/.zshrc

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

git config --global user.email "jerrett7@gmail.com"
git config --global user.name "Jerrett Longworth"
