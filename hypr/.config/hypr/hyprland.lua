-- ==========================================================================
-- HYPRLAND CONFIGURATION — Obsidian & Starlight Modular Entrypoint
-- ==========================================================================
-- Modules live in ~/.config/hypr/modules/
--   palette.lua    : Shared color tokens & preferred apps
--   monitors.lua   : Display scaling, cursor env & XWayland
--   autostart.lua  : Session daemons (waybar, hyprpaper, dunst, polkit)
--   theme.lua      : Gaps, squircle corners, borders, 3-pass glass blur & layouts
--   animations.lua : 120Hz spring & directional workspace curves
--   input.lua      : Keyboard, touchpad & 3-finger gestures
--   binds.lua      : Keybindings & hardware media controls
--   rules.lua      : Smart popup window rules & layer blur rules
-- ==========================================================================

require("modules.monitors")
require("modules.autostart")
require("modules.theme")
require("modules.animations")
require("modules.input")
require("modules.binds")
require("modules.rules")
