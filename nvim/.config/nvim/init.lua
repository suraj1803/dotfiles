require("config.general")
require("config.keymaps")
require("config.lazy")

vim.lsp.enable('lua_ls')
-- Configure server settings, capabilities, or filetypes
vim.lsp.config["ts_ls"] = {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayVariableTypeHints = true,
      },
    },
  },
}

-- Activate the server
vim.lsp.enable("ts_ls")
vim.lsp.enable("ts_ls")
vim.lsp.enable('clangd')
vim.lsp.enable('rust_analyzer')

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
    end,
})
