-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Load Omarchy defaults, then machine-local configuration.
require("default.hypr.omarchy")
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Vim/tmux-style workspace navigation, with J cycling window focus.
hl.unbind("SUPER + H")
hl.unbind("SUPER + L") -- Was: toggle workspace layout.
hl.unbind("SUPER + J") -- Was: toggle window split.
o.bind("SUPER + H", "Previous workspace", hl.dsp.focus({ workspace = "e-1" }))
o.bind("SUPER + L", "Next workspace", hl.dsp.focus({ workspace = "e+1" }))
o.bind("SUPER + J", "Focus on next window", hl.dsp.window.cycle_next())
o.bind("SUPER + J", "Reveal active window on top", hl.dsp.window.bring_to_top())

-- Let the terminal control background opacity without fading its text.
o.window({ tag = "terminal" }, {
  opacity = "1.0 override 1.0 override 1.0 override",
  no_blur = true,
})

-- Start apps popped out (float & pin), ready to tile with Super+O later.
-- Keep normal browsers and terminals on their existing launch rules. Browser
-- app windows (chrome-... etc.) deliberately do not match these exclusions.
-- Omarchy's dedicated terminal/system app-ids are excluded like its terminal tag.
local tiled_launch_classes = table.concat({
  "(google-)?[cC]hrom(e|ium)",
  "[bB]rave-browser", "[mM]icrosoft-edge", "Vivaldi-stable", "helium",
  "[fF]irefox", "zen", "librewolf",
  "Alacritty", "kitty", "com\\.mitchellh\\.ghostty", "foot",
  "org\\.codeberg\\.dnkl\\.foot", "wezterm", "org\\.omarchy\\..*", "TUI\\..*",
  "", -- Ignore anonymous XWayland helper windows.
}, "|")
o.window({ class = "negative:^(" .. tiled_launch_classes .. ")$" }, {
  float = true,
  pin = true,
  size = { 1300, 900 },
  center = true,
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

-- Load hyprmoncfg's generated monitor rules last, when present.
do
  local path = os.getenv("HOME") .. "/.config/hypr/hyprmoncfg-monitors.lua"
  local file = io.open(path, "r")
  if file then
    file:close()
    dofile(path)
  end
end
