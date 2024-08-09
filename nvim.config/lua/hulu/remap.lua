vim.g.mapleader = " "
vim.g.maplocalleader = ","

function _G.toggle_html_comment()
    local current_line = vim.fn.getline('.')
    local is_commented = current_line:match('^%s*<!--.*-->%s*$')
    if is_commented then
        current_line = current_line:gsub("^%s*<!%-%- (.-) %-%->%s*$", "%1")
    else
        current_line = current_line:gsub('^(.*)$', '<!-- %1 -->')
    end
    vim.fn.setline('.', current_line)
end

vim.api.nvim_set_keymap('n', 'gh', ':lua toggle_html_comment()<CR>', { noremap = true, silent = true })


-- vim.keymap.set("n", '<c-m>', ':Dispatch<cr>')

vim.keymap.set('n', '<leader>sa', 'ggVG"+y', { silent = true })

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set("n", "<c-p>", ":let @z=expand('%:t') | Ex<cr>/<c-r>z<cr>", {silent = true})

vim.keymap.set('i', '{<CR>', '{<CR>}<C-o>O')

vim.keymap.set('n', '<leader>sf', ':e **/')
vim.keymap.set('n', '<leader>sg', ':vim \'\' **|copen<left><left><left><left><left><left><left><left><left><left>')

vim.keymap.set("n", "c*", "*``cgn")
vim.keymap.set("n", "c#", "#``cgN")
-- vim.keymap.set("nnoremap <leader>X #``cgN")

vim.keymap.set("n", "<leader>,", ":diffget //2<CR>", {silent = true})
vim.keymap.set("n", "<leader>.", ":diffget //3<CR>", {silent = true})

vim.keymap.set("n", "\\", "za", {silent = true}) -- fold with \


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {silent = true}) -- move vselected line up and down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {silent = true})

vim.keymap.set("n", "J", "mzJ`z") -- so cursor stays 

-- vim.keymap.set("n", "<C-d>", "Lzz") -- cursor stays the same place when goind down or up
-- vim.keymap.set("n", "<C-u>", "Hzz")

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

vim.keymap.set("n", "Q", "@q")
--vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", ":!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>q", ":x<cr>", { silent = true})



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

