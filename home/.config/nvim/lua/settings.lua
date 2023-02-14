vim.opt.guicursor = ""
vim.opt.scrolloff = 8
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath('data') .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.splitright = true
vim.opt.splitbelow = true

-- disable vim's built-in netrw (file manager)
vim.g.loaded_netrwPlugin = 1