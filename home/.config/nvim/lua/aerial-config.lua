local aerial = safe_require('aerial')
if aerial ~= false then
  aerial.setup {
    layout = {
      default_direction = "float",
    },
    float = {
      relative = "editor"
    },
    attach_mode = "global",
    close_on_select = true,
    close_automatic_events = {
      "unfocus", "switch_buffer"
    },
    keymaps = {
      ["k"] = "actions.prev",
      ["j"] = "actions.next",
    }
  }
end
