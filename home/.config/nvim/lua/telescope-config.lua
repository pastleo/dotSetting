local telescope = safe_require('telescope')
if telescope == false then return end

-- https://github.com/nvim-telescope/telescope.nvim
-- NOTE: `<leader>fg` / telescopeBuiltin.live_grep() require ripgrep to work:
--   https://github.com/BurntSushi/ripgrep

local actions = require("telescope.actions")

local file_picker_options = {
  disable_devicons = vim.g.disable_devicons,
}

local previewers = require("telescope.previewers")

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size > 100000 then
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

telescope.setup({
  defaults = {
    layout_strategy = 'vertical',
    dynamic_preview_title = true,
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
    buffer_previewer_maker = new_maker,
  },
  pickers = {
    git_files = file_picker_options,
    find_files = file_picker_options,
    live_grep = file_picker_options,
  }
})
