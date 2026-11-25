-- ==========================================================================
-- OBSIDIAN & STARLIGHT — Shared Palette & Preferred Applications
-- ==========================================================================

local M = {}

M.apps = {
	terminal = "ghostty",
	file_manager = "dolphin",
	menu = "hyprlauncher",
	browser = "google-chrome-stable",
	lock = "command -v hyprlock >/dev/null 2>&1 && hyprlock || loginctl lock-session",
}

M.colors = {
	void_hex = "0x040507",
	active_border = {
		colors = { "rgba(98b2c9ee)", "rgba(313b4dee)" },
		angle = 45,
	},
	inactive_border = "rgba(1c212ccc)",
	glow_active = "rgba(98b2c924)",
	glow_inactive = "rgba(00000000)",
	shadow_active = "rgba(00000099)",
	shadow_inactive = "rgba(00000044)",
	group_active = "rgba(1a202cee)",
	group_inactive = "rgba(0b0d12cc)",
	text_primary = "0xffeef2f7",
	text_muted = "0xff7f8a9c",
}

return M
