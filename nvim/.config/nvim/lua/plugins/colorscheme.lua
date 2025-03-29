return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		require("tokyonight").setup({
			-- transparent = true,
			styles = {
				comments = { italic = true },
				keywords = { bold = true },
				functions = { bold = true },
				variables = {},
				-- sidebars = "transparent", -- style for sidebars, see below
				floats = "transparent", -- style for floating windows
			},
		})

		vim.cmd([[colorscheme tokyonight-night]])
	end,
}
