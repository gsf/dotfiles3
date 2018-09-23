# The standard editor
export EDITOR='rlfe ed'
alias e="$EDITOR"

# Install nvr from https://github.com/mhinz/neovim-remote
alias v='nvr -s --remote-wait-silent'

# Override fancy prompt
PS1="\$ "

# For xdg executables
export PATH=$HOME/bin:$HOME/.local/bin:$PATH
