-- return {
-- 	"nvim-lualine/lualine.nvim",
-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
-- }

return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		require("mini.statusline").setup()
	end,
}
