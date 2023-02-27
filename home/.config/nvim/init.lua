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
--   * brew tap homebrew/cask-fonts && brew install --cask font-sauce-code-pro-nerd-font
--
-- ## Nvim lua config dev tips
-- * `<leader>fh` to search for docs, like `:h ...` but better
-- * `print(vim.inspect(some_value))` to debug lua values

-- ## TODO: checkout nvim plugins & configs
-- * LSP Autocompletion tab selection behavior when only 1 item
-- * better JSX support
--   * https://github.com/windwp/nvim-autopairs
-- * `<leader>W` has some problem on mac
-- * https://github.com/wfxr/minimap.vim

-- neovim built-in settings
require('settings')
require('keymaps')

--- Define safe_require() globally to get Packer plugins,
---   while preventing error when Packer plugins not installed
--- @param module_name string
--- @return any
function safe_require(module_name)
  local status_ok, module = pcall(require, module_name)
  if not status_ok then return false end
  return module
end

-- Packer.nvim for nvim plugins management:
--   https://github.com/wbthomason/packer.nvim
local packer = safe_require('packer')
if not packer then
  vim.notify(
    'packer.nvim not found, run this to install:\n\n' ..
    '  git clone --depth 1 https://github.com/wbthomason/packer.nvim \\\n' ..
    '    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/packer/start/packer.nvim\n\n' ..
    'or visit https://github.com/wbthomason/packer.nvim#quickstart\n' ..
    'after installing packer.nvim, run :PackerSync to install plugins'
  )
  return false
end

-- To install/update Packer plugins:
--   :PackerSync
-- All Packer commands:
--   :Packer<tab>

-- Packer plugins specification:
packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -- colorscheme:
  use 'sainnhe/everforest'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  use 'lukas-reineke/indent-blankline.nvim'

  use {
    'akinsho/bufferline.nvim',
    tag = 'v3.*',
    requires = { {'nvim-tree/nvim-web-devicons'} },
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { {'nvim-tree/nvim-web-devicons'} },
  }

  use 'tpope/vim-commentary'

  use 'mattn/emmet-vim'

  use {
    'nvim-tree/nvim-tree.lua',
    requires = { {'nvim-tree/nvim-web-devicons'} },
  }

  use 'mbbill/undotree'

  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use 'tpope/vim-fugitive'
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},         -- Required
      {'hrsh7th/cmp-nvim-lsp'},     -- Required
      {'hrsh7th/cmp-buffer'},       -- Optional
      {'hrsh7th/cmp-path'},         -- Optional
      {'saadparwaiz1/cmp_luasnip'}, -- Optional
      {'hrsh7th/cmp-nvim-lua'},     -- Optional

      -- Snippets
      {'L3MON4D3/LuaSnip'},             -- Required
      {'rafamadriz/friendly-snippets'}, -- Optional
    }
  }

  use 'rmagatti/auto-session'
end)

vim.g.disable_devicons = vim.env.NERD_FONT == nil
require('colors')

require('treesitter-config')
require('bufferline-config')
require('lualine-config')
require('nvim-tree-config')
require('telescope-config')
require('lsp-zero-config')

require('plugins-config')
require('plugins-keymaps')
