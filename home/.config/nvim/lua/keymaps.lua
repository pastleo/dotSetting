-- set leader to t key
vim.g.mapleader = "t"

if vim.g.vscode then
  -- New tab
  vim.keymap.set("n", "<leader>n", function() vim.cmd('Tabnew') end)

  -- split
  vim.keymap.set("n", "<leader>i", function() vim.cmd("Split") end)
  vim.keymap.set("n", "<leader>I", function() vim.cmd("New") end)
  vim.keymap.set("n", "<leader>s", function() vim.cmd("Vsplit") end)
  vim.keymap.set("n", "<leader>S", function() vim.cmd("Vnew") end)

  -- Tabs & split navigations
  vim.keymap.set("n", "<leader>h", function() vim.cmd('Tabprevious') end)
  vim.keymap.set("n", "<leader>l", function() vim.cmd('Tabnext') end)
  vim.keymap.set("n", "<leader>j", function() vim.fn.VSCodeNotify('workbench.action.focusNextGroup') end)
  vim.keymap.set("n", "<leader>k", function() vim.fn.VSCodeNotify('workbench.action.focusPreviousGroup') end)

  -- move split line
  vim.keymap.set("n", "<S-J>", function() vim.fn.VSCodeNotify('workbench.action.increaseViewHeight') end)
  vim.keymap.set("n", "<S-K>", function() vim.fn.VSCodeNotify('workbench.action.decreaseViewHeight') end)
  vim.keymap.set("n", "<S-L>", function() vim.fn.VSCodeNotify('workbench.action.increaseViewWidth') end)
  vim.keymap.set("n", "<S-H>", function() vim.fn.VSCodeNotify('workbench.action.decreaseViewWidth') end)

  -- vscode built-in action, imitating my nvim setup
  vim.keymap.set("n", "<space>", function() vim.fn.VSCodeNotify('editor.action.showHover') end)
  vim.keymap.set("n", "<leader>cr", function() vim.fn.VSCodeNotify('references-view.findReferences') end)
  vim.keymap.set("n", "<leader>t", function() vim.fn.VSCodeNotify('workbench.action.quickOpen') end)
  vim.keymap.set("n", "<leader>w", function() vim.fn.VSCodeNotify('workbench.view.explorer') end)
  vim.keymap.set("n", "<leader>fg", function() vim.fn.VSCodeNotify('workbench.action.findInFiles') end)
  vim.keymap.set("n", "<leader>a", function() vim.fn.VSCodeNotify('outline.focus') end)

  vim.cmd[[
    function! s:vscodeCommentary(...) abort
      if !a:0
        let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
      elseif a:0 > 1
        let [line1, line2] = [a:1, a:2]
      else
        let [line1, line2] = [line("'["), line("']")]
      endif

      call VSCodeCallRange("editor.action.commentLine", line1, line2, 0)
    endfunction

    xnoremap <expr> <leader>/ <SID>vscodeCommentary()
    nnoremap <expr> <leader>/ <SID>vscodeCommentary() . '_'
  ]]
else
  -- New tab
  vim.keymap.set("n", "<leader>n", function() vim.cmd('tabnew') end)
  vim.keymap.set("n", "<leader>N", function() vim.cmd('tab split') end)

  -- split
  vim.keymap.set("n", "<leader>i", function() vim.cmd("split") end)
  vim.keymap.set("n", "<leader>I", function() vim.cmd("new") end)
  vim.keymap.set("n", "<leader>s", function() vim.cmd("vsplit") end)
  vim.keymap.set("n", "<leader>S", function() vim.cmd("vnew") end)

  -- split vertically and diff with a file
  vim.keymap.set("n", "<leader>D", ":vert diffsplit<SPACE>")

  -- Tabs & split navigations
  vim.keymap.set("n", "<leader>h", function() vim.cmd('tabprevious') end)
  vim.keymap.set("n", "<leader>l", function() vim.cmd('tabnext') end)
  vim.keymap.set("n", "<leader>j", "<C-w>w")
  vim.keymap.set("n", "<leader>k", "<C-W>W")

  -- move split line
  vim.keymap.set("n", "<S-J>", function() vim.cmd("resize +1") end)
  vim.keymap.set("n", "<S-K>", function() vim.cmd("resize -1") end)
  vim.keymap.set("n", "<S-L>", function() vim.cmd("vertical resize +2") end)
  vim.keymap.set("n", "<S-H>", function() vim.cmd("vertical resize -2") end)

  -- move tabs
  vim.keymap.set("n", "<leader>L", ":tabmove +<CR>")
  vim.keymap.set("n", "<leader>H", ":tabmove -<CR>")

  -- move selected lines
  vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
  vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

  -- search current word in normal mode
  -- just type "*" for next, "#" for prev
  -- "*" can also be used to search selected texts
  --   but some characters are not allowed

  -- replace current selected (ref: https://stackoverflow.com/a/676619)
  vim.keymap.set("v", "<leader>r", [["hy:%s/<C-r>h//gc<left><left><left>]])

  -- jumping back and forth after jumping definitions
  -- * `<C-o>` to go back
  -- * `<C-i>` to go forth
  -- `i` and `o` are next to each other ;)

  -- lsp
  -- NOTE: most lsp keymaps are in ./plugins-keymaps working with telescope (i.e. goto definition, list references)
  vim.keymap.set('n', '<space>', vim.lsp.buf.hover)
  vim.keymap.set('n', '<leader><space>', vim.diagnostic.open_float)

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)

  vim.keymap.set('n', '<leader>cR', vim.lsp.buf.rename)
  vim.keymap.set('n', '<leader>cA', vim.lsp.buf.code_action)
end

-- allow multiple indentation/deindentation in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- block visual
vim.keymap.set("n", "<leader>v", "<C-v>")

-- <leader>p toggles paste mode
vim.keymap.set("n", "<leader>p", ":set paste!<BAR>set paste?<CR>")

-- paste while keeping clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])

-- copy into system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])

-- delete without changing clipboard
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
