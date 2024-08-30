-- Some inspiration from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

-- Set <space> as the leader and \ as the localleader
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- lazy requires luarocks
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },

  -- Git related plugins
  'tpope/vim-fugitive',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- QoL
  'tpope/vim-repeat',
  --'tpope/vim-vinegar',

  {
    'RRethy/nvim-base16',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme base16-primer-dark]])
    end,
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
})

vim.o.autoindent = false
vim.o.bg = 'light'
vim.o.expandtab = true
--vim.o.formatoptions = vim.opt.formatoptions - { 'tc' }
vim.o.hidden = true
vim.o.hlsearch = false
vim.o.joinspaces = false
vim.o.list = true
vim.o.modeline = true
vim.o.mouse = ''
vim.o.ruler = true
vim.o.showcmd = true
vim.o.startofline = false
vim.o.sw = 2
vim.o.tags = '.tags'
vim.o.title = true
vim.o.ts = 2
vim.o.tw = 0
vim.o.wim = 'longest,list,full'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- http://stackoverflow.com/questions/607435/why-does-vim-save-files-with-a-extension
vim.o.backup = false
vim.o.swapfile = false
vim.o.writebackup = false

-- Easy most-recent-buffer switching
vim.keymap.set('n', '<tab>', ':b#<cr>')

-- Skip netrw browsing buffer when switching to last buffer
vim.g.netrw_altfile = 1

-- Hide current and parent directory in netrw
vim.g.netrw_list_hide = '^\\.\\./$,^\\./$'

-- Easy next-window switching
--nnoremap ` <C-w>w
vim.keymap.set('n', '`', '<c-w><c-p>')

-- Easy buffer switching with fzf
--nnoremap <Space> :Bu<CR>

-- Redo with U instead of Ctrl+R
vim.keymap.set('n', 'U', '<c-r>')

-- Map dash to netrw
vim.keymap.set('n', '-', ':Explore<cr>')

-- http://neovim.io/doc/user/nvim_terminal_emulator.html
--tnoremap <Esc> <C-\><C-n>
vim.keymap.set('t', '<esc>', '<c-\\><c-n>')

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

-- Ignore bad editor configs
vim.g.editorconfig = false

-- Set Visual highlight to reverse to avoid hiding text
vim.api.nvim_set_hl(0, 'Visual', {reverse = true})

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'terraform', 'typescript', 'vimdoc', 'vim', 'bash' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
  }
end, 0)

--require('nvim-treesitter.configs').setup {
--  highlight = {
--    enable = true,
--    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
--    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
--    -- Using this option may slow down your editor, and you may see some duplicate highlights.
--    -- Instead of true it can also be a list of languages
--    additional_vim_regex_highlighting = false,
--  }
--}

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
    find_files = {
      hidden = true
    },
    grep_string = {
      additional_args = {"--hidden"}
    },
    live_grep = {
      additional_args = {"--hidden"}
    },
  },
}
vim.keymap.set('n', '<m-p>', require('telescope.builtin').find_files)
vim.keymap.set('n', '<space>', require('telescope.builtin').buffers)
vim.keymap.set('n', '<m-8>', require('telescope.builtin').grep_string)
vim.keymap.set('n', '<m-/>', require('telescope.builtin').live_grep)
