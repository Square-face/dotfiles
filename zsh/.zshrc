
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

source $ZDOTDIR/aliases.sh
source $ZDOTDIR/environment.sh

# GPG
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye > /dev/null

# hooks
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

# shell completions
autoload -Uz compinit && compinit

zstyle ':completion:*:*:cp:*' file-sort size
zstyle ':completion:*' file-sort modification

# bun completions
[ -s "/home/sq8/.bun/_bun" ] && source "/home/sq8/.bun/_bun"
