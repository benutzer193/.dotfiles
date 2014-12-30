# global aliases
alias -g LL=" | less -R"
alias -g GG=" | grep"
alias -g grep="grep --color"

# ls commands
alias ls="ls -X --color=auto"
alias la="ls -a"
alias ll="ls -lh"
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

# cp / mv / rm commands
alias cp="cp -iv"
alias trash="mv -t ~/trash"
alias mv="mv -iv"

alias xcopy="xclip -selection c"
alias xpaste="xclip -selection clipboard -o"

# systemd
alias journalctl-errors="journalctl -p 0..3 -xn"
alias shutdown="systemctl poweroff"
alias reboot="systemctl reboot"
