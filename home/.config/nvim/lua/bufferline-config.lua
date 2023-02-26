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
  highlights = {
    fill = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    background = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    tab = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    tab_selected = {
      bg = { highlight = "TabLineSel", attribute = "bg" },
    },
    tab_close = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    close_button = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    close_button_visible = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    close_button_selected = {
      bg = { highlight = "TabLineSel", attribute = "bg" },
    },
    buffer_visible = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    buffer_selected = {
      bg = { highlight = "TabLineSel", attribute = "bg" },
    },
    numbers = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    numbers_visible = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    numbers_selected = {
      bg = { highlight = "TabLineSel", attribute = "bg" },
    },
    diagnostic = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    diagnostic_visible = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    diagnostic_selected = {
      bg = { highlight = "TabLineSel", attribute = "bg" },
    },
    hint = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    hint_visible = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    hint_selected = {
      bg = { highlight = "TabLineSel", attribute = "bg" },
    },
    hint_diagnostic = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    hint_diagnostic_visible = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    hint_diagnostic_selected = {
      bg = { highlight = "TabLineSel", attribute = "bg" },
    },
    info = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    info_visible = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    info_selected = {
      bg = { highlight = "TabLineSel", attribute = "bg" },
    },
    info_diagnostic = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    info_diagnostic_visible = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    info_diagnostic_selected = {
      bg = { highlight = "TabLineSel", attribute = "bg" },
    },
    warning = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    warning_visible = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    warning_selected = {
      bg = { highlight = "TabLineSel", attribute = "bg" },
    },
    warning_diagnostic = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    warning_diagnostic_visible = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    warning_diagnostic_selected = {
      bg = { highlight = "TabLineSel", attribute = "bg" },
    },
    error = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    error_visible = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    error_selected = {
      bg = { highlight = "TabLineSel", attribute = "bg" },
    },
    error_diagnostic = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    error_diagnostic_visible = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    error_diagnostic_selected = {
      bg = { highlight = "TabLineSel", attribute = "bg" },
    },
    modified = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    modified_visible = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    modified_selected = {
      bg = { highlight = "TabLineSel", attribute = "bg" },
    },
    duplicate_selected = {
      bg = { highlight = "TabLineSel", attribute = "bg" },
    },
    duplicate_visible = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    duplicate = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    separator_selected = {
      bg = { highlight = "TabLineSel", attribute = "bg" },
    },
    separator_visible = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    separator = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    indicator_selected = {
      bg = { highlight = "TabLineSel", attribute = "bg" },
    },
    pick_selected = {
      bg = { highlight = "TabLineSel", attribute = "bg" },
    },
    pick_visible = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    pick = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
    offset_separator = {
      bg = { highlight = "TabLine", attribute = "bg" },
    },
  },
}
