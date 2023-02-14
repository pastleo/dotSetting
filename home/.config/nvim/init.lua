-- PastLeo's neovim init.lua
-- =========================
-- taking ideas from https://github.com/ThePrimeagen/init.lua, thanks

-- ## Requirements
-- * `rg`: faster searcher like `ag`
--   https://github.com/BurntSushi/ripgrep

-- ## TODO: checkout nvim plugins & configs
-- * https://github.com/nvim-tree/nvim-tree.lua
--   * https://github.com/elihunter173/dirbuf.nvim
--   * floating like in telescope
--   * replace telescope-file-browser

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

  use {'akinsho/bufferline.nvim', tag = 'v3.*'}
  use 'nvim-lualine/lualine.nvim'

  use 'tpope/vim-commentary'

  use 'mattn/emmet-vim'

  use {
    'mbbill/undotree',
    config = function()
      vim.g.undotree_SetFocusWhenToggle = 1
    end
  }

  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use 'tpope/vim-fugitive'
  use {
    'airblade/vim-gitgutter',
    config = function()
      vim.g.gitgutter_map_keys = 0
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

require('colors')

require('treesitter-config')
require('bufferline-config')
require('lualine-config')
require('telescope-config')
require('lsp-zero-config')
require('auto-session-config')

require('plugins-keymaps')
