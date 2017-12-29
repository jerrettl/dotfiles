#!/bin/bash

sudo pacman -S --needed curl
curl -s https://gist.githubusercontent.com/Tadly/0e65d30f279a34c33e9b/raw/pacaur_install.sh | bash

pacaur -Syyu
pacaur -S --needed bdf-unifont calc caffeine-ng compton feh firefox git gvim i3-gaps i3blocks keepass libotf lightdm lightdm-gtk-greeter msmtp neomutt npm numlockx offlineimap pango qt5-webengine-widevine qutebrowser ranger rofi rxvt-unicode-pixbuf scrot system-san-francisco-font-git tmux tree ttf-droid ttf-ms-fonts ttf-roboto unzip urxvt-perls volumeicon w3m xdotool xorg-server xorg-xrdb youtube-dl zathura zathura-pdf-poppler zip zsh zsh-autosuggestions

ln -sfv ~/dotfiles/.compton.conf ~/.compton.conf
ln -sfv ~/dotfiles/.config/i3/config ~/.config/i3/config
ln -sfv ~/dotfiles/.config/i3blocks/config ~/.config/i3blocks/config
ln -sfv ~/dotfiles/.config/qutebrowser/ ~/.config/qutebrowser
ln -sfv ~/dotfiles/.config/ranger/rc.conf ~/.config/ranger/rc.conf
ln -sfv ~/dotfiles/.config/ranger/scope.sh ~/.config/ranger/scope.sh
ln -sfv ~/dotfiles/.config/rofi/config.rasi ~/.config/rofi/config.rasi
cp -nv ~/dotfiles/.msmtprc-example ~/dotfiles/.msmtprc
mkdir ~/.neomutt
ln -sfv ~/dotfiles/.neomutt/colors ~/.neomutt/colors
ln -sfv ~/dotfiles/.neomutt/macros ~/.neomutt/macros
ln -sfv ~/dotfiles/.neomutt/mailcap ~/.neomutt/mailcap
ln -sfv ~/dotfiles/.neomutt/neomuttrc ~/.neomutt/neomuttrc
cp -nv ~/dotfiles/.neomutt/user1-example ~/.neomutt/user1
ln -sfv ~/dotfiles/.offlineimap.py ~/.offlineimap.py
cp -nv ~/dotfiles/.offlineimaprc-example ~/.offlineimaprc
ln -sfv ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sfv ~/dotfiles/.vim/ ~/.vim
ln -sfv ~/dotfiles/.vimrc ~/.vimrc
ln -sfv ~/dotfiles/.Xresources ~/.Xresources
ln -sfv ~/dotfiles/.zshrc ~/.zshrc
xrdb ~/.Xresources

git config --global user.email "jerrett7@gmail.com"
git config --global user.name "Jerrett Longworth"

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

pacaur -S --needed awk i3lock-color-git imagemagick

sudo npm install -g castnow npm
