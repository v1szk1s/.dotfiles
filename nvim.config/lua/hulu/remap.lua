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

vim.keymap.set("n", "\\", "za", {silent = true}) -- fold with \

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<leader>d", '[["_d]]')
-- vim.keymap.set("n", "<leader>=", "mz[[=]]`z")

vim.keymap.set("n", "Q", "@q")

vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>q", ":x<cr>", { silent = true})

-- if cursor on word that is : file.txt:80 gf will go to the 80th line of file.txt
vim.keymap.set('n', 'gf', function()
	local file_line = vim.fn.expand('<cWORD>')
	-- Check if it matches the pattern 'filename:line_number'
	local filename, line = string.match(file_line, "(.+):(%d+)")

	if filename and line then
		-- Convert line to a number
		line = tonumber(line)

		-- Open the file
		vim.cmd('edit ' .. vim.fn.fnameescape(filename))

		-- Go to the specific line
		if line then
			vim.fn.cursor(line, 0)
		end
	else
		-- Fall back to the default gf behavior if no line number is found
		vim.cmd('edit ' .. vim.fn.fnameescape(vim.fn.expand('<cfile>')))
	end
end, { silent = true, noremap = true })
