-- set leader to t key
vim.g.mapleader = "t"

-- New tab
vim.keymap.set("n", "<leader>n", ":tabnew<CR>")
vim.keymap.set("n", "<leader>N", ":tab split<CR>")

-- split
vim.keymap.set("n", "<leader>i", ":split<CR>")
vim.keymap.set("n", "<leader>I", ":new<CR>")
vim.keymap.set("n", "<leader>s", ":vsplit<CR>")
vim.keymap.set("n", "<leader>S", ":vnew<CR>")

-- split vertically and diff with a file
vim.keymap.set("n", "<leader>D", ":vert diffsplit<SPACE>")

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

-- search current word in normal mode
-- just type "*" for next, "#" for prev
-- "*" can also be used to search selected texts
--   but some characters are not allowed

-- replace current selected (ref: https://stackoverflow.com/a/676619)
vim.keymap.set("v", "<leader>r", [["hy:%s/<C-r>h//gc<left><left><left>]])

-- Show current file (buffer) path and full path
local show_current_path = function()
  local fullpath = vim.fn.expand('%:p')
  local cwd = vim.fn.getcwd()
  local fileInCwd = fullpath:match(cwd)
  if fileInCwd == nil then
    vim.ui.input({
      prompt =
        "Showing current file (buffer) full paths (outside of cwd), press enter to continue:\n" ..
        fullpath .. "\n"
    }, function() end)
  else
    vim.ui.input({
      prompt =
        "Showing current file (buffer) paths, press enter to continue:\n" ..
        fullpath .. "\n" ..
        fullpath:sub(cwd:len() + 2) .. "\n"
    }, function() end)
  end
end
vim.keymap.set("n", "<leader>W", function()
  pcall(show_current_path) -- wrap show_current_path to prevent <C-c> cancel error
end)

-- jumping back and forth after jumping definitions
-- * `<C-o>` to go back
-- * `<C-i>` to go forth
-- `i` and `o` are next to each other ;)
