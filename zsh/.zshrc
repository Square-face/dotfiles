
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# Neovim
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# ls
alias ls='eza'
alias ll='eza -l'
alias la='eza -a'
alias l='eza -la'

# git
alias gs="git status";
alias gd="git diff";
alias gdc="git diff --cached";
alias gpl="git pull";
alias gpu="git push";

alias gl="git log";
alias glg="git log --graph --oneline --all";

alias gc="git commit";
alias gcm="git commit -m";
alias gca="git commit --amend --no-edit"; # amend to previous commit without launching an editor to edit the commit message
alias gce="git commit --amend"; # amend to previous commit and allow the commit message to be edited

alias ga="git add";
alias gaa="git add .";
alias gai="git add -i ";

alias gr="git rebase";
alias gri="git rebase -i";
alias grc="git rebase --continue";

alias gC="git checkout"
alias gCb="git checkout -b"

# cd 
alias .="cd ~"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias pwninit='pwninit --template-path ~/.config/pwninit/template.py'
alias disass='objdump -M intel -d'
alias gettext='objcopy --dump-section .text=payload.text'
alias ocr='tesseract'

alias kill_spot='kill $(pidof spotify_player)'
alias stream_lennart='ffmpeg -re -f mjpeg -i "http://lennart/webcam/?action=stream" -vf "hflip,format=rgb24" -f v4l2 /dev/video10'

# Environment
export EDITOR='/usr/bin/nvim'

export GOPATH=$HOME/go
export PYENV_ROOT="$HOME/.pyenv"

[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.config/lf/bin

export XDG_STATE_HOME=$HOME/.state
export XDG_CONFIG_HOME=$HOME/.config

export LESSHISTFILE=$XDG_STATE_HOME/less/history

export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=sway
export _JAVA_AWT_WM_NONREPARENTING=1

GPG_TTY=$(tty)
export GPG_TTY

# hooks
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval "$(pyenv init - zsh)"

# LF
lf () {
	LF_TEMPDIR="$(mktemp -d -t lf-tempdir-XXXXXX)"
	LF_TEMPDIR="$LF_TEMPDIR" lf-run -last-dir-path="$LF_TEMPDIR/lastdir" "$@"
	if [ "$(cat "$LF_TEMPDIR/cdtolastdir" 2>/dev/null)" = "1" ]; then
		cd "$(cat "$LF_TEMPDIR/lastdir")"
	fi
	rm -r "$LF_TEMPDIR"
	unset LF_TEMPDIR
}

# shell completions
autoload -Uz compinit && compinit

zstyle ':completion:*:*:cp:*' file-sort size
zstyle ':completion:*' file-sort modification
