#!/bin/bash

bash_folder_bind() {
  sed "/^dotf/d" "$1" | awk '{print "alias "$1"=\"cd "substr($0, index($0, $2))" && l\""}' >> "$bash_shortcuts"
}

bash_config_bind() {
  cat "$1" | awk '{print "alias "$1"=\"$EDITOR "substr($0, index($0, $2))"\""}' >> "$bash_shortcuts"
}

ranger_folder_bind() {
  cat "$1" | sed 's/\\//g' | sed -E 's/\$([A-Z_]*)/\"\ \+\ os.getenv('"'"'\1\'"'"')\ +\ \"/' | awk '{print "map g"$1" eval fm.cd(\""substr($0, index($0, $2))"\")"}' >> "$ranger_shortcuts"
  cat "$1" | sed 's/\\//g' | sed -E 's/\$([A-Z_]*)/\"\ \+\ os.getenv('"'"'\1\'"'"')\ +\ \"/' | awk '{print "map t"$1" eval fm.tab_new(\""substr($0, index($0, $2))"\")"}' >> "$ranger_shortcuts"
  cat "$1" | sed 's/\\//g' | awk '{print "map m"$1" shell mv %s "substr($0, index($0, $2))""}' >> "$ranger_shortcuts"
  cat "$1" | sed 's/\\//g' | awk '{print "map Y"$1" shell cp -r %s "substr($0, index($0, $2))""}' >> "$ranger_shortcuts"
}

ranger_config_bind() {
  cat "$1" | sed 's/\\//g' | awk '{print "map "$1" shell $EDITOR "substr($0, index($0, $2))""}' >> "$ranger_shortcuts"
}

qute_folder_bind() {
  cat "$1" | awk '{print "config.bind(\";"$1"\", \"set downloads.location.directory "substr($0, index($0, $2))" ;; hint links download\")"}' >> "$qute_shortcuts"
}

# Input locations
aliases_location="$DOTFILES/aliases"
folders="$aliases_location/folders"
folders_custom="$aliases_location/folders-$(hostname)"
configs="$aliases_location/configs"
configs_custom="$aliases_location/configs-$(hostname)"
group_list="$aliases_location/groups"

# Output locations
bash_shortcuts="$DOTFILES/aliases/bash_autoaliases"
ranger_shortcuts="$DOTFILES/aliases/ranger_autoaliases"
qute_shortcuts="$HOME/.config/qutebrowser/qute_autoaliases"


# Remove to make way for new
rm -f "$bash_shortcuts" "$ranger_shortcuts" "$qute_shortcuts"
echo "Old shortcuts deleted."


# Parse group list file
if [ -f "$group_list" ]; then
  groups=$(sed --quiet '/^'$(hostname)'/p' "$group_list" | cut -d' ' -f2- | sed 's/ /\n/g')
else
  groups=""
fi
echo "Groups parsed."


# Folder bindings
echo "Binding folders..."
bash_folder_bind "$folders"
ranger_folder_bind "$folders"
qute_folder_bind "$folders"
echo " - Global folders"

for group in $groups; do
  group_folders="$aliases_location/folders--$group"
  if [ -f "$group_folders" ]; then
    bash_folder_bind "$group_folders"
    ranger_folder_bind "$group_folders"
    qute_folder_bind "$group_folders"
    echo " - Group folders: $group"
  fi
done

if [ -f "$folders_custom" ]; then
  bash_folder_bind "$folders_custom"
  ranger_folder_bind "$folders_custom"
  qute_folder_bind "$folders_custom"
  echo " - Machine folders"
fi

echo "Folders bound."



# Config bindings
echo "Binding configs..."
bash_config_bind "$configs"
ranger_config_bind "$configs"
echo " - Global configs"

for group in $groups; do
  group_aliases="$aliases_location/aliases--$group"
  if [ -f "$group_aliases" ]; then
    bash_config_bind "$group_aliases"
    ranger_config_bind "$group_aliases"
    echo " - Group configs: $group"
  fi
done

if [ -f "$configs_custom" ]; then
  bash_config_bind "$configs_custom"
  ranger_config_bind "$configs_custom"
  echo " - Machine configs"
fi

echo "Configs bound."

source $DOTFILES/.config/shell/bashrc
echo "Finished."
