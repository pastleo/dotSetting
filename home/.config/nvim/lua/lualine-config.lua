local lualine = safe_require('lualine')
if lualine == false then return end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = 'everforest',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_b = {
      {
        'diagnostics',
        symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
      }
    }
  }
})
