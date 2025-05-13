
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

source $ZDOTDIR/aliases.sh
source $ZDOTDIR/environment.sh

# hooks
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

# GPG
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
gpgconf --launch gpg-agent

# shell completions
autoload -Uz compinit && compinit

zstyle ':completion:*:*:cp:*' file-sort size
zstyle ':completion:*' file-sort modification
