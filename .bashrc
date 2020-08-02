# Stop early if the shell is non-interactive
if [[ $- != *i* ]]; then return; fi

export BROWSER="/usr/bin/firefox"
export EDITOR="/usr/bin/nvim"
export DOTFILES="$HOME/dotfiles"

[ -f "$DOTFILES"/aliases/aliases ] && . "$DOTFILES"/aliases/aliases
[ -f "$DOTFILES"/aliases/bash_autoaliases ] && . "$DOTFILES"/aliases/bash_autoaliases

# Host-specific aliases
hsa="$DOTFILES/aliases/aliases-$(hostname)"
if [ -f "$hsa" ]; then
  . "$hsa"
fi

[ -f /usr/share/doc/pkgfile/command-not-found.bash ] && source /usr/share/doc/pkgfile/command-not-found.bash


RED="\[$(tput setaf 1)\]"
GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"
BOLD="\[$(tput bold)\]"

if [ "$(id -u)" -eq 0 ]; then
	PS1="${BOLD}$(uname -n)${RESET} ${RED}\$(pwd | sed \"s|^$HOME|~|\")${RESET}> "
else
	PS1="${BOLD}$(uname -n)${RESET} ${GREEN}\$(pwd | sed \"s|^$HOME|~|\")${RESET}> "
fi

# Custom functions
makenotes() {
  pandoc "$1.md" -o "$1.html" --self-contained
}

# Change directory by typing its name
shopt -s autocd

# When the shell exits, append to history, not overwrite
shopt -s histappend

# Disable Ctrl-J and Ctrl-S console breaking
stty -ixon

# Unlimited command history
export HISTFILESIZE=-1
export HISTSIZE=-1

# Avoid duplicates
HISTCONTROL=ignoredups:erasedups

bind '"\t":menu-complete'

# Fuzzy file completion
bind -x '"\C-f":"xdotool type $(find . | sed '"'"'s/^..//'"'"' | fzf)"'

if [ "$(hostname)" == "DESKTOP-DNH8H8Q" ]; then
  export LIBGL_ALWAYS_INDIRECT=1
  export DISPLAY=:0
fi

# Vi mode (with some modifications)
set -o vi
bind '"jk":vi-movement-mode'
bind '"\C-l":clear-screen'

export PATH="$PATH:/opt/cisco/anyconnect/bin/:/opt/fah/:/usr/NX/bin/"

if [ "$(hostname)" == "DESKTOP-DNH8H8Q" ]; then
  cd ~
fi

which keychain 2>/dev/null > /dev/null && eval $(keychain --eval --quiet --nogui --noask --agents ssh id_rsa)
