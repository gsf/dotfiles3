# Install nvr from https://github.com/mhinz/neovim-remote
export EDITOR="nvr -s --remote-wait-silent"
alias v=$EDITOR

# Override fancy prompt
PS1="\$ "

# For xdg executables
export PATH=$HOME/.local/bin:$PATH
