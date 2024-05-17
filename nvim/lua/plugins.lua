return {
  { "xiyaowong/transparent.nvim"},
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    opts = {

    }
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
  }
}
