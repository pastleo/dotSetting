local telescope = safe_require('telescope')
if telescope == false then return end

-- https://github.com/nvim-telescope/telescope.nvim
-- NOTE: `<leader>fg` / telescopeBuiltin.live_grep() require ripgrep to work:
--   https://github.com/BurntSushi/ripgrep

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local file_picker_config = (function()
  local nvimTreeApi = safe_require('nvim-tree.api')
  if nvimTreeApi == false then return {} end

  return {
    mappings = {
      i = {
        ['<CR>'] = function(prompt_bufnr)
          -- close telescope and get selected path, take from:
          --   https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#replacing-actions
          actions.close(prompt_bufnr)
          local picked_fullpath = vim.fn.getcwd() .. "/" .. action_state.get_selected_entry()[1]

          -- try to open in nvim-tree first
          nvimTreeApi.tree.open()
          nvimTreeApi.tree.find_file(picked_fullpath)

          local nvim_tree_find_file_ok =
            nvimTreeApi.tree.get_node_under_cursor().absolute_path == vim.fn.expand(picked_fullpath)

          if not nvim_tree_find_file_ok then -- selected file not available under nvim-tree
            -- fallback to open the file directly with nvim-tree open-file action
            --   because open-file from nvim-tree is able to choose what split to open
            nvimTreeApi.tree.close()
            require("nvim-tree.actions.node.open-file").fn(nil, picked_fullpath)
          end
        end,
        ['<C-o>'] = actions.select_default,
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
