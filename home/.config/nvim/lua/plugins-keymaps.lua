-- tpope/vim-commentary
vim.keymap.set("x", "<leader>/", "<Plug>Commentary")
vim.keymap.set("n", "<leader>/", "<Plug>CommentaryLine")
vim.keymap.set("o", "<leader>/", "<Plug>Commentary")

-- mattn/emmet-vim
vim.keymap.set("n", "<leader>e", ":Emmet<space>")

-- mbbill/undotree
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")

-- tpope/vim-fugitive
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>")
vim.keymap.set("n", "<leader>gs", ":Gdiffsplit<CR>")

-- nvim-telescope/telescope.nvim
-- >> see ./telescope-config.lua <<
--
-- * `<leader>t`:
--   * if under a git repo, fuzzy search through the output of git ls-files command, respects .gitignore
--   * otherwise lists files in current working directory, respects .gitignore
-- * `<leader>ff`: lists telescope built-in pickers to run
-- * `<leader>fa`: lists all files in current working directory, including hidden, gitignore files
-- * `<leader>fg`: search for a string in file content under current working directory and get results live as you type, respects .gitignore. (requires ripgrep)
-- * `<leader>fh`: lists available nvim help tags
--
-- when using file pickers (`<leader>t`, `<leader>fa` and `<leader>fg`),
--   `<CR>` will bring up nvim-tree to focus on the file first (and enter again to open file with nvim-tree),
--     if not available then use open-file from nvim-tree to choose split to open
--   `<C-o>` to open file with telescope's default select behavior

-- nvim-tree/nvim-tree.lua
-- >> see ./nvim-tree-config.lua <<
--
-- * `<leader>w`: open nvim-tree and focus on current file is available, o.w. open nvim-tree
-- * within nvim-tree,
--   * added `<C-c>` in addition to `q` to close nvim-tree, align with telescope

-- VonHeikemen/lsp-zero.nvim
-- >> see ./lsp-zero-config.lua <<
--
-- if lsp available, keymaps:
-- * `<space>`: displays hover information
-- * `<leader><space>`: displays diagnostics information (errors/warnings/hints...)
-- * `gd`: jump to definition, or list using telescope, same as lsp-zero & vim default keymap
-- * `gD`: jump to declaration, same as lsp-zero & vim default keymap
-- * `go`: jump to definition of type, or list using telescope, same as lsp-zero default keymap
-- * `<leader>cr`: lists references using telescope
-- * `<leader>ci`: lists implementations using telescope
-- * `<leader>cd`: lists diagnostics (errors/warnings/hints...) of current buffer using telescope
-- * `<leader>cR`: rename
-- * `<leader>cA`: code actions
-- auto-completion keymaps:
-- * `<Tab>`: select and insert first or next item
-- * `<S-Tab>`: select and insert previous item
-- * `<C-n>`: select and insert next item
-- * `<C-p>`: select and insert previous item
-- * `<C-b>`: abort auto-completion, as if nothing happens
