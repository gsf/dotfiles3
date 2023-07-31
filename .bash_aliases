# The standard editor
export EDITOR="rlwrap -c -e '' -H ~/.ed_history ed"
alias e="$EDITOR"

# Install nvr from https://github.com/mhinz/neovim-remote
alias v='nvr -s --remote-wait-silent'

# Override fancy prompt
PS1="\$ "

# Extend the execution path
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/go/bin:$PATH

# .env loading in the shell
# Inspired by http://stackoverflow.com/a/21831665/589391 and
# https://github.com/gchaincl/dotenv.sh, then re-inspired
# by the "set -a" trick from timwis
dotenv () {
  set -a
  [ -f .env ] && . .env
  set +a
}

# Run dotenv on login
dotenv

# Run dotenv on every new directory
cd () {
  builtin cd $@
  dotenv
}
