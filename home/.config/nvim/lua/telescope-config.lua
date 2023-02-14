local telescope = safe_require('telescope')
if telescope == false then return end

-- https://github.com/nvim-telescope/telescope.nvim
-- NOTE: `<leader>fg` / telescopeBuiltin.live_grep() require ripgrep to work:
--   https://github.com/BurntSushi/ripgrep

telescope.setup({
  -- all default for now
})

local telescopeBuiltin = require('telescope.builtin')
vim.keymap.set('n', '<leader>t', function()
  vim.cmd[[set nopaste]]
  if table.getn(vim.fs.find(".git", { type = "directory", upward = true })) > 0 then
    telescopeBuiltin.git_files()
  else
    telescopeBuiltin.find_files({ hidden = true, follow = true })
  end
end, {})
vim.keymap.set('n', '<leader>w', function()
  vim.cmd[[set nopaste]]
  telescopeBuiltin.find_files({
    cwd = vim.fn.expand(vim.fn.expand('%:p:h')),
    hidden = true, no_ignore = true, no_ignore_parent = true, follow = true
  })
end, {})
vim.keymap.set('n', '<leader>ff', function()
  vim.cmd[[set nopaste]]
  telescopeBuiltin.find_files({
    hidden = true, no_ignore = true, no_ignore_parent = true, follow = true
  })
end, {})
vim.keymap.set('n', '<leader>fg', function()
  vim.cmd[[set nopaste]]
  telescopeBuiltin.live_grep()
end, {})
vim.keymap.set('n', '<leader>fh', function()
  vim.cmd[[set nopaste]]
  telescopeBuiltin.help_tags()
end, {})
