
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

source $ZDOTDIR/aliases.sh
source $ZDOTDIR/environment.sh

# hooks
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval "$(pyenv init - zsh)"

# shell completions
autoload -Uz compinit && compinit

zstyle ':completion:*:*:cp:*' file-sort size
zstyle ':completion:*' file-sort modification
