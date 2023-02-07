vim.g.mapleader = "t"

-- vim.keymap.set("n", "<leader>t", vim.cmd.Ex)
vim.keymap.set("n", "<leader>n", ":tabnew<CR>")
vim.keymap.set("n", "<leader>N", ":tab split<CR>")
vim.keymap.set("n", "<leader>i", ":new<CR>")
vim.keymap.set("n", "<leader>I", ":split<CR>")
vim.keymap.set("n", "<leader>s", ":vnew<CR>")
vim.keymap.set("n", "<leader>S", ":vsplit<CR>")

vim.keymap.set("n", "<leader>h", ':tabprevious<CR>')
vim.keymap.set("n", "<leader>l", ':tabnext<CR>')
vim.keymap.set("n", "<leader>j", "<C-w>w")
vim.keymap.set("n", "<leader>k", "<C-W>W")

vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>")
vim.keymap.set("n", "<leader>gs", ":Gdiffsplit<CR>")

local telescopeBuiltin = safe_require('telescope.builtin')
if telescopeBuiltin ~= false then
  vim.keymap.set(
    "n",
    "<leader>t",
    ":Telescope file_browser<CR>", -- TODO: make it remember last cwd
    {}
  )
  vim.keymap.set(
    "n",
    "<leader>w",
    "<cmd>lua require 'telescope'.extensions.file_browser.file_browser({ path = vim.fn.expand(vim.fn.expand('%:p:h'))  })<CR>",
    {}
  )
  vim.keymap.set('n', '<leader>ff', function()
    if table.getn(vim.fs.find(".git", { type = "directory", upward = true })) > 0 then
      telescopeBuiltin.git_files()
    else
      telescopeBuiltin.find_files()
    end
  end, {})
  vim.keymap.set('n', '<leader>fF', function()
    telescopeBuiltin.find_files({ hidden = true, no_ignore = true, no_ignore_parent = true })
  end, {})
  vim.keymap.set('n', '<leader>fg', telescopeBuiltin.live_grep, {})
  vim.keymap.set('n', '<leader>fb', telescopeBuiltin.buffers, {})
  vim.keymap.set('n', '<leader>fh', telescopeBuiltin.help_tags, {})
end
