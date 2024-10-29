-- return { "ellisonleao/gruvbox.nvim", priority = 1000 ,
--   config = function()
--     -- Default options:
--     require("gruvbox").setup({
--       terminal_colors = false, -- add neovim terminal colors
--       undercurl = true,
--       underline = true,
--       bold = true,
--       italic = {
--         strings = true,
--         emphasis = true,
--         comments = true,
--         operators = false,
--         folds = true,
--       },
--       strikethrough = true,
--       transparent_mode = false,
--     })
--     -- vim.o.background = "dark" -- or "light" for light mode
--     vim.cmd("colorscheme gruvbox")
--   end
-- }

return  {
  'sainnhe/gruvbox-material',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_enable_italic = true
    vim.g.gruvbox_material_enable_bold = true
    vim.g.gruvbox_material_background = 'hard'
    vim.g.gruvbox_material_foreground = 'original'
    -- vim.g.gruvbox_material_transparent_background = 1
    vim.cmd.colorscheme('gruvbox-material')
    vim.o.background = "dark" -- or "light" for light mode
  end
}
