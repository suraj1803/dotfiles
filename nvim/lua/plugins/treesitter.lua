return {
  "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query" , "cpp"},
      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
    }
  end
}
