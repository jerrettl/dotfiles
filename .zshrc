# Location: ~/.zshrc

export ZSH=/home/jerrett/.oh-my-zsh
export TERM="xterm-256color"
ZSH_THEME="powerlevel9k/powerlevel9k"

# Default plugins at ~/.oh-my-zsh/plugins/
# Custom plugins at ~/.oh-my-zsh/custom/plugins/
plugins=(git vi-mode)
autoload zmv

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"
export EDITOR=/usr/bin/vim



# ==== Powerlevel9k
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context root_indicator dir vi_mode newline rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(history time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=false
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
#POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX=" ↳ "

POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='white'
POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND='black'
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND='yellow'
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='112'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='022'
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='white'
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='027'



# ==== Aliases
if [ -f ~/Documents/aliases ]; then
    . ~/Documents/aliases
fi

if [ -f ~/dotfiles/aliases ]; then
    . ~/dotfiles/aliases
fi


## ==== Perl
#PATH="/home/jerrett/perl5/bin${PATH:+:${PATH}}"; export PATH;
#PERL5LIB="/home/jerrett/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
#PERL_LOCAL_LIB_ROOT="/home/jerrett/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
#PERL_MB_OPT="--install_base \"/home/jerrett/perl5\""; export PERL_MB_OPT;
#PERL_MM_OPT="INSTALL_BASE=/home/jerrett/perl5"; export PERL_MM_OPT;
#
## ==== Go
#export GOPATH=$HOME/.go
#export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

