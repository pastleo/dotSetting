-- tpope/vim-commentary
vim.keymap.set('x', '<leader>/', ':CommentToggle<CR>')
vim.keymap.set('n', '<leader>/', ':CommentToggle<CR>')
vim.keymap.set('o', '<leader>/', ':CommentToggle<CR>')

-- mattn/emmet-vim
vim.keymap.set('n', '<leader>e', ':Emmet<space>')

-- mbbill/undotree
vim.keymap.set('n', '<leader>u', function() vim.cmd('UndotreeToggle') end)

-- tpope/vim-fugitive
vim.keymap.set('n', '<leader>gb', function() vim.cmd('Git blame') end)

-- nvim-telescope/telescope.nvim
local telescopeBuiltin = safe_require('telescope.builtin')
if telescopeBuiltin ~= false then
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

  -- lsp related
  vim.keymap.set('n', 'gd', function()
    vim.cmd[[set nopaste]]
    telescopeBuiltin.lsp_definitions()
  end, {})
  vim.keymap.set('n', 'go', function()
    vim.cmd[[set nopaste]]
    telescopeBuiltin.lsp_type_definitions()
  end, {})
  vim.keymap.set('n', '<leader>cr', function()
    vim.cmd[[set nopaste]]
    telescopeBuiltin.lsp_references()
  end, {})
  vim.keymap.set('n', '<leader>ci', function()
    vim.cmd[[set nopaste]]
    telescopeBuiltin.lsp_implementations()
  end, {})
  vim.keymap.set('n', '<leader>cd', function()
    vim.cmd[[set nopaste]]
    telescopeBuiltin.diagnostics({ bufnr = 0 })
  end, {})

  local autoSessionLens = safe_require('auto-session.session-lens')
  if autoSessionLens ~= false then
    local autoSession = safe_require('auto-session')

    vim.keymap.set('n', '<leader>`', autoSessionLens.search_session, {
      noremap = true,
    })
    vim.keymap.set('n', '<leader>~', function()
      local sessions_dir = (
        vim.fn.getcwd() .. '/' ..
        vim.fn.input('saving session for current cwd, name: ', vim.fn.strftime('%y-%m-%d_%H-%M-%S'))
      )
      autoSession.AutoSaveSession(sessions_dir)
      print('session saved: ' .. sessions_dir)
    end)
  end
else
  -- fallback
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
  vim.keymap.set('n', 'go', vim.lsp.buf.type_definition)
end
-- NOTE: some lsp keymaps are in ./keymaps.lua

-- nvim-tree/nvim-tree.lua
vim.keymap.set('n', '<leader>w', function() vim.cmd('NvimTreeOpen') end)

-- stevearc/aerial.nvim
vim.keymap.set('n', '<leader>a', function() vim.cmd('AerialOpen') end)
