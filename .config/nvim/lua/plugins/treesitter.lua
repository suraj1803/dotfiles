return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- Import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- Configure treesitter
    treesitter.setup({
      -- Enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- Enable indentation
      indent = { enable = true },
      -- Ensure these language parsers are installed
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })

    -- ✅ Fix: Call `setup()` for `nvim-ts-autotag` separately
    require("nvim-ts-autotag").setup()
  end,
}
