local lsp = safe_require('lsp-zero')
if lsp == false then return end

-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
lsp.preset('recommended')

-- When you don't have mason.nvim installed
-- You'll need to list the servers installed in your system
lsp.setup_servers({'tsserver', 'eslint'})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()
