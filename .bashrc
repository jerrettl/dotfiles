export EDITOR="/usr/bin/nvim"
export DOTFILES="$HOME/dotfiles"

. "$DOTFILES"/aliases/aliases
. "$DOTFILES"/aliases/bash_autoaliases

source /usr/share/doc/pkgfile/command-not-found.bash


RED="\[$(tput setaf 1)\]"
GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"
BOLD="\[$(tput bold)\]"

if [ "$(id -u)" -eq 0 ]; then
	PS1="${BOLD}$(uname -n)${RESET} ${RED}\$(pwd | sed \"s|^$HOME|~|\")${RESET}> "
else
	PS1="${BOLD}$(uname -n)${RESET} ${GREEN}\$(pwd | sed \"s|^$HOME|~|\")${RESET}> "
fi

# Change directory by typing its name
shopt -s autocd

# Disable Ctrl-J and Ctrl-S console breaking
stty -ixon

# Unlimited command history
export HISTFILESIZE=-1
export HISTSIZE=-1

bind '"\t":menu-complete'

# Fuzzy file completion
bind -x '"\C-f":"xdotool type $(fzf)"'

if [ "$(hostname)" == "DESKTOP-DNH8H8Q" ]; then
  export LIBGL_ALWAYS_INDIRECT=1
  export DISPLAY=:0
fi
