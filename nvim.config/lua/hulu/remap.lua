
vim.g.mapleader = " "


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])


-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])


vim.keymap.set("n", "gp", "gT")

vim.keymap.set("n", "<leader>r", ":%s/")

-- vim.keymap.set("n", "<leader>l", ":vertical resize +7<CR>")
-- vim.keymap.set("n", "<leader>h", ":vertical resize -7<CR>")

vim.keymap.set("n", "Q", "<nop>")
--vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

--vim.keymap.set("n", "<C-c>", "<cmd>cnext<CR>zz")
--vim.keymap.set("n", "<C-v>", "<cmd>cprev<CR>zz")
--vim.keymap.set("n", "<leader>c", "<cmd>lnext<CR>zz")
--vim.keymap.set("n", "<leader>v", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })


vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>q", ":x<cr>")
vim.keymap.set("n", "<leader>Q", ":q!<cr>")

vim.keymap.set("n", "<C-s>", ":w<cr>")
vim.keymap.set("i", "<C-s>", "<esc>:w<cr>a")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<leader>Q", ":q!<cr>")

vim.keymap.set("n", '<leader>"', 'viw<esc>a"<esc>bi"<esc>lel')
vim.keymap.set("n", "<leader>'", "viw<esc>a'<esc>bi'<esc>lel")


vim.keymap.set("n", "<leader>%", ":vsp<cr><c-w>l")
vim.keymap.set("n", "<leader>|", ":sp<cr><c-w>jv")

vim.keymap.set("n", "<leader>t", ":tabnew<cr>")

-- vim.keymap.set("n", "<leader>pv", ":Ex<cr>")

vim.keymap.set("n", "<leader>{", "zfi{")

vim.keymap.set("i", "$%", "<% %><esc>hhi")

-- vim.keymap.set("i", "<c-m>", "<c-x><c-f>")


-- vim.keymap.set("i", "{<cr>", "{<cr>}<esc>O")


vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
