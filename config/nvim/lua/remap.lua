vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('i', '{<CR>', '{<CR>}<C-o>O')

vim.keymap.set("n", "<leader>gh", ":diffget //2<CR>", {silent = true})
vim.keymap.set("n", "<leader>gl", ":diffget //3<CR>", {silent = true})

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>d", '[["_d]]')

vim.keymap.set("n", "Q", "@q")

vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
