alias tlin="sudo tlmgr install"
alias tlmgr="sudo tlmgr"
alias tlup="sudo tlmgr update --all && sudo texhash ~/.texmf && sudo texhash"
alias tldump="rm -i ~/.dotfiles/texlive/texlivedb && tlmgr dump-tlpdb --local > ~/.dotfiles/texlivedb"
