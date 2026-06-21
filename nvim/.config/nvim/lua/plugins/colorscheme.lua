-- return {
-- 	"folke/tokyonight.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {},
-- 	config = function()
-- 		require("tokyonight").setup({
-- 			style = "night",
-- 			styles = {
-- 				sidebars = "transparent",
-- 				floats = "transparent",
-- 			},
-- 			transparent = true,
-- 		})
--
-- 		vim.cmd([[colorscheme tokyonight]])
-- 	end,
-- }

return {
	"rebelot/kanagawa.nvim",
	config = function()
		-- Default options:
		require("kanagawa").setup({
			compile = false, -- enable compiling the colorscheme
			undercurl = true, -- enable undercurls
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			colors = {
				theme = { all = { ui = { bg_gutter = "none" } } },
			},
			transparent = true, -- do not set background color
			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			theme = "dragon", -- Load "wave" theme
		})

		-- setup must be called before loading
		vim.cmd("colorscheme kanagawa")
	end,
}
