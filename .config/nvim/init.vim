call plug#begin('~/.config/nvim/plugged')

Plug 'derekwyatt/vim-scala'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'google/vim-jsonnet'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'

call plug#end()

set expandtab
set hidden
set list
set modeline
set mouse=
set noautoindent
set nohlsearch
set nojoinspaces
set nostartofline
set ruler
set showcmd
set sw=2
set tags=.tags
set title
set ts=2
set tw=80
set wim=longest,list,full

" http://stackoverflow.com/questions/607435/why-does-vim-save-files-with-a-extension
set nobackup
set noswapfile
set nowritebackup

" Easy most-recent-buffer switching
nnoremap <Tab> :b#<CR>

" Easy next-window switching
nnoremap ` <C-w>w

" Easy buffer switching with fzf
nnoremap <Space> :Bu<CR>

" http://neovim.io/doc/user/nvim_terminal_emulator.html
tnoremap <Esc> <C-\><C-n>

" Split words at periods in bash files
let g:sh_noisk=1

" Don't highlight matching braces
let loaded_matchparen=1

command -nargs=1 VR vertical resize <args>

" https://github.com/neovim/neovim/issues/6802
let $COLORTERM = 'gnome-terminal'
