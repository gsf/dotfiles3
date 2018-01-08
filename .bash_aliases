# v will attach or create an abduco session running neovim and if run
# in a neovim terminal it will open files in the existing neovim
v () {
  if [ -z "$NVIM_LISTEN_ADDRESS" ]; then
    abduco -A ${1-nvim-session} nvim
  else
    nvr "$@"
  fi
}
alias v=v
export EDITOR=v
