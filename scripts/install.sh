#!/bin/bash

if [ -z "$1" ]; then
  echo "Please select an option to choose the install scope:"
  echo "  - basic:"
  echo "    - Update all packages"
  echo "    - Install yay (Arch Linux only)"
  echo "    - Install the basic and extra package groups"
  echo "    - Set time zone"
  echo "    - Setup vim plugins"
  echo "    - Run shortcuts.sh"
  echo "    - Install all symlinks"
  echo "    - Configure git"
  echo "    - Configure git shell status"
  echo
  echo "  - package-group: Install one specific package group, as defined in packages file"
  echo
  echo "  - link: Install all symlinks"
  echo
  echo "  - git: Configure git"
  echo
  echo "  - all:"
  echo "    - Everything in the base option"
  echo "    - Install the all package group"
  echo "    - Starts services (systemd only)"
  exit
fi

# Get Linux distribution
export OS=$(grep -E '^ID' /etc/os-release | cut -f2 -d'=')
echo "[INFO] Distro detected: $OS"

install_basic() {
  # Update packages
  if [ "$OS" == "arch" ]; then
    sudo pacman -Syyu --noconfirm

    # Install yay
    if [ "$(pacman -Qi yay)" ]; then
      echo "yay installed, skipping..."
    else
      # Install required packages
      sudo pacman -S --noconfirm make patch gcc autoconf automake binutils bison fakeroot

      git clone https://aur.archlinux.org/yay.git
      cd yay
      makepkg -si
      cd ..
      rm -rf yay
    fi
  elif [ "$OS" == "alpine" ]; then
    if [ -z "$(apk info --installed sudo)" ]; then
      echo "sudo is not installed. Please install first before continuing."
      exit
    fi
    sudo apk update
    sudo apk upgrade

    # Install basic packages
    sudo apk add util-linux pciutils usbutils coreutils binutils findutils grep bash bash-completion ncurses
  fi

  install_package_group extra

  # Set time
  if [ "$(which timedatectl)" ]; then
    echo "Setting timezone..."
    sudo timedatectl set-timezone America/New_York
    sudo timedatectl set-ntp true
    sudo timedatectl set-local-rtc false
  fi

  # Generate autoconfig files
  echo "Generating alias shortcuts..."
  ~/dotfiles/scripts/shortcuts.sh

  install_link

  # Set up vim plugins
  echo "Setting up vim..."
  nvim '+PlugUpdate' '+PlugClean!' '+PlugUpdate' '+qall'

  configure_git

  echo "Configuring git shell status..."
  if [ ! -d ~/.local/gitstatus ]; then
    echo "Cloning..."
    [ ! -d ~/.local ] && mkdir -p ~/.local
    git clone --depth=1 https://github.com/romkatv/gitstatus.git ~/.local/gitstatus
  else
    echo "Already configured."
  fi

  echo "Disabling blueman auto-power-on..."
  gsettings set org.blueman.plugins.powermanager auto-power-on false

  if [ "$OS" == "alpine" ]; then
    echo "Installing docs..."
    sudo apk add docs
  fi
}


install_package_group() {
  if [ -z "$1" ]; then
    echo "Please enter a group name."
    exit
  fi

  selection=$(sed --quiet --expression="/\\[$1\\]/,/=====/ p" "packages-$OS" | head --lines=-1 | sed 1d | sed '/^#/d')

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

      if [ "$OS" == "arch" ]; then
	yay -S --needed --noconfirm --norebuild "$line"
      elif [ "$OS" == "alpine" ]; then
      	sudo apk add "$line"
      fi

    fi
  done

  echo "Finished installing packages in $1."
}


