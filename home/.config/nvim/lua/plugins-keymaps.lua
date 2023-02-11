-- tpope/vim-commentary
vim.keymap.set("x", "<leader>/", "<Plug>Commentary")
vim.keymap.set("n", "<leader>/", "<Plug>CommentaryLine")
vim.keymap.set("o", "<leader>/", "<Plug>Commentary")

-- mattn/emmet-vim
vim.keymap.set("n", "<leader>e", ":Emmet<space>")

-- mbbill/undotree
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")

-- nvim-telescope/telescope.nvim
local telescopeBuiltin = safe_require('telescope.builtin')
if telescopeBuiltin ~= false then
  vim.keymap.set('n', '<leader>ff', function()
		vim.cmd[[set nopaste]]
    if table.getn(vim.fs.find(".git", { type = "directory", upward = true })) > 0 then
      telescopeBuiltin.git_files()
    else
      telescopeBuiltin.find_files({ hidden = true, follow = true })
    end
  end, {})
  vim.keymap.set('n', '<leader>fF', function()
		vim.cmd[[set nopaste]]
    telescopeBuiltin.find_files({ hidden = true, no_ignore = true, no_ignore_parent = true, follow = true })
  end, {})
  vim.keymap.set('n', '<leader>fg', function()
		vim.cmd[[set nopaste]]
    telescopeBuiltin.live_grep()
  end, {})
  vim.keymap.set('n', '<leader>fh', function()
		vim.cmd[[set nopaste]]
    telescopeBuiltin.help_tags()
  end, {})
end

-- tpope/vim-fugitive
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>")
vim.keymap.set("n", "<leader>gs", ":Gdiffsplit<CR>")
