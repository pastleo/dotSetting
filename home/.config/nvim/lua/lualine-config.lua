local lualine = safe_require('lualine')
if lualine == false then return end

local filenameComp = {
  'filename',
  path = 1, -- show relative path
  symbols = {
    modified = '(!)',
    readonly = '(RO)',
  }
}

lualine.setup({
  options = {
    icons_enabled = true,
    theme = 'everforest',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  -- sections = {
  --   lualine_b = {
  --     'branch', 'diff',
  --     {
  --       'diagnostics',
  --       symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
  --     }
  --   },
  --   lualine_c = {
  --     filenameComp
  --   },
  --   lualine_x = {
  --     'encoding',
  --     { 'fileformat', symbols = { unix = '', dos = 'dos', mac = '' } },
  --     'filetype'
  --   },
  -- },
  -- inactive_sections = {
  --   lualine_a = {},
  --   lualine_b = {},
  --   lualine_c = {
  --     filenameComp
  --   },
  --   lualine_x = {'location'},
  --   lualine_y = {},
  --   lualine_z = {},
  -- },
})
