#!/bin/bash

curl -s https://gist.githubusercontent.com/Tadly/0e65d30f279a34c33e9b/raw/pacaur_install.sh | bash

pacaur -Syyu
pacaur -S git i3 i3-bars i3lock-color-git vim npm tree xorg-xrdb

ln -sf ~/dotfiles/.compton.conf ~/.compton.conf
ln -sf ~/dotfiles/.config/i3/config ~/.config/i3/config
ln -sf ~/dotfiles/.config/i3blocks/config ~/.config/i3blocks/config
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.vim ~/.vim
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.Xresources ~/.Xresources
xrdb ~/.Xresources
ln -sf ~/dotfiles/.zshrc ~/.zshrc

git config --global user.email "jerrett7@gmail.com"
git config --global user.name "Jerrett Longworth"

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

git clone https://github.com/meskarune/i3lock-fancy
sudo cp -rf i3lock-fancy/icons /usr/local/bin
sudo cp -f i3lock-fancy/lock /usr/local/bin
rm -rf i3lock-fancy
