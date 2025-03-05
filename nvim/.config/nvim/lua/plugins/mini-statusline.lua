return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- Lua
		require("lualine").setup({
			options = {
				-- ... your lualine config
				theme = "auto",
				-- ... your lualine config
			},
		})
	end,
}

-- return {
-- 	"echasnovski/mini.nvim",
-- 	version = "*",
-- 	config = function()
-- 		require("mini.statusline").setup()
-- 	end,
-- }
