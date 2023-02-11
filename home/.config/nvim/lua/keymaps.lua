-- set leader to t key
vim.g.mapleader = "t"

-- New tab and split
vim.keymap.set("n", "<leader>n", ":tabnew<CR>")
vim.keymap.set("n", "<leader>N", ":tab split<CR>")
vim.keymap.set("n", "<leader>i", ":new<CR>")
vim.keymap.set("n", "<leader>I", ":split<CR>")
vim.keymap.set("n", "<leader>s", ":vnew<CR>")
vim.keymap.set("n", "<leader>S", ":vsplit<CR>")

-- split vertically and diff with a file
vim.keymap.set("n", "<leader>d", ":vert diffsplit<SPACE>")

-- Tabs & split navigations
vim.keymap.set("n", "<leader>h", ':tabprevious<CR>')
vim.keymap.set("n", "<leader>l", ':tabnext<CR>')
vim.keymap.set("n", "<leader>j", "<C-w>w")
vim.keymap.set("n", "<leader>k", "<C-W>W")

-- move split line
vim.keymap.set("n", "<S-J>", ":resize +1<CR>")
vim.keymap.set("n", "<S-K>", ":resize -1<CR>")
vim.keymap.set("n", "<S-L>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<S-H>", ":vertical resize -2<CR>")

-- move tabs
vim.keymap.set("n", "<leader>L", ":tabmove +<CR>")
vim.keymap.set("n", "<leader>H", ":tabmove -<CR>")

-- allow multiple indentation/deindentation in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- block visual
vim.keymap.set("n", "<leader>v", "<C-v>")

-- move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- <leader>p toggles paste mode
vim.keymap.set("n", "<leader>p", ":set paste!<BAR>set paste?<CR>")

-- paste while keeping clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])

-- copy into system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])

-- delete without changing clipboard
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- not yet migrated --
-- Show current file (buffer) full path
-- nnoremap <leader>W :call ShowCurrentFilePaths()<CR>
-- " for current visual/selected text, search without moving
-- " https://vim.fandom.com/wiki/Search_for_visually_selected_text#Readable_equivalent
-- " https://vim.fandom.com/wiki/Highlight_all_search_pattern_matches#Highlight_matches_without_moving
-- vnoremap <silent> / :call setreg("/",
--     \ substitute(<SID>getSelectedText(),
--     \ '\_s\+',
--     \ '\\_s\\+', 'g')
--     \ )<CR>:set hlsearch<CR>
-- " Search and replace for selected text
-- vnoremap <leader>r :<C-U>
--   \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
--   \gvy/<C-R><C-R>=substitute(
--   \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
--   \gV:call setreg('"', old_reg, old_regtype)<CR>
--   \:%s//

-- plugins --
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>")
vim.keymap.set("n", "<leader>gs", ":Gdiffsplit<CR>")

local telescopeBuiltin = safe_require('telescope.builtin')
if telescopeBuiltin ~= false then
  vim.keymap.set(
    "n",
    "<leader>t",
    ":Telescope file_browser<CR>", -- TODO: make it remember last cwd
    {}
  )
  vim.keymap.set(
    "n",
    "<leader>w",
    "<cmd>lua require 'telescope'.extensions.file_browser.file_browser({ path = vim.fn.expand(vim.fn.expand('%:p:h'))  })<CR>",
    {}
  )
  vim.keymap.set('n', '<leader>ff', function()
    if table.getn(vim.fs.find(".git", { type = "directory", upward = true })) > 0 then
      telescopeBuiltin.git_files()
    else
      telescopeBuiltin.find_files()
    end
  end, {})
  vim.keymap.set('n', '<leader>fF', function()
    telescopeBuiltin.find_files({ hidden = true, no_ignore = true, no_ignore_parent = true })
  end, {})
  vim.keymap.set('n', '<leader>fg', telescopeBuiltin.live_grep, {})
  vim.keymap.set('n', '<leader>fb', telescopeBuiltin.buffers, {})
  vim.keymap.set('n', '<leader>fh', telescopeBuiltin.help_tags, {})
end
