local lsp = safe_require('lsp-zero')
local cmp = safe_require('cmp')
if lsp == false or cmp == false then return end

-- https://github.com/VonHeikemen/lsp-zero.nvim
-- hints:
-- * use :Lsp<tab> to see available commands
-- * :LspInfo to see status of current running language servers
-- * :Mason to manage language servers
--   * type `g?` to see help, `q` to quit Mason

lsp.preset({
  name = 'recommended',
  set_lsp_keymaps = false, -- disable first because I don't want most of them
  sign_icons = {
    error = 'E', warn = 'W', hint = 'H', info = 'I'
  }
})

lsp.ensure_installed({
  'tsserver',
})
-- lsp.skip_server_setup({
-- })

lsp.configure('lua_ls', { -- fix for nvim config lua
  settings = {
    Lua = { diagnostics = { globals = { 'vim', 'safe_require' } } },
    telemetry = { enable = false },
  }
})

local telescopeBuiltin = safe_require('telescope.builtin')
lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set('n', '<space>', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader><space>', vim.diagnostic.open_float, opts)

  if telescopeBuiltin ~= false then
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
  else
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
  end
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

  vim.keymap.set('n', '<leader>cR', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>cA', vim.lsp.buf.code_action, opts)
end)

local cmpSelectInsert = { behavior = cmp.SelectBehavior.Insert }
lsp.setup_nvim_cmp({
  mapping = {
    -- modified from https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#intellij-like-mapping
		['<Tab>'] = cmp.mapping(function(fallback)
      -- lsp.setup_nvim_cmp's preselect opt doesn't work, this is a workaround that:
      -- * first <tab> to select and insert pre-selected (first) item
      -- * press <tab> again to select and insert next item
			if cmp.visible() then
				local entry = cmp.get_active_entry() -- nil if is pre-selected
				if not entry then
					cmp.select_next_item({
            count = 0, -- keep at pre-selected item
            behavior = cmp.SelectBehavior.Insert
          })
				else
					cmp.select_next_item(cmpSelectInsert)
				end
			else
				fallback()
			end
		end, { 'i' }),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(cmpSelectInsert),
    ['<C-n>'] = cmp.mapping.select_next_item(cmpSelectInsert),
    ['<C-p>'] = cmp.mapping.select_prev_item(cmpSelectInsert),
    ['<C-b>'] = cmp.mapping.abort(),
  }
})

lsp.setup()
