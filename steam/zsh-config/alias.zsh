asfdir="mono $DOTFILES/steam/ASF"
asfbin="ASF.exe --path='../'"
alias asfc="$asfdir/client/$asfbin --client"
alias asfs="$asfdir/server/$asfbin --server"
alias rdy="echo y | rd"
unset asfdir asfbin
