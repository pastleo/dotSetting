-- PastLeo's neovim init.lua
-- =========================
-- taking ideas from https://github.com/ThePrimeagen/init.lua, thanks

-- ## Dependencies
-- * `rg`: faster searcher like `ag`, for telescope content searching
--   https://github.com/BurntSushi/ripgrep
--   * yay -S ripgrep
--   * brew install ripgrep
-- * Nerd fonts on terminal emulator, and set NERD_FONT env to enable
--   https://www.nerdfonts.com/
--   * yay -S ttf-sourcecodepro-nerd
--   * brew tap homebrew/cask-fonts && brew install --cask font-source-code-pro font-sauce-code-pro-nerd-font
--
-- ## Plugins are managed by lazy.nvim
-- * type `:Lzay<CR>` to launch its UI
-- * has `lazy-lock.json`
--   * type `:Lazy restore<CR>` to sync plugins between machines using version info from lock file
--
-- ## LSP servers
-- * type `:Lsp<Tab>` to view current status, restart, install and uninstall LSP servers
-- * a nvim restart might be needed after (un)installing LSP servers
--
-- ## Reset nvim data
-- * `rm -rf ~/.local/share/nvim/`
--
-- ## Nvim lua config dev tips
-- * `<leader>fh` to search for docs, like `:h ...` but better
-- * `print(vim.inspect(some_value))` to debug lua values

-- neovim built-in settings
require('settings')
require('keymaps')

if vim.g.vscode then
  print('neovim: started with vim.g.vscode')
  return
end

--- Define safe_require() globally to get plugins,
---   while preventing error when plugins not installed
--- @param module_name string
--- @return any
function safe_require(module_name)
  local status_ok, module = pcall(require, module_name)
  if not status_ok then return false end
  return module
end

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local cmd = {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
  print('lazy.nvim (plugins manager) not detected, running to install:')
  print(table.concat(cmd, ' '))

  vim.fn.system(cmd)
end
vim.opt.rtp:prepend(lazypath)

local lazyNvimOpts = {
  concurrency = 8
}
require('lazy').setup({
  -- colorscheme & permanent view plugins
  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('colors')
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = function()
      vim.cmd('TSUpdate')
    end,
    config = function()
      require('treesitter-config')
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    lazy = false,
    config = function()
      require('indent_blankline').setup({
        space_char_blankline = ' ',
        show_current_context = true,
      })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    config = function()
      require('gitsigns').setup()
    end,
  },
  {
    'akinsho/bufferline.nvim', version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('bufferline-config')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('lualine-config')
    end,
  },
  {
    'anuvyklack/windows.nvim',
    dependencies = {
      'anuvyklack/middleclass',
      'anuvyklack/animation.nvim',
    },
    lazy = false,
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require('windows').setup()
    end,
  },

  -- coding helper plugins
  {
    'terrortylor/nvim-comment',
    cmd = {
      'CommentToggle',
    },
    config = function()
      require('nvim_comment').setup({
        create_mappings = false
      })
    end,
  },
  {
    'windwp/nvim-autopairs',
    lazy = false,
    config = function()
      require('nvim-autopairs').setup({})
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    lazy = false,
    config = function()
      require('nvim-ts-autotag').setup({})
    end,
  },
  {
    'mattn/emmet-vim',
    cmd = {
      'Emmet',
    },
  },

  -- exploring plugins
  {
    'gbrlsnchs/winpick.nvim',
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    cmd = {
      'NvimTreeOpen',
    },
    config = function()
      require('nvim-tree-config')
    end,
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope-config')
    end,
  },
  {
    'stevearc/aerial.nvim',
    cmd = {
      'AerialOpen',
    },
    config = function()
      require('aerial-config')
    end,
  },

  -- lsp plugins
  {
    'williamboman/mason.nvim',
    build = function()
      pcall(vim.cmd, 'MasonUpdate')
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
  },
  {
    'neovim/nvim-lspconfig',
  },

	-- autocomplete plugins
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
    },
  },

  -- misc plugins
  {
    'tpope/vim-fugitive',
    cmd = {
      'Git', 'Gdiffsplit',
    },
  },
  {
    'rmagatti/auto-session',
    lazy = false,
    config = function()
      require('auto-session-config')
    end
  },
}, lazyNvimOpts)

require('plugins-keymaps')
require('lsp-config')
require('cmp-config')
