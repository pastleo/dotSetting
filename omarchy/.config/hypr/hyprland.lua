-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Load Omarchy defaults, then machine-local configuration.
-- Reset saved layouts only on a new login, before Omarchy restores them.
-- The per-session marker keeps Super+Alt+L choices through config reloads.
do
  local script = os.getenv("HOME") .. "/.local/bin/omarchy-reset-session-layouts.py"
  local pipe = assert(io.popen("python3 " .. string.format("%q", script) .. " && echo ready", "r"))
  local result = pipe:read("*a")
  pipe:close()
  if result ~= "ready\n" then error("Could not reset workspace layouts for this session") end
end
require("default.hypr.omarchy")
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Vim/tmux-style navigation: H/L stay on this monitor, J cycles windows,
-- and K cycles monitors. Super+Alt+L still cycles workspace layouts.
hl.unbind("SUPER + H")
hl.unbind("SUPER + L") -- Was: toggle workspace layout.
hl.unbind("SUPER + J") -- Was: toggle window split.
o.bind("SUPER + H", "Previous workspace on this monitor", hl.dsp.focus({ workspace = "m-1" }))
o.bind("SUPER + L", "Next workspace on this monitor", hl.dsp.focus({ workspace = "m+1" }))
o.bind("SUPER + J", "Focus on next window", hl.dsp.window.cycle_next())
o.bind("SUPER + J", "Reveal active window on top", hl.dsp.window.bring_to_top())
o.rebind("SUPER + K", "Focus on next monitor", hl.dsp.focus({ monitor = "+1" })) -- Was: Keybindings menu.

-- Let the terminal control background opacity without fading its text.
o.window({ tag = "terminal" }, {
  opacity = "1.0 override 1.0 override 1.0 override",
  no_blur = true,
})

-- Follow the actual pin state, so Super+O also adds/removes this hint on any app.
-- Inherit the theme's border colors; the thicker border distinguishes pop-outs.
o.window({ float = true, pin = true }, {
  decorate = true,
  border_size = 3,
  rounding = 8,
})

-- Restore saved workspace layouts and toggle config flags after overrides.
require("default.hypr.toggles")

-- Added by hyprmoncfg: its generated monitor rules load last, so nothing before this can override the applied layout.
do local path = os.getenv("HOME") .. "/.config/hypr/hyprmoncfg-monitors.lua"; local file = io.open(path, "r"); if file then file:close(); dofile(path) end end
