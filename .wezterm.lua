-- Pull in the wezterm API
local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- Base configurations
-- config.default_domain = 'WSL:Ubuntu-24.04'
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false-- Set to false for a simpler look
config.audible_bell = "Disabled"
config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"
config.tab_max_width = 20
config.font = wezterm.font("JetBrainsMonoNerdFont")
config.font_size = 14 -- Set to a smaller size for both terminal and tab bar

-- Tab bar color styling with blur effect
config.colors = {
  tab_bar = {
    background = "#1d2021", -- Gruvbox Dark Hard background

    -- Set the active tab background and foreground colors
    active_tab = {
      bg_color = "#000000", -- Black
      fg_color = "#ebdbb2", -- Gruvbox Light text color (adjust as needed)
    },

    -- Set the inactive tab background and foreground colors
    inactive_tab = {
      bg_color = "#3c3836", -- Darker shade for inactive tabs
      fg_color = "#a89984", -- Gruvbox faded text color
    },
  },
}

-- Keyboard shortcuts
local act = wezterm.action
config.keys = {
    { key = 'c', mods = 'CTRL', action = act.CopyTo 'ClipboardAndPrimarySelection'},
    { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
    { key = 'v', mods = 'CTRL', action = act.PasteFrom 'PrimarySelection' },
    { key = 't', mods = 'CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = "h", mods = "ALT", action = act.ActivateTabRelative(-1) },
    { key = "l", mods = "ALT", action = act.ActivateTabRelative(1) },
}

-- Window padding adjustments
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

-- config.color_scheme = 'Gruvbox Dark (Gogh)'
config.color_scheme = 'Gruvbox dark, hard (base16)'

return config

