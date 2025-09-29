vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set('n', '<leader>sa', 'ggVG"+y', { silent = true })

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set("n", "<c-n>", ":let @z=expand('%:t') | Ex<cr>/<c-r>z<cr>", {silent = true})

vim.keymap.set('i', '{<CR>', '{<CR>}<C-o>O')

vim.keymap.set('n', '<leader>sf', ':e **/')
vim.keymap.set('n', '<leader>sg', ':vim \'\' **|copen<left><left><left><left><left><left><left><left><left><left>')

vim.keymap.set("n", "c*", "*``cgn")
vim.keymap.set("n", "c#", "#``cgN")

vim.keymap.set("n", "<leader>,", ":diffget //2<CR>", {silent = true})
vim.keymap.set("n", "<leader>.", ":diffget //3<CR>", {silent = true})

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("n", "<leader>d", '[["_d]]')

vim.keymap.set("n", "Q", "@q")

vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("i", "<CR>", function()
  return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
end, { expr = true })

-- vim.keymap.set("n", "<leader>w", ":w<cr>")
-- vim.keymap.set("n", "<leader>q", ":x<cr>", { silent = true})


-- -- Autocmd for fugitive buffers
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "fugitive",
--   callback = function()
--     -- Buffer-local mappings
--     vim.keymap.set("n", "gh", ":diffget //2<CR>", { buffer = true, desc = "Take left side of diff" })
--     vim.keymap.set("n", "gl", ":diffget //3<CR>", { buffer = true, desc = "Take right side of diff" })
--   end,
-- })
--
