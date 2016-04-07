if [[ -n $SSH_CONNECTION ]]; then
  export PS1='%m:%3~$(git_info_for_prompt)%# '
else
  export PS1='%3~$(git_info_for_prompt)%# '
fi

export EDITOR="vim"
export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

fpath=($_DF/functions $fpath)

autoload -U $_DF/functions/*(:t)

setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt PROMPT_SUBST
setopt CORRECT

setopt IGNORE_EOF
setopt NO_BEEP

BASE16_SHELL="$HOME/.dotfiles/zsh/colorschemes/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL


zle -N newtab
