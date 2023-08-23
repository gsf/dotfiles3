vim.opt.autoindent = false
vim.opt.bg = 'light'
vim.opt.expandtab = true
vim.opt.formatoptions = vim.opt.formatoptions - { 'tc' }
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.joinspaces = false
vim.opt.list = true
vim.opt.modeline = true
vim.opt.mouse = ''
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.startofline = false
vim.opt.sw = 2
vim.opt.tags = '.tags'
vim.opt.title = true
vim.opt.ts = 2
vim.opt.tw = 0
vim.opt.wim = 'longest,list,full'

-- http://stackoverflow.com/questions/607435/why-does-vim-save-files-with-a-extension
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

vim.cmd('colorscheme base16-primer-dark')

-- Easy most-recent-buffer switching
vim.api.nvim_set_keymap("n", "<tab>", ":b#<cr>", { noremap = true })

-- Skip netrw browsing buffer when switching to last buffer
vim.g.netrw_altfile = 1

-- Easy next-window switching
--nnoremap ` <C-w>w
vim.api.nvim_set_keymap("n", "`", "<c-w><c-p>", { noremap = true })

-- Easy buffer switching with fzf
--nnoremap <Space> :Bu<CR>

-- Redo with U instead of Ctrl+R
vim.api.nvim_set_keymap("n", "U", "<c-r>", { noremap = true })

-- http://neovim.io/doc/user/nvim_terminal_emulator.html
--tnoremap <Esc> <C-\><C-n>
vim.api.nvim_set_keymap("t", "<esc>", "<c-\\><c-n>", { noremap = true })

-- Semicolon to colon http://vim.wikia.com/wiki/Map_semicolon_to_colon
--map ; :

-- Split words at periods in bash files
--let g:sh_noisk=1

-- Don't highlight matching braces
vim.g.loaded_matchparen = 1

-- Allows me to :VR80 to resize buffer to 80 cols
--command -nargs=1 VR vertical resize <args>

-- Now :WQ will write and close buffer without closing pane
--command WQ :w|:BD

-- New terminals start in insert mode
--autocmd TermOpen * startinsert
--vim.api.nvim_create_autocmd({"TermOpen"}, {
--  pattern = {"*"},
--  command = "startinsert",
--})

-- Jump into insert when switching back to a terminal
--autocmd BufWinEnter,WinEnter term://* startinsert
--vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter", "WinEnter"}, {
--  pattern = {"term://*"},
--  command = "startinsert",
--})

-- Set Visual highlight to reverse to avoid hiding text
vim.api.nvim_set_hl(0, 'Visual', {reverse = true})

require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'RRethy/nvim-base16'

  use 'https://tpope.io/vim/fugitive.git'
  use 'https://tpope.io/vim/repeat.git'
  use 'https://tpope.io/vim/vinegar.git'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    }
  }
end)

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  }
}

local actions = require("telescope.actions")
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  },
  pickers = {
    buffers = {
        ignore_current_buffer = true,
        sort_lastused = true,
        sort_mru = true,
    },
  },
}
vim.api.nvim_set_keymap("n", "<m-p>",
  "<cmd>lua require('telescope.builtin').find_files()<cr>",
  { noremap = true })
vim.api.nvim_set_keymap("n", "<space>",
  "<cmd>lua require('telescope.builtin').buffers()<cr>",
  { noremap = true })
vim.api.nvim_set_keymap("n", "<m-8>",
  "<cmd>lua require('telescope.builtin').grep_string()<cr>",
  { noremap = true })
vim.api.nvim_set_keymap("n", "<m-/>",
  "<cmd>lua require('telescope.builtin').live_grep()<cr>",
  { noremap = true })
