-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local nvim_tree = safe_require('nvim-tree')
if nvim_tree == false then return end

local nvim_tree_config = {
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
  git = {
    ignore = false,
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
          col = math.floor(vim.o.columns / 3),
        }
      end,
    },
    mappings = {
      list = {
        { key = "<C-c>", action = "close" },
      }
    }
  },
  renderer = {
    -- as quick manual:
    root_folder_label = ":~:s?$?/ [ q: close, -: up, o: open, a: create, d: remove, c: copy, p: paste, R: refresh ]?",
    highlight_git = true,
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
        file = not vim.g.disable_devicons,
        folder = true,
        folder_arrow = false,
        git = false,
        modified = true,
      },
    },
  },
  update_focused_file = {
    enable = true,
    update_root = true,
    ignore_list = {},
  },
}

if vim.g.disable_devicons then
  nvim_tree_config.renderer.icons.glyphs = {
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
  }
end

nvim_tree.setup(nvim_tree_config)

vim.keymap.set("n", "<leader>w", function()
  if vim.fn.expand('%') == '' then
    vim.api.nvim_command(":NvimTreeOpen")
  else
    vim.api.nvim_command(":NvimTreeFindFile")
  end
end)
