require('set-config')

if not require('packages') then return end

-- ## Requirements
-- * `rg`: faster searcher like `ag`
--   https://github.com/BurntSushi/ripgrep

require('treesitter-config')
require('telescope-config')
require('bufferline-config')
require('undotree-config')
require('vim-gitgutter-config')
require('lsp-zero-config')

require('keymaps')
require('colors')

-- TODO: checkout nvim packages
-- * https://github.com/ThePrimeagen/init.lua
-- * https://github.com/VonHeikemen/lsp-zero.nvim
--   * need to config keymap for it
-- * https://github.com/nvim-lualine/lualine.nvim
-- * https://github.com/nvim-tree/nvim-tree.lua
--   * https://github.com/elihunter173/dirbuf.nvim
--
-- TODO: migrate vimrc to here

