return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "tabs",
			highlights = {
				buffer_selected = {
					underline = true,
					undercurl = false,
					italic = false,
				},
			},
		},
	},
}
