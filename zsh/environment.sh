# Environment

## XDG
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

## Application files
export UV_CACHE_DIR="$XDG_CACHE_HOME/uv"
export UV_INSTALL_DIR="$XDG_DATA_HOME/uv/bin"
export UV_TOOL_DIR="$XDG_DATA_HOME/uv/tools"
export UV_TOOL_BIN_DIR="$XDG_DATA_HOME/uv/tools/bin"
export BOB_DIR="$XDG_DATA_HOME/bob/nvim-bin"

### History files
export LESSHISTFILE=$XDG_STATE_HOME/less/history
export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"

### Home dirs
export BUN_INSTALL="$XDG_DATA_HOME/bun" 
export PYENV_ROOT="$XDG_STATE_HOME/python/env"
export CARGO_HOME=$XDG_DATA_HOME/cargo
export GOPATH=$XDG_DATA_HOME/go
export HISTFILE=$XDG_CACHE_HOME/zsh/history

## Path
FPATH="$HOME/.docker/completions:$FPATH"

export PATH="$UV_INSTALL_DIR:$PATH"
export PATH="$UV_TOOL_BIN_DIR:$PATH"
export PATH="$PATH:$CARGO_HOME/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$BOB_DIR"
export PATH="$PATH:$BUN_INSTALL/bin"
export PATH="$PATH:/opt/homebrew/bin"

export EDITOR="$BOB_DIR/nvim"

## Other
export _JAVA_AWT_WM_NONREPARENTING=1

