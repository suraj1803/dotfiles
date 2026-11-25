-- ==========================================================================
-- SESSION AUTOSTART
-- ==========================================================================

hl.on("hyprland.start", function()
	-- Core session surfaces
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("waybar")
	hl.exec_cmd("dunst")
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")

	-- Idle management (auto-dim, lock, dpms, suspend)
	hl.exec_cmd("command -v hypridle >/dev/null 2>&1 && hypridle")

	-- Persistent Wayland clipboard history (text + images)
	hl.exec_cmd("command -v cliphist >/dev/null 2>&1 && wl-paste --type text --watch cliphist store")
	hl.exec_cmd("command -v cliphist >/dev/null 2>&1 && wl-paste --type image --watch cliphist store")

	-- On-screen volume / brightness / capslock HUD
	hl.exec_cmd("command -v swayosd-server >/dev/null 2>&1 && swayosd-server")

	-- Auto-mount removable USB drives
	hl.exec_cmd("command -v udiskie >/dev/null 2>&1 && udiskie --smart-tray")
end)
