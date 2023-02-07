vim.opt.termguicolors = true
vim.opt.background = 'dark'

vim.g.everforest_background = 'soft'
vim.g.everforest_enable_italic = 1
vim.g.everforest_better_performance = 1
vim.g.everforest_transparent_background = 1

vim.cmd[[
  silent! colorscheme everforest
]]

-- if vim.g.colors_name =~ 'everforest' then
--   vim.notify "no termguicolors support or color scheme not installed"
-- end
