-- ==========================================================================
-- KEYBINDINGS & MULTIMEDIA CONTROLS
-- ==========================================================================

local P = require("modules.palette")
local mainMod = "SUPER"

-- Core launchers & session
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(P.apps.terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(P.apps.file_manager))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(P.apps.menu))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd(P.apps.lock))
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(
	mainMod .. " + SHIFT + R",
	hl.dsp.exec_cmd("pkill -USR2 -x waybar || waybar &")
)
hl.bind(
	mainMod .. " + SHIFT + F",
	hl.dsp.exec_cmd("pkill -USR1 -x waybar || waybar &")
)

-- Window state & layout controls
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + C", hl.dsp.window.center())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen_state({ action = "toggle", internal = 2, client = 0 }))

-- Tabbed layout (i3-style workspace tabbing via Hyprland groups + groupbar)
hl.bind(mainMod .. " + W", function()
	local active = hl.get_active_window()
	local ws = hl.get_active_workspace()
	if not active or not ws then
		return
	end

	local tiled = {}
	for _, w in ipairs(hl.get_workspace_windows(ws)) do
		if w.mapped and not w.floating then
			table.insert(tiled, w)
		end
	end

	-- If already grouped, ungroup all windows back into tiled splits
	if active.group then
		hl.dispatch(hl.dsp.group.toggle())
		return
	end

	-- Create a group on the active window and merge all other tiled windows on this workspace into tabs
	hl.dispatch(hl.dsp.group.toggle())
	active = hl.get_active_window()
	if active and active.group then
		for _, w in ipairs(tiled) do
			if w.address ~= active.address and not w.group then
				active.group:add(w)
			end
		end
	end
end)

-- Single-window group toggle, lock, and moving windows into/out of groups
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.group.lock_active())
hl.bind(mainMod .. " + ALT + h", hl.dsp.group.move_window({ direction = "left" }))
hl.bind(mainMod .. " + ALT + l", hl.dsp.group.move_window({ direction = "right" }))
hl.bind(mainMod .. " + ALT + k", hl.dsp.group.move_window({ direction = "up" }))
hl.bind(mainMod .. " + ALT + j", hl.dsp.group.move_window({ direction = "down" }))

-- Directional focus & tabbed group switching (MOD + h/l & arrows cycle tabs first inside a group)
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Directional window swap (SUPER + CTRL + Vim/Arrows)
hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + k", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + j", hl.dsp.window.swap({ direction = "down" }))

-- Workspaces [1..10]
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scratchpad, clipboard, color picker & screenshots
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + ALT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(
	mainMod .. " + CTRL + S",
	hl.dsp.exec_cmd('grim -g "$(slurp)" - | satty --filename - --copy-command wl-copy')
)
hl.bind(
	mainMod .. " + SHIFT + V",
	hl.dsp.exec_cmd([[pkill -x fuzzel || sh -c 'sel=$(cliphist list | fuzzel --dmenu) && [ -n "$sel" ] && printf "%s" "$sel" | cliphist decode | wl-copy']])
)
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"))

-- Mouse workspace scroll & window drag/resize
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Audio & brightness hardware keys (uses SwayOSD HUD when installed, graceful fallback otherwise)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("command -v swayosd-client >/dev/null 2>&1 && swayosd-client --output-volume 5 --max-volume 100 || wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("command -v swayosd-client >/dev/null 2>&1 && swayosd-client --output-volume -5 || wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("command -v swayosd-client >/dev/null 2>&1 && swayosd-client --output-volume mute-toggle || wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("command -v swayosd-client >/dev/null 2>&1 && swayosd-client --input-volume mute-toggle || wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("command -v swayosd-client >/dev/null 2>&1 && swayosd-client --brightness +5 || brightnessctl -e4 -n2 set 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("command -v swayosd-client >/dev/null 2>&1 && swayosd-client --brightness -5 || brightnessctl -e4 -n2 set 5%-"),
	{ locked = true, repeating = true }
)

-- Media playback keys
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
