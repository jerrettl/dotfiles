#!/bin/bash

# Input locations
folders="$DOTFILES/aliases/folders"
configs="$DOTFILES/aliases/configs"

# Output locations
bash_shortcuts="$DOTFILES/aliases/bash_autoaliases"
ranger_shortcuts="$DOTFILES/aliases/ranger_autoaliases"
qute_shortcuts="$DOTFILES/aliases/qute_autoaliases"


# Remove to make way for new
rm -f "$bash_shortcuts" "$ranger_shortcuts" "$qute_shortcuts"


# Folder bindings
sed "/^dotf/d" "$folders" | awk '{print "alias "$1"=\"cd "$2" && l\""}' >> "$bash_shortcuts"
cat "$folders" | awk '{print "map g"$1" cd "$2"\nmap t"$1" tab_new "$2"\nmap m"$1" shell mv %s "$2"\nmap Y"$1" shell cp -r %s "$2""}' >> "$ranger_shortcuts"
cat "$folders" | awk '{print "config.bind(\";"$1"\", \"set downloads.location.directory "$2" ;; hint links download\")"}' >> "$qute_shortcuts"



# Config bindings
cat "$configs" | awk '{print "alias "$1"=\"$EDITOR "$2"\""}' >> "$bash_shortcuts"
cat "$configs" | awk '{print "map "$1" shell $EDITOR "$2""}' >> "$ranger_shortcuts"
