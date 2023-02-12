if os.getenv("TERM_RGB") == 'true' then -- from ~/.shrc.once
  vim.opt.termguicolors = true
end

vim.opt.background = 'dark'

vim.g.everforest_enable_italic = 1
vim.g.everforest_better_performance = 1
vim.g.everforest_transparent_background = 1

vim.g.everforest_colors_override = {
  fg = { '#abd4bb', 'NONE' },
  aqua = { '#83c0c0', '108' },
  blue = { '#8393c0', '109' },
  grey0 = { '#a2aaa1',  '243' },
  grey1 = { '#aeb7b0',  '245' },
  grey2 = { '#bbc4bd',  '247' },
  bg2 = { '#374542',  '247' },
  bg3 = { '#809199',  '247' },
  bg_visual = { '#4f5b58',  '240' },
  bg_blue = { '#ffffff', '17' }
}

vim.cmd[[
  silent! colorscheme everforest
]]

-- if vim.g.colors_name =~ 'everforest' then
--   vim.notify "no termguicolors support or color scheme not installed"
-- end
