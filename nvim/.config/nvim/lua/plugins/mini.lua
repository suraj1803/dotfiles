return {
	"nvim-mini/mini.nvim",
	version = "*",
	config = function()
		require("mini.pairs").setup({})
		require("mini.statusline").setup({})
	end,
}
