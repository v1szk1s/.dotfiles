vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "zh", "10zh")
vim.keymap.set("n", "zl", "10zl")

vim.keymap.set("v", "<leader>jq", "!jq<cr>")

vim.keymap.set("n", "\\", "za", { silent = true })

vim.keymap.set("i", "{<CR>", "{<CR>}<C-o>O")

vim.keymap.set("n", "<leader>gh", ":diffget //2<CR>", { silent = true })
vim.keymap.set("n", "<leader>gl", ":diffget //3<CR>", { silent = true })

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>d", '[["_d]]')

vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>o", function()
	vim.diagnostic.open_float(nil, { focus = false })
end, { desc = "Show line diagnostics" })

vim.keymap.set("n", "\\", "za", { silent = true }) -- fold with \

vim.keymap.set("n", "<leader>cp", function()
	local path = vim.fn.expand("%")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to clipboard')
end, { desc = "Copy relative file path to clipboard" })

vim.keymap.set("n", "<leader>ca", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to clipboard')
end, { desc = "Copy relative file path to clipboard" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

_G.search_first_operator = function(kind)
	-- Yank the region selected by the motion/text object.
	local selection = ({
		char = "`[v`]",
		line = "'[V']",
		block = "`[\22`]", -- Ctrl-V
	})[kind]

	local saved_register = vim.fn.getreginfo('"')
	local saved_selection = vim.o.selection

	vim.o.selection = "inclusive"
	vim.cmd.normal({ args = { selection .. "y" }, bang = true })
	local text = vim.fn.getreg('"')

	vim.fn.setreg('"', saved_register)
	vim.o.selection = saved_selection

	if text == "" then
		return
	end

	-- Search literally, including regex-special characters.
	local pattern = "\\V" .. vim.fn.escape(text, "\\")
	pattern = pattern:gsub("\n", "\\n")
	vim.fn.setreg("/", pattern)

	vim.api.nvim_win_set_cursor(0, { 1, 0 })
	vim.fn.search(pattern, "cW")
end

vim.keymap.set("n", "<leader>f", function()
	vim.go.operatorfunc = "v:lua.search_first_operator"
	return "g@"
end, { expr = true, desc = "Find first occurrence of text object" })
