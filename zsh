# Location: ~/.zshrc
#
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/jerrett/.oh-my-zsh
export TERM="xterm-256color"
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
autoload zmv

source $ZSH/oh-my-zsh.sh

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# export MANPATH="/usr/local/man:$MANPATH"
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"
export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/firefox

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history time)
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='white'

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Aliases
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less
alias dotf='cd ~/dotfiles'
alias con='nano $HOME/.i3/config'
alias comp='nano $HOME/.config/compton.conf'
alias fixit='sudo rm -f /var/lib/pacman/db.lck'
alias inst='sudo pacman -S'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias mirrors='sudo pacman-mirrors -g'
alias printer='system-config-printer'
alias update='yaourt -Syua'
alias cls='clear'
alias www='cd /srv/http'
alias gst='git status -uno'
alias tv='cd /media/usb0/Files/Documents/tv'
alias movies='cd /media/usb0/Files/Documents/movies'
alias zrc='vim ~/.zshrc'
alias vrc='vim ~/.vimrc'
