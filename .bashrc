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

export PATH="$PATH:/opt/cisco/anyconnect/bin/:/opt/fah/"

if [ "$(uname -n)" != "raspberrypi" ]; then
  if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    GIT_PROMPT_THEME=Custom
    GIT_PROMPT_THEME_FILE=~/.git-prompt-colors.sh
    source $HOME/.bash-git-prompt/gitprompt.sh
  else
    echo "Git prompt not installed. Run the following command to set up:"
    echo "git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1"
    echo "More information can be found at https://github.com/magicmonty/bash-git-prompt"
  fi
fi

if [ "$(hostname)" == "DESKTOP-DNH8H8Q" ]; then
  cd ~
fi
