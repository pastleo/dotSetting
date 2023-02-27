local lualine = safe_require('lualine')
if lualine == false then return end

local everforest_theme = require('lualine.themes.everforest')
local color_palette = require('colors')

local filenameComp = {
  'filename',
  path = 1, -- show relative path
}

everforest_theme.normal.c.gui = 'underline'
everforest_theme.insert.c.gui = 'underline'
everforest_theme.visual.c.gui = 'underline'
everforest_theme.replace.c.gui = 'underline'

if color_palette ~= nil then
  everforest_theme.insert.c.fg = color_palette.fg[1]
  everforest_theme.normal.c.fg = color_palette.fg[1]
  everforest_theme.visual.c.fg = color_palette.fg[1]
  everforest_theme.replace.c.fg = color_palette.fg[1]
  everforest_theme.inactive.y = { bg = color_palette.bg3[1] }
end

lualine.setup({
  options = {
    icons_enabled = not vim.g.disable_devicons,
    theme = everforest_theme,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = { 'mode', 'location' },
    lualine_b = { 'diagnostics', 'lsp_progress' },
    lualine_c = { filenameComp },
    lualine_x = {},
    lualine_y = { 'filetype', 'encoding', 'fileformat', 'diff' },
    lualine_z = { 'branch' },
  },
  inactive_sections = {
    lualine_c = { filenameComp },
    lualine_x = { 'diff' },
    lualine_y = { 'diagnostics' },
  },
})
