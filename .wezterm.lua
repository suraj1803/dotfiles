-- Pull in the wezterm API
local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- Base configurations
config.enable_tab_bar = false
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.audible_bell = "Disabled"
config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"
config.tab_max_width = 5
config.font = wezterm.font("CaskaydiaMono Nerd Font")
config.font_size = 15
config.front_end = "OpenGL"

-- Keyboard shortcuts
local act = wezterm.action
config.keys = {
{ key = 'c', mods = 'CTRL', action = act.CopyTo 'ClipboardAndPrimarySelection'},
{ key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
{ key = 'v', mods = 'CTRL', action = act.PasteFrom 'PrimarySelection' },
{ key = 't', mods = 'CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
{ key = "h", mods = "ALT", action = act.ActivateTabRelative(-1) },
{ key = "l", mods = "ALT", action = act.ActivateTabRelative(1) },
{
key = 'f',
mods = 'SUPER',
action = wezterm.action.ToggleFullScreen,
},
}

-- Window padding adjustments
config.window_padding = {
left = 0,
right = 0,
top = 0,
bottom = 0,
}

config.window_frame = {
font_size = 10,
inactive_titlebar_bg = '#353535',
active_titlebar_bg = '#1D2021',
inactive_titlebar_fg = '#cccccc',
active_titlebar_fg = '#ffffff',
}

config.color_scheme = 'Gruvbox dark, hard (base16)'

return config

