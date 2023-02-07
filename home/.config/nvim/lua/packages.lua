-- Define safe_require() globally to get Packer plugins,
--   while preventing error when Packer plugins not installed
-- Require this script before all Packer plugins dependent lua scripts:
--   if not require('plugins') then return end
function safe_require(module_name)
  local status_ok, module = pcall(require, module_name)
  if not status_ok then return false end
  return module
end

-- Packer.nvim for nvim plugin management:
--   https://github.com/wbthomason/packer.nvim
local packer = safe_require('packer')
if not packer then
  vim.notify(
    'packer.nvim not found, run this to install:\n\n' ..
    '  git clone --depth 1 https://github.com/wbthomason/packer.nvim \\\n' ..
    '    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/packer/start/packer.nvim\n\n' ..
    'or visit https://github.com/wbthomason/packer.nvim#quickstart'
  )
  return false
end

-- To install/update Packer plugins:
--   :PackerSync
-- All Packer commands:
--   :Packer<tab>

-- Packer plugins specification:
return packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  -- use 'sainnhe/sonokai'
  use 'sainnhe/everforest'
  use 'jacoborus/tender.vim'
  use { "bluz71/vim-nightfly-colors", as = "nightfly" }

  -- use 'nvim-tree/nvim-web-devicons'

  use {'akinsho/bufferline.nvim', tag = "v3.*"}

  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { "nvim-telescope/telescope-file-browser.nvim" }

  use 'mbbill/undotree'
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'

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
end)
