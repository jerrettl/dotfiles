# Fish config

set fish_greeting ""

# ==== Commands
alias cls='clear'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias gst='git status -uno'
alias gstu='git status -uall'
alias l='ls -al --color=auto -F'
alias la='ls -al --color=auto -F'
alias ll='ls -l --color=auto -F'
alias more=less
alias su='sudo -Es'
alias update='pacaur -Syyu'
alias yt='~/dotfiles/scripts/youtube.sh'
alias bashbot='cd ~/Documents/telegram-bot-bash/; and ./bashbot.sh start'
alias gd='git diff'
alias v='vim'

# ==== Common Directories
alias dotf='cd ~/dotfiles; and gstu'
alias dotu='dotf; and git pull; and cd'

alias gc='cd (find ~ 2>/dev/null | grep -s "grade-calculator\$" | cat); and gstu'
alias gcv='gc; and vim grade-calculator.py'

# ==== Mounting
alias mnttv='sshfs jerrett@192.168.1.11:/media/usb0/Files/Documents/tv ~/mnt -C -p 21999'
alias umntssh='fusermount -u ~/mnt'
alias umntusb='sudo umount ~/mnt'


# DO NOT DELETE LMAO
alias doc="cd ~/Documents; and l"
alias dow="cd ~/Downloads; and l"
alias dotf="cd ~/dotfiles; and gstu"
alias www="cd /srv/http; and l"
alias tv="cd /media/usb0/Files/Documents/tv; and l"
alias movies="cd /media/usb0/Files/Documents/movies; and l"
alias usb0="cd /media/usb0; and l"
alias usb1="cd /media/usb1; and l"
alias d="cd ~/Documents; and l"
alias D="cd ~/Downloads; and l"
alias m="cd ~/Music; and l"
alias pp="cd ~/Pictures; and l"
alias vv="cd ~/Videos; and l"
alias sch="cd ~/Documents/school; and l"
alias zrc="vim ~/.zshrc"
alias zshrc="vim ~/.zshrc"
alias vrc="vim ~/.vimrc"
alias vimrc="vim ~/.vimrc"
alias i3rc="vim ~/.config/i3/config"
alias cff="vim ~/.config/Scripts/folders"
alias cfc="vim ~/.config/Scripts/configs"
alias cfb="vim ~/.bashrc"
alias cfz="vim ~/.zshrc"
alias cfv="vim ~/.vimrc"
alias cfr="vim ~/.config/ranger/rc.conf"
alias cfi="vim ~/.config/i3/config"
alias cfq="vim ~/.config/qutebrowser/config.py"
alias cfm="vim ~/.config/mutt/muttrc"
alias cft="vim ~/.config/termite/config"
alias eb="vim ~/Documents/LaTeX/uni.bib"
alias cv="vim ~/Documents/LaTeX/cv.tex"
alias cfp="vim ~/.config/polybar/config"
alias cfd="vim ~/.Xdefaults"
alias cfn="vim ~/.newsboat/urls"
alias cfA="vim ~/.asoundrc"
alias cfmb="vim ~/.ncmpcpp/bindings"
alias cfmc="vim ~/.ncmpcpp/config"
alias cfmpd="vim ~/.config/mpd/mpd.conf"
alias cfM="vim ~/.config/mpd/mpd.conf"
alias cfx="vim ~/.Xresources"
alias xrc="vim ~/.Xresources"
# DO NOT DELETE LMAO
