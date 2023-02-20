-- always block cursor
vim.opt.guicursor = ""

-- keep 8 lines above/below when jk cursors
vim.opt.scrolloff = 8

-- show trailing spaces
vim.opt.list = true

-- line numbers
-- vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 1

-- indention
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- no .swp files
vim.opt.swapfile = false
vim.opt.backup = false

-- undo beyond sessions
--   with mbbill/undotree
vim.opt.undodir = vim.fn.stdpath('data') .. "/.vim/undodir"
vim.opt.undofile = true

-- split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true
