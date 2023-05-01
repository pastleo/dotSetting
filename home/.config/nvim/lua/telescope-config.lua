local telescope = safe_require('telescope')
if telescope == false then return end

-- https://github.com/nvim-telescope/telescope.nvim
-- NOTE: `<leader>fg` / telescopeBuiltin.live_grep() require ripgrep to work:
--   https://github.com/BurntSushi/ripgrep

local actions = require("telescope.actions")

local file_picker_options = {
  disable_devicons = vim.g.disable_devicons,
}

telescope.setup({
  defaults = {
    layout_strategy = 'vertical',
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
