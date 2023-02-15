-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local nvimTree = safe_require('nvim-tree')
if nvimTree == false then return end

nvimTree.setup({
  renderer = {
    icons = {
      webdev_colors = true,
      git_placement = "before",
      modified_placement = "after",
      padding = " ",
      symlink_arrow = " -> ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
        modified = true,
      },
      glyphs = {
        default = "",
        symlink = "l",
        bookmark = "",
        modified = "!",
        folder = {
          arrow_closed = "->",
          arrow_open = "+>",
          default = "-",
          open = "+",
          empty = "-",
          empty_open = "+",
          symlink = "-",
          symlink_open = "+",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "!!",
          renamed = "➜",
          untracked = "?",
          deleted = "D",
          ignored = "I",
        },
      },
    },
  }
})

vim.keymap.set("n", "<leader>w", function()
  vim.api.nvim_command(":NvimTreeOpen")
end)
vim.keymap.set("n", "<leader>q", function()
  vim.api.nvim_command(":NvimTreeClose")
end)
-- vim.keymap.set("n", "<leader>N", function()
--   vim.cmd[[:tabnew<CR>]]
--   vim.api.nvim_command(":NvimTreeOpen")
-- end)
-- vim.keymap.set("n", "<leader>I", function()
--   vim.cmd[[:new<CR>]]
--   vim.api.nvim_command(":NvimTreeOpen")
-- end)
-- vim.keymap.set("n", "<leader>S", function()
--   vim.cmd[[:vnew<CR>]]
--   vim.api.nvim_command(":NvimTreeOpen")
-- end)
