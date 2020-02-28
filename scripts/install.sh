#!/bin/bash

# Update packages
sudo pacman -Syyu --noconfirm


# Install pacaur
if [ "$(pacman -Qi yay)" ]; then
	echo "yay installed, skipping..."
else
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd ..
	rm -rf yay
fi


echo "Installing user-specified packages..."
i=0
total=$(wc -l packages | awk '{print $1}')
for line in $(sed "/^#/d" "packages"); do
	i=$((i + 1))
	tput bold
	echo "($i/$total) $line"
	tput sgr0
  yay -S --needed --noconfirm --norebuild "$line"
done


# Configure git
#git config --global credential.helper 'cache --timeout=1500'
git config credential.helper store # Big brain move

# Start services
sudo systemctl enable bluetooth.service
sudo systemctl enable redshift-gtk.service
sudo systemctl enable cronie.service
systemctl --user enable emacs

# Set time
timedatectl set-timezone America/New_York
timedatectl set-ntp true
timedatectl set-local-rtc false


# Symlinks (disgusting)
echo "Creating symlinks..."
ln -sfv ~/dotfiles/.bash_profile ~/.bash_profile
ln -sfv ~/dotfiles/.bashrc ~/.bashrc
ln -sfv ~/dotfiles/.config/chromium-flags.conf ~/.config/chromium-flags.conf
ln -sfv ~/dotfiles/.config/chromium-flags.conf ~/.config/chrome-flags.conf
ln -sfv ~/dotfiles/.config/clight.conf ~/.config/clight.conf
mkdir -pv ~/.config/dunst
ln -sfv ~/dotfiles/.config/dunst/dunstrc ~/.config/dunst/dunstrc
mkdir -pv ~/.config/fish
ln -sfv ~/dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
ln -sfv ~/dotfiles/.config/flake8 ~/.config/flake8
mkdir -pv ~/.config/i3
ln -sfv ~/dotfiles/.config/i3/config ~/.config/i3/config
mkdir -pv ~/.config/i3blocks
ln -sfv ~/dotfiles/.config/i3blocks/config ~/.config/i3blocks/config
mkdir ~/.config/kitty
ln -sfv ~/dotfiles/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -sfv ~/dotfiles/.config/mpv/mpv.conf ~/.config/mpv/mpv.conf
rm -rf ~/.config/networkmanager-dmenu
ln -sfv ~/dotfiles/.config/networkmanager-dmenu/ ~/.config/networkmanager-dmenu
rm -rf ~/.config/nvim
ln -sfv ~/dotfiles/.config/nvim/ ~/.config/nvim
mkdir ~/.config/pianobar
mkfifo ~/.config/pianobar/ctl
touch ~/.config/pianobar/nowplaying
ln -sfv ~/dotfiles/.config/redshift.conf ~/.config/redshift.conf
ln -sfv ~/dotfiles/.config/pianobar/config ~/.config/pianobar/config
ln -sfv ~/dotfiles/.config/picom.conf ~/.config/picom.conf
rm -rf ~/.config/qutebrowser
mkdir -pv ~/.config/qutebrowser/
ln -sfv ~/dotfiles/.config/qutebrowser/* ~/.config/qutebrowser
mkdir -pv ~/.config/ranger
ln -sfv ~/dotfiles/.config/ranger/rc.conf ~/.config/ranger/rc.conf
ln -sfv ~/dotfiles/.config/ranger/rifle.conf ~/.config/ranger/rifle.conf
ln -sfv ~/dotfiles/.config/ranger/scope.sh ~/.config/ranger/scope.sh
mkdir -pv ~/.config/rofi
ln -sfv ~/dotfiles/.config/rofi/config ~/.config/rofi/config
ln -sfv ~/dotfiles/.config/rofi/config.rasi ~/.config/rofi/config.rasi.bak
mkdir -pv ~/.config/zathura
ln -sfv ~/dotfiles/.config/zathura/gui/zathurarc ~/.config/zathura/zathurarc
ln -sfv ~/dotfiles/.emacs ~/.emacs
ln -sfv ~/dotfiles/.inputrc ~/.inputrc
rm -f ~/.msmtp
ln -sfv ~/dotfiles/.msmtp/ ~/.msmtp
cp -nv ~/dotfiles/.msmtprc-example ~/.msmtprc
mkdir ~/.neomutt
ln -sfv ~/dotfiles/.neomutt/colors ~/.neomutt/colors
ln -sfv ~/dotfiles/.neomutt/macros ~/.neomutt/macros
ln -sfv ~/dotfiles/.neomutt/mailcap ~/.neomutt/mailcap
ln -sfv ~/dotfiles/.neomutt/neomuttrc ~/.neomutt/neomuttrc
cp -nv ~/dotfiles/.neomutt/user1-example ~/.neomutt/user1
ln -sfv ~/dotfiles/.offlineimap.py ~/.offlineimap.py
cp -nv ~/dotfiles/.offlineimaprc-example ~/.offlineimaprc
ln -sfv ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sfv ~/dotfiles/.urlview ~/.urlview
mkdir -pv ~/.urxvt/ext
ln -sfv ~/dotfiles/.urxvt/ext/* ~/.urxvt/ext
rm ~/.vim
ln -sfv ~/dotfiles/.vim/ ~/.vim
ln -sfv ~/dotfiles/.vimrc ~/.vimrc
ln -sfv ~/dotfiles/.xinitrc ~/.xinitrc
ln -sfv ~/dotfiles/.Xresources ~/.Xresources
ln -sfv ~/dotfiles/.zshrc ~/.zshrc
xrdb ~/.Xresources


# Get some linting for vim
pip3 install --user flake8 \
	bashate
