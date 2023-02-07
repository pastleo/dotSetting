local bufferline = safe_require('bufferline')
if bufferline == false then return end

bufferline.setup {
  options = {
    mode = "tabs",
    indicator = {
      style = 'underline'
    },
    buffer_close_icon = 'x',
    show_close_icon = false,
    modified_icon = '~',
    left_trunc_marker = '',
    right_trunc_marker = '',
    show_buffer_icons = false,
    separator_style = { '', '' },
    always_show_bufferline = false
  },
}
