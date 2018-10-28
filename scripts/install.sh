#!/bin/bash

# Update packages
sudo pacman -Syyu --noconfirm


# Install pacaur
if [ "$(pacman -Qi pacaur)" ]; then
	echo "Pacaur installed, skipping..."
else
	sudo pacman -S --needed curl
	curl -s https://gist.githubusercontent.com/Tadly/0e65d30f279a34c33e9b/raw/pacaur_install.sh | bash
fi


echo "Installing user-specified packages..."
i=0
total=$(wc -l packages | awk '{print $1}')
for line in $(sed "/^#/d" "packages"); do
	i=$((i + 1))
	tput bold
	echo "($i/$total) $line"
	tput sgr0
	pacaur -S --needed --noconfirm --noedit "$line"
done


# Configure git
#git config --global credential.helper 'cache --timeout=1500'


# Symlinks (disgusting)
echo "Creating symlinks..."
ln -sfv ~/dotfiles/.bash_profile ~/.bash_profile
ln -sfv ~/dotfiles/.bashrc ~/.bashrc
ln -sfv ~/dotfiles/.compton.conf ~/.compton.conf
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
rm -rf ~/.config/networkmanager-dmenu
ln -sfv ~/dotfiles/.config/networkmanager-dmenu/ ~/.config/networkmanager-dmenu
rm -rf ~/.config/nvim
ln -sfv ~/dotfiles/.config/nvim/ ~/.config/nvim
mkdir ~/.config/pianobar
mkfifo ~/.config/pianobar/ctl
touch ~/.config/pianobar/nowplaying
ln -sfv ~/dotfiles/.config/pianobar/config ~/.config/pianobar/config
rm -rf ~/.config/qutebrowser
mkdir -pv ~/.config/qutebrowser/
ln -sfv ~/dotfiles/.config/qutebrowser/* ~/.config/qutebrowser
mkdir -pv ~/.config/ranger
ln -sfv ~/dotfiles/.config/ranger/rc.conf ~/.config/ranger/rc.conf
ln -sfv ~/dotfiles/.config/ranger/scope.sh ~/.config/ranger/scope.sh
mkdir -pv ~/.config/rofi
ln -sfv ~/dotfiles/.config/rofi/config ~/.config/rofi/config
ln -sfv ~/dotfiles/.config/rofi/config.rasi ~/.config/rofi/config.rasi.bak
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
ln -sfv ~/dotfiles/.Xresources ~/.Xresources
ln -sfv ~/dotfiles/.zshrc ~/.zshrc
xrdb ~/.Xresources


# Get some linting for vim
pip3 install --user flake8 \
	bashate
pip2 install --user bashate
