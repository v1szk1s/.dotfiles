vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- for emmet
vim.cmd("imap ,, <C-y>,")
vim.cmd("vmap ,, <C-y>,")

vim.keymap.set("n", "<c-p>", ":let @z=expand('%:t') | Ex<cr>/<c-r>z<cr>", {silent = true})

vim.keymap.set("n", "]q", ":cn<cr>", {silent = true})
vim.keymap.set("n", "[q", ":cp<cr>", {silent = true})

vim.keymap.set('i', '{<CR>', '{<CR>}<C-o>O')

vim.keymap.set('n', '<leader>sf', ':e **/')
vim.keymap.set('n', '<leader>sg', ':vim \'\' **|copen<left><left><left><left><left><left><left><left><left><left>')

vim.keymap.set("n", "c*", "*``cgn")
vim.keymap.set("n", "c#", "#``cgN")
-- vim.keymap.set("nnoremap <leader>X #``cgN")

vim.keymap.set("n", "<leader>,", ":diffget //2<CR>", {silent = true})


vim.keymap.set("n", "<leader>,", ":diffget //2<CR>", {silent = true})
vim.keymap.set("n", "<leader>.", ":diffget //3<CR>", {silent = true})

vim.keymap.set("n", "\\", "za", {silent = true}) -- fold

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })


-- vim.keymap.set({"n", "v"}, "j", "gj")
-- vim.keymap.set({"n", "v"}, "k", "gk")


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {silent = true}) -- move vselected line up and down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {silent = true})


-- vim.keymap.set("n", "<C-d>", "Lzz") -- cursor stays the same place when goind down or up
-- vim.keymap.set("n", "<C-u>", "Hzz")

-- vim.keymap.set("n", "J", "mzJ`z")
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")


vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<leader>d", '[["_d]]')
-- vim.keymap.set("n", "<leader>=", "mz[[=]]`z")


-- vim.keymap.set("n", "<s-h>", "gT")
-- vim.keymap.set("n", "<s-l>", "gt")

-- vim.keymap.set("n", "<leader>ra", ":%s/")
-- vim.keymap.set("n", "<leader>rl", ":s/")

vim.keymap.set("n", "Q", "<nop>")
--vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", ":!chmod +x %<CR>", { silent = true })


vim.keymap.set("n", "<leader>w", ":w<cr>")

vim.keymap.set("n", "<leader>q", ":x<cr>", { silent = true})

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")


-- vim.keymap.set("n", "<leader>pv", ":Ex<cr>")
-- vim.keymap.set("i", "$%", "<% %><esc>hhi") -- ejs wonder


vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', ']e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '[e', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


-- vim.keymap.set('n', '<leader>z', function()
--     vim.cmd('ZenMode')
--     if vim.o.laststatus == 0 then
--         vim.o.ls = 2
--         vim.o.ch = 1
--         vim.cmd('silent !tmux set status on')
--     else
--         vim.o.ls = 0
--         vim.o.ch = 0
--         vim.cmd('silent !tmux set status off')
--     end
-- end)

