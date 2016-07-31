# global aliases
alias -g LL=" | less"
alias -g GG=" | grep"
alias -g grep="grep --color"

# ls commands
alias ls="ls -X --color=auto --group-directories-first"
alias la="ls -A"
alias ll="ls -lh"
alias lla="la -lh"
alias l.="ls -d .*"

# sudo
alias please='sudo $(fc -ln -1)'
alias mount="sudo mount"
alias umount="sudo umount"

# cd commands
alias d='dirs -v'                                                   # show cd history
for index ({1..9}) alias "$index"="cd +${index}"; unset index       # go through history
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'

# cp / mv / rm / mkdir commands
alias cp="cp -iv"
alias trash="mv -t ~/trash"
alias mv=" mv -iv"
alias mkdir="mkdir -pv"
alias rm=" rm -Iv --one-file-system --preserve-root"

# misc
alias e='extract'
alias process="ps aux | grep -v grep | grep -i -e VSZ -e"
alias wget="wget -c"

# systemd
alias journalctl-errors='journalctl -p 0..4 -xlkr'
alias shutdown="systemctl poweroff"
alias reboot="systemctl reboot"
