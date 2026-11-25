-- ==========================================================================
-- SESSION AUTOSTART
-- ==========================================================================

hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("waybar")
	hl.exec_cmd("dunst")
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
end)
