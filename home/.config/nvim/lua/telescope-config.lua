local telescope = safe_require('telescope')
if telescope == false then return end

-- https://github.com/nvim-telescope/telescope.nvim
-- NOTE: `<leader>fg` / telescopeBuiltin.live_grep() require ripgrep to work:
--   https://github.com/BurntSushi/ripgrep

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local file_picker_config = (function()
  local nvim_tree_api = safe_require('nvim-tree.api')
  if nvim_tree_api == false then return {} end
  local nvim_tree_open_file = require("nvim-tree.actions.node.open-file").fn

  local get_picked_fullpath = function()
    -- get selected path, take from:
    --   https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#replacing-actions
    return vim.fn.getcwd() .. "/" .. action_state.get_selected_entry()[1]
  end

  return {
    disable_devicons = vim.g.disable_devicons,
    mappings = {
      i = {
        ['<C-o>'] = actions.select_default, -- move telescope's `<CR>` select_default to `<C-o>`
        ['<CR>'] = function(prompt_bufnr) -- open the file directly with nvim-tree open-file action
          --  open-file from nvim-tree is able to choose what split to open
          actions.close(prompt_bufnr)
          nvim_tree_open_file(nil, get_picked_fullpath())
        end,
        ['<C-w>'] = function(prompt_bufnr) -- open in nvim-tree
          actions.close(prompt_bufnr)

          nvim_tree_api.tree.open()
          nvim_tree_api.tree.find_file(get_picked_fullpath())
        end,
      }
    }
  }
end)()


telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  },
  pickers = {
    git_files = file_picker_config,
    find_files = file_picker_config,
    live_grep = { disable_devicons = vim.g.disable_devicons },
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
