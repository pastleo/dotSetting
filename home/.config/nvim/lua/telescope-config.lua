local telescope = safe_require('telescope')
if telescope == false then return end

-- https://github.com/nvim-telescope/telescope.nvim
-- NOTE: `<leader>fg` / telescopeBuiltin.live_grep() require ripgrep to work:
--   https://github.com/BurntSushi/ripgrep

local actions = require("telescope.actions")

local file_picker_options = { disable_devicons = vim.g.disable_devicons }
telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  },
  pickers = {
    git_files = file_picker_options,
    find_files = file_picker_options,
    live_grep = file_picker_options,
  }
})

local telescopeBuiltin = require('telescope.builtin')
vim.keymap.set('n', '<leader>t', function()
  if table.getn(vim.fs.find(".git", { type = "directory", upward = true })) > 0 then
    telescopeBuiltin.git_files()
  else
    telescopeBuiltin.find_files({ hidden = true, follow = true })
  end
end, {})

vim.keymap.set('n', '<leader>ff', telescopeBuiltin.builtin, {})
vim.keymap.set('n', '<leader>fa', function()
  telescopeBuiltin.find_files({
    hidden = true, no_ignore = true, no_ignore_parent = true, follow = true
  })
end, {})
vim.keymap.set('n', '<leader>fg', telescopeBuiltin.live_grep, {})

vim.keymap.set('n', '<leader>fh', telescopeBuiltin.help_tags, {})
