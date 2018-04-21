# Fish config

set fish_greeting ""
set -Ux EDITOR nvim

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
alias v=$EDITOR
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'

# ==== Common Directories
alias dotf='cd ~/dotfiles; and gstu'
alias dotu='dotf; and git pull; and cd'

alias gcc='cd (find ~ -maxdepth 4 2>/dev/null | grep -s "grade-calculator\$" | cat); and gstu'
function gcv
	gcc
	eval $EDITOR grade-calculator.py
end
funcsave gcv

# ==== Mounting
alias mnttv='sshfs jerrett@192.168.1.11:/media/usb0/Files/Documents/tv ~/mnt -C -p 21999'
alias umntssh='fusermount -u ~/mnt'
alias umntusb='sudo umount ~/mnt'

alias s='cd (find /media -maxdepth 1 | grep -i ssh)'
alias umnts='udevil umount (find /media -maxdepth 1 | grep -i ssh)'


# DO NOT DELETE LMAO
alias doc="cd ~/Documents; and l"
alias dow="cd ~/Downloads; and l"
alias dotf="cd ~/dotfiles; and gstu"
alias www="cd /srv/http; and l"
alias tv="cd /media/usb0/Files/Documents/tv; and l"
alias movies="cd /media/usb0/Files/Documents/movies; and l"
alias usb0="cd /media/usb0; and l"
alias usb1="cd /media/usb1; and l"
alias d="cd ~/Downloads; and l"
alias D="cd ~/Documents; and l"
alias m="cd ~/Music; and l"
alias pp="cd ~/Pictures; and l"
alias vv="cd ~/Videos; and l"
alias sch="cd ~/Documents/school; and l"
alias mm="cd /media; and l"
alias zrc="nvim ~/.zshrc"
alias zshrc="nvim ~/.zshrc"
alias vrc="nvim ~/.vimrc"
alias vimrc="nvim ~/.vimrc"
alias i3rc="nvim ~/.config/i3/config"
alias cff="nvim ~/.config/Scripts/folders"
alias cfc="nvim ~/.config/Scripts/configs"
alias cfb="nvim ~/.bashrc"
alias cfz="nvim ~/.zshrc"
alias cfv="nvim ~/.vimrc"
alias cfr="nvim ~/.config/ranger/rc.conf"
alias cfi="nvim ~/.config/i3/config"
alias cfq="nvim ~/.config/qutebrowser/config.py"
alias cfm="nvim ~/.config/mutt/muttrc"
alias cft="nvim ~/.config/termite/config"
alias eb="nvim ~/Documents/LaTeX/uni.bib"
alias cv="nvim ~/Documents/LaTeX/cv.tex"
alias cfp="nvim ~/.config/polybar/config"
alias cfd="nvim ~/.Xdefaults"
alias cfn="nvim ~/.newsboat/urls"
alias cfA="nvim ~/.asoundrc"
alias cfmb="nvim ~/.ncmpcpp/bindings"
alias cfmc="nvim ~/.ncmpcpp/config"
alias cfmpd="nvim ~/.config/mpd/mpd.conf"
alias cfM="nvim ~/.config/mpd/mpd.conf"
alias cfx="nvim ~/.Xresources"
alias xrc="nvim ~/.Xresources"
# DO NOT DELETE LMAO
