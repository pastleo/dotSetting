local bufferline = safe_require('bufferline')
if bufferline == false then return end

bufferline.setup {
  options = {
    mode = "tabs",
    indicator = {
      style = 'underline'
    },
    always_show_bufferline = false,
    separator_style = { '', '' },
    show_close_icon = false,

    -- when no NERD_FONT
    -- buffer_close_icon = 'x',
    -- modified_icon = '!',
    -- left_trunc_marker = '',
    -- right_trunc_marker = '',
    -- show_buffer_icons = false,
  },
}
