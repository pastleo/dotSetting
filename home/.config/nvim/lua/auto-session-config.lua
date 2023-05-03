local autoSession = safe_require('auto-session')

if autoSession == false then return end

vim.o.sessionoptions='blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

autoSession.setup({
  log_level = 'info',
  auto_session_suppress_dirs = {
    '/', '~/', '~/Downloads', '~/download', '~/workspace',
  },
  session_lens = {
    prompt_title = 'Switch Session (Ctrl-d to delete)',
  }
})
