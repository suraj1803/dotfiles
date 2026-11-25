-- ==========================================================================
-- INPUT, TOUCHPAD, CURSOR & GESTURES
-- ==========================================================================

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		repeat_delay = 250,
		repeat_rate = 35,
		follow_mouse = 1,
		sensitivity = 0,

		touchpad = {
			natural_scroll = true,
			tap_to_click = true,
			disable_while_typing = true,
			clickfinger_behavior = true,
		},
	},

	cursor = {
		sync_gsettings_theme = true,
		hide_on_key_press = false,
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})