install_link() {
  # Symlinks (disgusting)
  echo "Creating symlinks..."
  rm -rf ~/.config/alacritty
  mkdir -pv ~/.config/alacritty
  ln -sfv $DOTFILES/.config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
  rm -rf ~/.config/autorandr
  ln -sfv $DOTFILES/.config/autorandr/ ~/.config/autorandr
  ln -sfv ~/dotfiles/.config/chromium-flags.conf ~/.config/chromium-flags.conf
  ln -sfv ~/dotfiles/.config/chromium-flags.conf ~/.config/chrome-flags.conf
  ln -sfv ~/dotfiles/.config/clight.conf ~/.config/clight.conf
  mkdir -pv ~/.config/dunst
  ln -sfv ~/dotfiles/.config/dunst/dunstrc ~/.config/dunst/dunstrc
  mkdir -pv ~/.config/fontconfig
  ln -sfv ~/dotfiles/.config/fontconfig/fonts.conf ~/.config/fontconfig/fonts.conf
  ln -sfv ~/dotfiles/.config/flake8 ~/.config/flake8
  mkdir -pv ~/.gnupg
  ln -sfv $DOTFILES/.config/gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf
  mkdir -pv ~/.config/i3
  ln -sfv ~/dotfiles/.config/i3/config ~/.config/i3/config
  mkdir -pv ~/.config/i3blocks
  ln -sfv ~/dotfiles/.config/i3blocks/config ~/.config/i3blocks/config
  mkdir -pv ~/.config/kitty
  ln -sfv ~/dotfiles/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf
  mkdir -pv ~/.config/mpv
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
  ln -sfv $DOTFILES/.config/rofi/config.rasi ~/.config/rofi/config.rasi
  ln -sfv $DOTFILES/.config/rofi/Arc-Dark.rasi ~/.config/rofi/Arc-Dark.rasi
  ln -sfv $DOTFILES/.config/rofi/dmenu.rasi ~/.config/rofi/dmenu.rasi
  ln -sfv $DOTFILES/.config/rofi/large-font.rasi ~/.config/rofi/large-font.rasi
  ln -sfv $DOTFILES/.config/shell/bash_profile ~/.bash_profile
  ln -sfv $DOTFILES/.config/shell/bashrc ~/.bashrc
  ln -sfv $DOTFILES/.config/shell/profile ~/.profile
  ln -sfv $DOTFILES/.config/x11/.XCompose ~/.XCompose
  ln -sfv $DOTFILES/.config/x11/.xinitrc ~/.xinitrc
  ln -sfv $DOTFILES/.config/x11/.xprofile ~/.xprofile
  ln -sfv $DOTFILES/.config/x11/.Xresources ~/.Xresources
  mkdir -pv ~/.config/zathura
  ln -sfv ~/dotfiles/.config/zathura/zathurarc ~/.config/zathura/zathurarc
  ln -sfv ~/dotfiles/.emacs ~/.emacs
  mkdir ~/.ssh
  cp -nv ~/dotfiles/.ssh/config-example ~/.ssh/config
  ln -sfv ~/dotfiles/.tmux.conf ~/.tmux.conf
  mkdir -pv ~/.urxvt/ext
  ln -sfv ~/dotfiles/.urxvt/ext/* ~/.urxvt/ext
  rm ~/.vim
  ln -sfv ~/dotfiles/.vim/ ~/.vim
  ln -sfv ~/dotfiles/.vimrc ~/.vimrc

  # Mail
  rm -f ~/.msmtp
  mkdir -p ~/.config/msmtp
  cp -nv $DOTFILES/.config/mail/msmtp/config-example ~/.config/msmtp/config
  mkdir -p ~/.config/neomutt
  ln -sfv $DOTFILES/.config/mail/neomutt/colors ~/.config/neomutt/colors
  ln -sfv $DOTFILES/.config/mail/neomutt/macros ~/.config/neomutt/macros
  ln -sfv $DOTFILES/.config/mail/neomutt/mailcap ~/.config/neomutt/mailcap
  ln -sfv $DOTFILES/.config/mail/neomutt/neomuttrc ~/.config/neomutt/neomuttrc
  mkdir -p ~/.config/offlineimap
  cp -nv $DOTFILES/.config/mail/offlineimap/config-example ~/.config/offlineimap/config

  $DOTFILES_SCRIPTS/reload-xresources.sh
}


install_all() {
  install_basic
  install_package_group all

  # Start services
  if [ "$(which systemctl)" ]; then
    sudo systemctl enable --now bluetooth.service
    sudo systemctl --user disable --now redshift.service
    sudo systemctl --user disable --now redshift-gtk.service
    sudo systemctl enable --now cronie.service
    systemctl --user enable --now emacs
  fi
}


configure_git() {
  #git config --global credential.helper 'cache --timeout=1500'
  git config --global credential.helper store # Big brain move
  git config --global core.pager delta
  git config --global interactive.diffFilter 'delta --color-only'
  git config --global init.defaultBranch main
  git config --global pull.rebase true
  git config --global fetch.prune true
  git config --global commit.gpgsign true
}


if [ -z "$DOTFILES" ]; then
	echo "You appear to be missing some environment variables."
	echo "Please set the following variables with the proper locations:"
	echo "\$DOTFILES: $DOTFILES"
	exit
fi
if [ -z "$DOTFILES_SCRIPTS" ]; then
  export DOTFILES_SCRIPTS="$DOTFILES/scripts"
fi

if [ "$1" == "basic" ]; then
  install_basic
elif [ "$1" == "package-group" ]; then
  install_package_group "$2"
elif [ "$1" == "link" ]; then
  install_link
elif [ "$1" == "git" ]; then
  configure_git
elif [ "$1" == "all" ]; then
  install_all
fi
