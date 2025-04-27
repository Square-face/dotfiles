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
alias gca="git commit --amend --no-edit";
alias gce="git commit --amend";

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
