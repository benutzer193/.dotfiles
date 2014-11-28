# ls commands
alias ls="ls -X --color=auto"
alias la="ls -a"
alias ll="ls -lh"
alias l.="ls -d .*"

# sudo
alias mount="sudo mount"
alias umount="sudo umount"
alias shutdown="sudo shutdown"
alias reboot="sudo reboot"

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

# copy / paste
alias xclip="xclip -selection c"
alias xpaste="xclip -selection clipboard -o"
