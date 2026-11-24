local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation (2 spaces, Lua-friendly)
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Wrapping & display
opt.wrap = false
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.showmode = false -- Statusline will display mode
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Files, backups & undo
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 300

-- Clipboard & mouse
opt.clipboard = "unnamedplus"
opt.mouse = "a"

-- Completion menu behavior
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 10

-- Confirm unsaved changes instead of failing
opt.confirm = true
