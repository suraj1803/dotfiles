-- return {
-- 	"folke/tokyonight.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {},
-- 	config = function()
-- 		require("tokyonight").setup({
-- 			transparent = true,
-- 			styles = {
-- 				comments = { italic = true },
-- 				keywords = { bold = true },
-- 				functions = { bold = true },
-- 				variables = {},
-- 				sidebars = "transparent", -- style for sidebars, see below
-- 				floats = "transparent", -- style for floating windows
-- 			},
-- 		})
--
-- 		vim.cmd([[colorscheme tokyonight-night]])
-- 	end,
-- }
-- lua/plugins/rose-pine.lua
return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			variant = "main", -- auto, main, moon, or dawn
			dark_variant = "main", -- main, moon, or dawn
			dim_inactive_windows = false,
			extend_background_behind_borders = true,

			enable = {
				terminal = true,
				legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
				migrations = true, -- Handle deprecated options automatically
			},

			styles = {
				bold = true,
				italic = true,
				transparency = true,
			},

			groups = {
				border = "muted",
				link = "iris",
				panel = "surface",

				error = "love",
				hint = "iris",
				info = "foam",
				note = "pine",
				todo = "rose",
				warn = "gold",

				git_add = "foam",
				git_change = "rose",
				git_delete = "love",
				git_dirty = "rose",
				git_ignore = "muted",
				git_merge = "iris",
				git_rename = "pine",
				git_stage = "iris",
				git_text = "rose",
				git_untracked = "subtle",

				h1 = "iris",
				h2 = "foam",
				h3 = "rose",
				h4 = "gold",
				h5 = "pine",
				h6 = "foam",
			},
		})

		vim.cmd("colorscheme rose-pine")
	end,
}
