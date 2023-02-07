local telescope = safe_require('telescope')
if telescope == false then return end

telescope.setup {
  extensions = {
    file_browser = {
      dir_icon = '+',
      mappings = {
        -- ["i"] = {
          -- your custom insert mode mappings
        -- },
        -- ["n"] = {
          -- your custom normal mode mappings
        -- },
      },
    },
  },
}

require("telescope").load_extension "file_browser"
