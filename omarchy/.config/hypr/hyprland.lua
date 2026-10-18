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

-- Let the terminal control background opacity without fading its text.
o.window({ tag = "terminal" }, {
  opacity = "1.0 override 1.0 override 1.0 override",
  no_blur = true,
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
