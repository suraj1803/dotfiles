-- return {
-- 	"sainnhe/gruvbox-material",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		-- vim.g.gruvbox_material_enable_italic = true
-- 		vim.g.gruvbox_material_enable_bold = true
-- 		vim.g.gruvbox_material_background = "hard"
-- 		vim.g.gruvbox_material_foreground = "original"
-- 		vim.g.gruvbox_material_transparent_background = 1
-- 		vim.cmd.colorscheme("gruvbox-material")
-- 		vim.o.background = "dark" -- or "light" for light mode
-- 	end,
-- }

-- return {
-- 	"navarasu/onedark.nvim",
-- 	config = function()
-- 		-- Lua
-- 		require("onedark").setup({
-- 			-- Main options --
-- 			style = "darker", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
-- 			transparent = true, -- Show/hide background
-- 			term_colors = true, -- Change terminal color as per the selected theme style
-- 			ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
-- 			cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
--
-- 			-- toggle theme style ---
-- 			toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
-- 			toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between
--
-- 			-- Change code style ---
-- 			-- Options are italic, bold, underline, none
-- 			-- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
-- 			code_style = {
-- 				comments = "italic",
-- 				keywords = "none",
-- 				functions = "bold",
-- 				strings = "none",
-- 				variables = "none",
-- 			},
--
-- 			-- Lualine options --
-- 			lualine = {
-- 				transparent = true, -- lualine center bar transparency
-- 			},
--
-- 			-- Custom Highlights --
-- 			colors = {}, -- Override default colors
-- 			highlights = {}, -- Override highlight groups
--
-- 			-- Plugins Config --
-- 			diagnostics = {
-- 				darker = true, -- darker colors for diagnostic
-- 				undercurl = true, -- use undercurl instead of underline for diagnostics
-- 				background = true, -- use background color for virtual text
-- 			},
-- 		})
--
-- 		vim.cmd.colorscheme("onedark")
-- 	end,
-- }

return {
	"marko-cerovac/material.nvim",
	config = function()
		require("material").setup({

			contrast = {
				terminal = false, -- Enable contrast for the built-in terminal
				sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
				floating_windows = false, -- Enable contrast for floating windows
				cursor_line = true, -- Enable darker background for the cursor line
				lsp_virtual_text = false, -- Enable contrasted background for lsp virtual text
				non_current_windows = false, -- Enable contrasted background for non-current windows
				filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
			},

			styles = { -- Give comments style such as bold, italic, underline etc.
				comments = { --[[ italic = true ]]
				},
				strings = { --[[ bold = true ]]
				},
				keywords = { --[[ underline = true ]]
				},
				functions = { --[[ bold = true, undercurl = true ]]
				},
				variables = {},
				operators = {},
				types = {},
			},

			plugins = {},

			disable = {
				colored_cursor = true, -- Disable the colored cursor
				borders = false, -- Disable borders between vertically split windows
				background = true, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
				term_colors = false, -- Prevent the theme from setting terminal colors
				eob_lines = false, -- Hide the end-of-buffer lines
			},

			high_visibility = {
				lighter = false, -- Enable higher contrast text for lighter style
				darker = false, -- Enable higher contrast text for darker style
			},

			lualine_style = "stealth", -- Lualine style ( can be 'stealth' or 'default' )

			async_loading = true, -- Load parts of the theme asynchronously for faster startup (turned on by default)

			custom_colors = nil, -- If you want to override the default colors, set this to a function

			custom_highlights = {
				CursorLine = { bg = "#2a2e36" }, -- Choose a visible color
			},
		})
		--Lua:
		vim.g.material_style = "deep ocean"
		vim.cmd("colorscheme material")
	end,
}
