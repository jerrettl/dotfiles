#!/bin/bash

if [ -z "$1" ]; then
  echo "Please select an option to choose the install scope:"
  echo "  - basic:"
  echo "    - Update all packages"
  echo "    - Install yay"
  echo "    - Install the basic and extra package groups"
  echo "    - Set time zone"
  echo "    - Setup vim plugins"
  echo "    - Run shortcuts.sh"
  echo "    - Install all symlinks"
  echo
  echo "  - package-group: Install one specific package group, as defined in packages file"
  echo
  echo "  - link: Install all symlinks"
  echo
  echo "  - all:"
  echo "    - Everything in the base option"
  echo "    - Install the all package group"
  echo "    - Starts services"
  echo "    - Configures git"
  exit
fi




install_basic() {
  # Update packages
  sudo pacman -Syyu --noconfirm

  # Install yay
  if [ "$(pacman -Qi yay)" ]; then
    echo "yay installed, skipping..."
  else
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
  fi

  install_package_group extra

  # Set time
  echo "Setting timezone..."
  timedatectl set-timezone America/New_York
  timedatectl set-ntp true
  timedatectl set-local-rtc false

  # Set up vim plugins
  echo "Setting up vim..."
  nvim '+PlugUpdate' '+PlugClean!' '+PlugUpdate' '+qall'

  # Generate autoconfig files
  echo "Generating alias shortcuts..."
  ~/dotfiles/scripts/shortcuts.sh
  
  install_link
}


install_package_group() {
  if [ -z "$1" ]; then
    echo "Please enter a group name."
    exit
  fi

  selection=$(sed --quiet --expression="/\\[$1\\]/,/=====/ p" packages | head --lines=-1 | sed 1d | sed '/^#/d')

  if [ -z "$selection" ]; then
    echo "There are no packages in this group."
    exit
  fi

  echo "Installing packages from group $1..."

  i=0
  total=$(echo "$selection" | sed "/^\>/d" | wc --lines | awk '{print $1}')

  for line in $selection; do
    if [[ $line = \>* ]]; then
      # Group detected: Recurse into this group.
      # Warning: This will break the progress numbering (for now)
      line=${line#\>}
      install_package_group "$line"

      # Reset numbering when coming back from recursion
      i=0
    else
      # Package detected: Install as normal.
      i=$((i + 1))
      tput bold
      echo "($i/$total) $line"
      tput sgr0
      yay -S --needed --noconfirm --norebuild "$line"
      fi
  done

  echo "Finished installing packages in $1."
}


install_link() {
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
  ln -sfv ~/dotfiles/.git-prompt-colors.sh ~/.git-prompt-colors.sh
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
  ln -sfv ~/dotfiles/.profile ~/.profile
  mkdir ~/.ssh
  cp -nv ~/dotfiles/.ssh/config-example ~/.ssh/config
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
}


install_all() {
  install_base
  install_package_group all

  # Start services
  sudo systemctl enable --now bluetooth.service
  sudo systemctl enable --now redshift-gtk.service
  sudo systemctl enable --now cronie.service
  systemctl --user enable --now emacs

  # Configure git
  #git config --global credential.helper 'cache --timeout=1500'
  git config credential.helper store # Big brain move
  git config core.pager delta
  git config interactive.diffFilter 'delta --color-only'
}




if [ "$1" == "basic" ]; then
  install_basic
elif [ "$1" == "package-group" ]; then
  install_package_group "$2"
elif [ "$1" == "link" ]; then
  install_link
elif [ "$1" == "all" ]; then
  install_all
fi
