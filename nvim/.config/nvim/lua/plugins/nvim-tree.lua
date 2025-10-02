return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup({
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    })
    local map = vim.keymap
    map.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", {desc="Toggle file explorer"})
  end
}
