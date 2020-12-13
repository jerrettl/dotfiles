#!/bin/bash

bash_folder_bind() {
  sed "/^dotf/d" "$1" | awk '{print "alias "$1"=\"cd "substr($0, index($0, $2))" && l\""}' >> "$bash_shortcuts"
}

bash_config_bind() {
  cat "$1" | awk '{print "alias "$1"=\"$EDITOR "substr($0, index($0, $2))"\""}' >> "$bash_shortcuts"
}

ranger_folder_bind() {
  cat "$1" | sed 's/\\//g' | awk '{print "map g"$1" cd "substr($0, index($0, $2))"\nmap t"$1" tab_new "substr($0, index($0, $2))"\nmap m"$1" shell mv %s "substr($0, index($0, $2))"\nmap Y"$1" shell cp -r %s "substr($0, index($0, $2))""}' >> "$ranger_shortcuts"
}

ranger_config_bind() {
  cat "$1" | sed 's/\\//g' | awk '{print "map "$1" shell $EDITOR "substr($0, index($0, $2))""}' >> "$ranger_shortcuts"
}

qute_folder_bind() {
  cat "$1" | awk '{print "config.bind(\";"$1"\", \"set downloads.location.directory "substr($0, index($0, $2))" ;; hint links download\")"}' >> "$qute_shortcuts"
}

# Input locations
folders="$DOTFILES/aliases/folders"
folders_custom="$DOTFILES/aliases/folders-$(hostname)"
configs="$DOTFILES/aliases/configs"
configs_custom="$DOTFILES/aliases/configs-$(hostname)"

# Output locations
bash_shortcuts="$DOTFILES/aliases/bash_autoaliases"
ranger_shortcuts="$DOTFILES/aliases/ranger_autoaliases"
qute_shortcuts="$HOME/.config/qutebrowser/qute_autoaliases"


# Remove to make way for new
rm -f "$bash_shortcuts" "$ranger_shortcuts" "$qute_shortcuts"


# Folder bindings
bash_folder_bind "$folders"
ranger_folder_bind "$folders"
qute_folder_bind "$folders"

if [ -f "$folders_custom" ]; then
  bash_folder_bind "$folders_custom"
  ranger_folder_bind "$folders_custom"
  qute_folder_bind "$folders_custom"
fi


# Config bindings
bash_config_bind "$configs"
ranger_config_bind "$configs"

if [ -f "$configs_custom" ]; then
  bash_config_bind "$configs_custom"
  ranger_config_bind "$configs_custom"
fi

source $DOTFILES/.config/shell/bashrc
