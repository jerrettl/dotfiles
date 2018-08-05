export EDITOR="/usr/bin/nvim"
export DOTFILES="$HOME/dotfiles"

. $DOTFILES/aliases/aliases
. $DOTFILES/aliases/bash_autoaliases

source /usr/share/doc/pkgfile/command-not-found.bash


GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"
BOLD="\[$(tput bold)\]"

export PS1="${BOLD}$(uname -n)${RESET} ${GREEN}\$(pwd)${RESET}> "
