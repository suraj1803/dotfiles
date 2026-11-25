-- ==========================================================================
-- MONITORS, SCALING & ENVIRONMENT
-- ==========================================================================

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "1.25",
})

-- Cursor & toolkit environment variables
hl.env("XCURSOR_THEME", "capitaine-cursors")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Crisp XWayland rendering on 1.25x fractional scale
hl.config({
	xwayland = {
		enabled = true,
		force_zero_scaling = true,
	},
	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
	},
})
