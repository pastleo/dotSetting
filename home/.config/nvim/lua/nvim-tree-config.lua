-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local nvimTree = safe_require('nvim-tree')
if nvimTree == false then return end

nvimTree.setup({
  hijack_netrw = true,
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  modified = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
  },
  view = {
    float = {
      enable = true,
      quit_on_focus_loss = true,
      open_win_config = function()
        return {
          relative = "editor",
          border = "rounded",
          width = math.floor(vim.o.columns / 3),
          height = vim.o.lines - 10,
          row = 5,
          col = math.floor(vim.o.columns / 10),
        }
      end,
    },
  },
  renderer = {
    highlight_git = true,
    highlight_opened_files = "#FFFF00",
    highlight_modified = "#FFFFFF",
    indent_markers = {
      enable = true,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      modified_placement = "after",
      padding = " ",
      symlink_arrow = " -> ",
      show = {
        file = false,
        folder = true,
        folder_arrow = false,
        git = false,
        modified = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "",
        modified = "!",
        folder = {
          default = "-",
          open = "+",
          empty = "-",
          empty_open = "+",
          symlink = "=",
          symlink_open = "*",
        },
      },
    },
  },
})

vim.keymap.set("n", "<leader>w", function()
  vim.api.nvim_command(":NvimTreeOpen")
end)
vim.keymap.set("n", "<leader>q", function()
  vim.api.nvim_command(":NvimTreeClose")
end)
