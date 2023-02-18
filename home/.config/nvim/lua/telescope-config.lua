local telescope = safe_require('telescope')
if telescope == false then return end

-- https://github.com/nvim-telescope/telescope.nvim
-- NOTE: `<leader>fg` / telescopeBuiltin.live_grep() require ripgrep to work:
--   https://github.com/BurntSushi/ripgrep

local open_in_nvim_tree = function(prompt_bufnr)
  local action_state = require "telescope.actions.state"
  local Path = require "plenary.path"
  local actions = require "telescope.actions"

  local entry = action_state.get_selected_entry()[1]
  local entry_path = Path:new(entry):parent():absolute()
  actions._close(prompt_bufnr, true)
  entry_path = Path:new(entry):parent():absolute()
  entry_path = entry_path:gsub("\\", "\\\\")

  vim.cmd("NvimTreeClose")
  vim.cmd("NvimTreeOpen " .. entry_path)

  -- TODO
  -- nvimTreeApi.tree.close()
  -- nvimTreeApi.tree.open()
  -- vim.notify("hello?")
  -- vim.notify(entry_path .. file_name)
  -- nvimTreeApi.tree.find_file(entry_path .. file_name)

  file_name = nil
  for s in string.gmatch(entry, "[^/]+") do
    file_name = s
  end

  vim.cmd("/" .. file_name)
end

local actions = require("telescope.actions")
telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        -- ["<C-o>"] = open_in_nvim_tree,
      },
    },
  },
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
vim.keymap.set('n', '<leader>fa', function()
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
