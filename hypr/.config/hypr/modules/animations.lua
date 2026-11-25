-- ==========================================================================
-- ANIMATIONS — Tuned for 120Hz Crisp Spring & Directional Motion
-- ==========================================================================

hl.config({
	animations = {
		enabled = true,
		workspace_wraparound = false,
	},
})

-- Precision curves & springs
hl.curve("obsidianOut", { type = "bezier", points = { { 0.16, 1.0 }, { 0.30, 1.0 } } })
hl.curve("obsidianSmooth", { type = "bezier", points = { { 0.25, 1.0 }, { 0.50, 1.0 } } })
hl.curve("obsidianQuick", { type = "bezier", points = { { 0.15, 0.0 }, { 0.10, 1.0 } } })
hl.curve("linear", { type = "bezier", points = { { 0.0, 0.0 }, { 1.0, 1.0 } } })
hl.curve("snappySpring", { type = "spring", mass = 1.0, stiffness = 310.0, dampening = 28.0 })

-- Window animations
hl.animation({ leaf = "global", enabled = true, speed = 8, bezier = "obsidianOut" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.2, spring = "snappySpring" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3.8, spring = "snappySpring", style = "popin 92%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.4, bezier = "obsidianQuick", style = "popin 94%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4.0, spring = "snappySpring" })

-- Border & fade animations
hl.animation({ leaf = "border", enabled = true, speed = 5.0, bezier = "obsidianOut" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.0, bezier = "obsidianSmooth" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 2.6, bezier = "obsidianSmooth" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2.2, bezier = "obsidianQuick" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 3.2, bezier = "obsidianSmooth" })

-- Layer surfaces (launchers, notifications, overlays)
hl.animation({ leaf = "layers", enabled = true, speed = 3.4, bezier = "obsidianOut" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3.2, bezier = "obsidianOut", style = "popin 95%" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2.0, bezier = "obsidianQuick", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2.4, bezier = "obsidianSmooth" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.8, bezier = "obsidianQuick" })

-- Workspaces & scratchpad HUD transitions
hl.animation({ leaf = "workspaces", enabled = true, speed = 3.8, bezier = "obsidianOut", style = "slidefade 18%" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3.6, bezier = "obsidianOut", style = "slidefadevert -12%" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 6.0, bezier = "obsidianQuick" })
