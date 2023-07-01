local mason = safe_require('mason')
local masonLspconfig = safe_require('mason-lspconfig')
local cmpNvimLsp = safe_require('cmp_nvim_lsp')
local lspconfig = safe_require('lspconfig')

if
  mason == false or
  masonLspconfig == false or
  cmpNvimLsp == false or
  lspconfig == false
then return end

-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/lsp.md#you-might-not-need-lsp-zero

mason.setup()

masonLspconfig.setup({
  ensure_installed = {
    'tsserver',
  }
})

masonLspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      -- on_attach = function(client, bufnr)
      --   keybindings here...
      -- end,
      capabilities = cmpNvimLsp.default_capabilities(),
    })
  end,
})
