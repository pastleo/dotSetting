-- lukas-reineke/indent-blankline.nvim
local indent_blankline = safe_require('indent_blankline')
if indent_blankline ~= false then
  indent_blankline.setup {
    space_char_blankline = " ",
    show_current_context = true,
  }
end

-- mbbill/undotree
vim.g.undotree_SetFocusWhenToggle = 1

-- lewis6991/gitsigns.nvim
local gitsigns = safe_require('gitsigns')
if gitsigns ~= false then
  gitsigns.setup()
end

-- rmagatti/auto-session
local autoSession = safe_require('auto-session')
if autoSession ~= false then
  -- https://github.com/rmagatti/auto-session
  -- `nvim .` (or with args opening file) to prevent auto restoring & saving
  --   in this case, `:Q` to save session and quit
  -- `:Autosession search` to list all saved sessions
  -- `:Autosession delete` to select and delete a session

  autoSession.setup({
    auto_session_suppress_dirs = { '~/', '/' }
  })

  vim.api.nvim_create_user_command(
    'Q',
    function()
      vim.cmd.SaveSession()
      vim.cmd.qa()
    end,
    {}
  )
end

local nvimAutopairs = safe_require('nvim-autopairs')
if nvimAutopairs ~= false then
  nvimAutopairs.setup {}
end

local nvimTsAutotag = safe_require('nvim-ts-autotag')
if nvimTsAutotag ~= false then
  nvimTsAutotag.setup {}
end
