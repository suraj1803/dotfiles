-- return {
--     "bradcush/nvim-base16",
--     config = function()
--         vim.cmd("colorscheme base16-google-dark")
--
--         local transparent = {
--             "Normal",
--             "NormalNC",
--             "NormalFloat",
--             "FloatBorder",
--             "FloatTitle",
--             "TabLine",
--             "TabLineFill",
--             "WinBar",
--             "WinBarNC",
--             "VertSplit",
--             "WinSeparator",
--         }
--
--         for _, group in ipairs(transparent) do
--             vim.api.nvim_set_hl(0, group, { bg = "NONE" })
--         end
--
--         -- Keep active tab highlighted
--         vim.api.nvim_set_hl(0, "TabLineSel", {
--             bg = "#303030",
--             fg = "#ffffff",
--             bold = true,
--         })
--
--         -- Bold functions and keywords
--         vim.api.nvim_set_hl(0, "Function", {
--             bold = true,
--         })
--
--         vim.api.nvim_set_hl(0, "Keyword", {
--             bold = true,
--         })
--     end,
-- }

-- Lazy
return {
  "olimorris/onedarkpro.nvim",
  priority = 1000, -- Ensure it loads first
  config = function ()
      require("onedarkpro").setup({

          options = {
              cursorline = false, -- Use cursorline highlighting?
              transparency = true, -- Use a transparent background?
              terminal_colors = false, -- Use the theme's colors for Neovim's :terminal?
              lualine_transparency = true, -- Center bar transparency?
              highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
          }
      })
      vim.cmd("colorscheme onedark")
  end
}

-- somewhere in your config:
