# Environment
export EDITOR='/usr/bin/nvim'

## XDG
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

## Application files

### History files
export LESSHISTFILE=$XDG_STATE_HOME/less/history
export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"

### Home dirs
export PYENV_ROOT="$XDG_STATE_HOME/python/env"
export CARGO_HOME=$XDG_DATA_HOME/cargo
export GOPATH=$XDG_DATA_HOME/go

## Path
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.config/lf/bin"

## Other
export _JAVA_AWT_WM_NONREPARENTING=1
