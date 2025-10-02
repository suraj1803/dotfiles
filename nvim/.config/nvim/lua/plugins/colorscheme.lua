return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    require("tokyonight").setup({
      transparent = true,
      style = "night",
      styles = {
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent",   -- style for floating windows
      },
    })

    vim.cmd([[colorscheme tokyonight]])
  end,
}
