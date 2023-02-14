local autoSession = safe_require('auto-session')
if autoSession == false then return end

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
