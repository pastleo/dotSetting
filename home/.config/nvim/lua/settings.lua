-- always block cursor
vim.opt.guicursor = ""

-- keep 8 lines above/below when jk cursors
vim.opt.scrolloff = 8

-- show trailing spaces
vim.opt.list = true

-- line numbers
vim.opt.numberwidth = 1
vim.cmd[[
  " only show (relative) line number on current window/split
  augroup ToggleLineNumber
    autocmd!
    autocmd WinEnter * set relativenumber
    autocmd WinEnter * set number
    autocmd WinLeave * set norelativenumber
    autocmd WinLeave * set nonumber
  augroup END
]]

-- make CursorLineNr (current line number) highlighted
--   https://vi.stackexchange.com/a/24914
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

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
