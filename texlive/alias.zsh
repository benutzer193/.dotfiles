#blalSystem tools
alias ls="ls --color=auto -a"
alias mount="sudo mount"
alias umount="sudo umount"
alias xclip="xclip -selection c"
alias xpaste="xclip -selection clipboard -o"

# Power options 
alias shutdown="sudo shutdown"
alias reboot="sudo reboot"

# TexLive
alias tlin="sudo tlmgr install"
alias tlmgr="sudo tlmgr"
alias tlup="sudo tlmgr update --all && sudo texhash ~/.texmf && sudo texhash"
alias tldump="rm -i ~/.dotfiles/texlivedb && tlmgr dump-tlpdb --local > ~/.dotfiles/texlivedb"

# VPN / RDP
alias vpnuni="sudo vpnc unimainz"
alias vpns="sudo vpnc-disconnect"
alias rbnhs="xfreerdp +clipboard /v:BNHS /u:Administrator /drive:/home/bnichell"

# other
alias svim="sudo vim"
