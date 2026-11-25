-- ==========================================================================
-- WINDOW & LAYER RULES
-- ==========================================================================

-- Ignore client-initiated maximize requests so tiling remains clean
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Fix phantom XWayland drag surfaces
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- Hyprland-run floating launcher
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})

-- Floating system control applets (launched from Waybar)
hl.window_rule({
	name = "float-control-popups",
	match = {
		class = "^(org\\.pulseaudio\\.pavucontrol|pavucontrol|nm-connection-editor|blueman-manager|hyprpolkitagent)$",
	},
	float = true,
	center = true,
	size = "760 500",
})

-- File picker & portal dialogs
hl.window_rule({
	name = "float-file-dialogs",
	match = {
		title = "^(Open File|Select a File|Choose wallpaper|Open Folder|Save As|Library|File Upload)(.*)$",
	},
	float = true,
	center = true,
	size = "860 560",
})

hl.window_rule({
	name = "float-xdg-portal",
	match = {
		class = "^(xdg-desktop-portal-gtk|xdg-desktop-portal-kde)$",
	},
	float = true,
	center = true,
})

-- Picture-in-Picture floating corner video
hl.window_rule({
	name = "pip-video",
	match = {
		title = "^(Picture-in-Picture|Picture in picture)$",
	},
	float = true,
	pin = true,
	no_dim = true,
	size = "420 236",
	move = "monitor_w-436 monitor_h-252",
})

-- Layer blur & alpha rules
hl.layer_rule({
	name = "waybar-blur",
	match = { namespace = "waybar" },
	blur = true,
	ignore_alpha = 0.3,
})

hl.layer_rule({
	name = "notifications-blur",
	match = { namespace = "notifications" },
	blur = true,
	ignore_alpha = 0.2,
})

hl.layer_rule({
	name = "hyprlauncher-blur",
	match = { namespace = "hyprlauncher" },
	blur = true,
	ignore_alpha = 0.2,
})

hl.layer_rule({
	name = "vicinae-blur",
	match = { namespace = "vicinae" },
	blur = false,
	ignore_alpha = 0,
})
