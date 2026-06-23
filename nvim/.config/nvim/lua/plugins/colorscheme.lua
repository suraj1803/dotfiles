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

-- return {
-- 	"bluz71/vim-moonfly-colors",
-- 	name = "moonfly",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		-- Lua initialization file
-- 		vim.g.moonflyTransparent = true
-- 		-- Lua initialization file
-- 		vim.cmd([[colorscheme moonfly]])
-- 	end,
-- }

-- Using lazy.nvim
return {
	"deparr/tairiki.nvim",
	lazy = false,
	priority = 1000, -- recommended if you use tairiki as your default theme
	config = function()
		require("tairiki").setup({
			palette = "dark", -- main palette, available options: dark, light, dimmed, tomorrow, light_legacy
			default_dark = "dark",
			default_light = "light",
			transparent = true, -- don't set background colors
			terminal = false, -- override nvim terminal colors
			end_of_buffer = false, -- show end of buffer filler lines (tildes)
			visual_bold = false, -- bolden visual selections
			cmp_itemkind_reverse = false, -- reverse fg/bg on nvim-cmp item kinds

			diagnostics = {
				darker = false, -- darken diagnostic virtual text
				background = false, -- add background to diagnostic virtual text
				undercurl = true, -- use undercurls for inline diagnostics
			},

			-- style for different syntactic tokens
			-- see :help nvim_set_hl() for available keys
			code_style = {
				comments = { italic = true },
				conditionals = {},
				keywords = {},
				functions = {},
				strings = {},
				variables = {},
				parameters = {},
				types = {},
			},

			-- lualine theme config
			lualine = {
				transparent = true, -- remove background from center section
			},

			-- which plugins to enable
			plugins = {
				all = false, -- enable all supported plugins
				none = false, -- ONLY set groups listed in :help highlight-groups (see lua/tairiki/groups/neovim.lua). Manually enabled plugins will also be ignored
				auto = false, -- auto detect installed plugins, currently lazy.nvim only

				-- or enable/disable plugins manually
				-- see lua/tairiki/groups/init.lua for the full list of available plugins
				-- either the key or value from the M.plugins table can be used as the key here
				--
				-- setting a specific plugin manually overrides `all` and `auto`
				treesitter = true,
				semantic_tokens = true,
			},

			-- optional function to modify or add colors to the palette
			-- palette definitions are in lua/tairiki/palette
			colors = function(colors, opts) end,

			-- optional function to override highlight groups
			highlights = function(groups, colors, opts) end,
		})
		vim.cmd([[colorscheme tairiki]])
	end,
}
