local aerial = safe_require('aerial')
if aerial ~= false then
  aerial.setup {
    layout = {
      default_direction = "right",
      placement = "edge",
    },
    attach_mode = "global",
    keymaps = {
      ["k"] = "actions.prev",
      ["j"] = "actions.next",
    }
  }
end
