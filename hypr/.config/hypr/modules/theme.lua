-- ==========================================================================
-- LOOK & FEEL — Obsidian & Starlight Theme, Glass Blur & Layouts
-- ==========================================================================

local P = require("modules.palette")

hl.config({
	general = {
		-- 8px left/right/bottom gap aligns tiled windows with Waybar's outer capsules; 4px top matches Waybar's 4px top margin
		gaps_in = 4,
		gaps_out = { top = 4, right = 8, bottom = 8, left = 8 },
		border_size = 1,

		col = {
			active_border = P.colors.active_border,
			inactive_border = P.colors.inactive_border,
		},

		resize_on_border = true,
		extend_border_grab_area = 15,
		hover_icon_on_border = true,
		allow_tearing = false,
		layout = "dwindle",

		snap = {
			enabled = true,
			window_gap = 10,
			monitor_gap = 10,
			respect_gaps = true,
		},
	},

	decoration = {
		-- Continuous superellipse (squircle) window corners
		rounding = 10,
		rounding_power = 3.5,

		active_opacity = 1.0,
		inactive_opacity = 1.0,
		fullscreen_opacity = 1.0,

		-- Subtle depth emphasis on focused window & scratchpad
		dim_inactive = true,
		dim_strength = 0.06,
		dim_special = 0.38,

		shadow = {
			enabled = true,
			range = 22,
			render_power = 3,
			offset = { 0, 4 },
			color = P.colors.shadow_active,
			color_inactive = P.colors.shadow_inactive,
		},

		glow = {
			enabled = true,
			range = 10,
			render_power = 3,
			color = P.colors.glow_active,
			color_inactive = P.colors.glow_inactive,
		},

		-- Creamy 3-pass smoked obsidian glass blur
		blur = {
			enabled = true,
			size = 6,
			passes = 3,
			new_optimizations = true,
			ignore_opacity = true,
			xray = false,
			noise = 0.015,
			contrast = 1.05,
			brightness = 0.84,
			vibrancy = 0.20,
			vibrancy_darkness = 0.25,
			popups = true,
			popups_ignorealpha = 0.2,
			special = true,
		},
	},

	group = {
		col = {
			border_active = P.colors.active_border,
			border_inactive = P.colors.inactive_border,
		},
		groupbar = {
			font_family = "JetBrainsMono Nerd Font Propo",
			font_size = 11,
			height = 22,
			rounding = 6,
			rounding_power = 3.0,
			gradients = true,
			text_color = P.colors.text_primary,
			text_color_inactive = P.colors.text_muted,
			col = {
				active = P.colors.group_active,
				inactive = P.colors.group_inactive,
			},
		},
	},

	dwindle = {
		preserve_split = true,
		smart_split = false,
		smart_resizing = true,
	},

	master = {
		new_status = "master",
		mfact = 0.55,
	},

	scrolling = {
		fullscreen_on_one_column = true,
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		force_default_wallpaper = 0,
		background_color = P.colors.void_hex,
		font_family = "JetBrainsMono Nerd Font Propo",
		vrr = 1,
		animate_manual_resizes = false,
		animate_mouse_windowdragging = false,
		enable_swallow = true,
		swallow_regex = "^(ghostty|kitty|Alacritty)$",
		focus_on_activate = true,
	},
})
