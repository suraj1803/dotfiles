return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    require("nvim-tree").setup ({
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

    vim.keymap.set('n', '<leader>ee', "<cmd>NvimTreeToggle<CR>")
    local toggle_focus = 0

    function ToggleNvimTreeFocus()
      if toggle_focus == 0 then
        toggle_focus = 1
        vim.cmd("wincmd l")
      else
        toggle_focus = 0
        vim.cmd("NvimTreeFocus")
      end
    end

    vim.api.nvim_set_keymap("n", "<leader>ef", ":lua ToggleNvimTreeFocus()<CR>", { noremap = true, silent = true })

  end,


}
