if os.getenv("TERM_RGB") == 'true' then -- from ~/.shrc.once
  vim.opt.termguicolors = true
end

vim.opt.background = 'dark'

vim.g.everforest_enable_italic = 1
vim.g.everforest_better_performance = 1
vim.g.everforest_transparent_background = 1

vim.g.everforest_colors_override = {
  fg = { '#afd4ab', 'NONE' },
  blue = { '#8393c0', '109' },
  grey0 = { '#a2aaa1', '243' },
  grey1 = { '#aeb7b0', '245' },
  grey2 = { '#bbc4bd', '247' },
  bg1 = { '#373e3a', '236' },
  bg2 = { '#374542', '247' },
  bg3 = { '#56646c', '247' },
  bg_visual = { '#4f5b58', '240' },
  bg_blue = { '#ffffff', '17' }
}

vim.cmd[[
  function! s:everforest_custom() abort
    let g:everforest_palette = everforest#get_palette('medium', g:everforest_colors_override)
    call everforest#highlight('TabLine', g:everforest_palette.grey2, g:everforest_palette.bg1)
    call everforest#highlight('TabLineSel', g:everforest_palette.fg, g:everforest_palette.bg1)
  endfunction
  augroup EverforestCustom
    autocmd!
    autocmd ColorScheme everforest call s:everforest_custom()
  augroup END

  silent! colorscheme everforest
]]

if vim.g.colors_name == 'everforest' and vim.g.everforest_palette ~= nil then
  return vim.g.everforest_palette
else
  return nil -- everforest colorscheme not found
end
