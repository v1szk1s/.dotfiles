require("plugin_hooks").setup()

vim.pack.add({
	"https://github.com/tpope/vim-unimpaired",
	"https://www.github.com/folke/zen-mode.nvim",
	"https://www.github.com/tpope/vim-abolish", -- better replace
	"https://www.github.com/tpope/vim-fugitive", -- manage git
	-- 'https://www.github.com/tpope/vim-sleuth', -- This plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file...
	"https://www.github.com/tpope/vim-surround",
	"https://www.github.com/tpope/vim-repeat", -- to be able to repeat surround
	"https://www.github.com/stevearc/oil.nvim",
	"https://www.github.com/mattn/emmet-vim",
	-- 'https://www.github.com/lervag/vimtex',
	"https://www.github.com/mbbill/undotree",
	"https://www.github.com/nvim-lua/plenary.nvim",
	"https://www.github.com/folke/lazydev.nvim",
	{
		src = "https://www.github.com/ThePrimeagen/harpoon",
		version = "harpoon2",
	},
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
})

require("treesitter-context").setup({
	enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
	multiwindow = false, -- Enable multiwindow support.
	max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
	min_window_height = 1, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
	line_numbers = true,
	multiline_threshold = 2, -- Maximum number of lines to show for a single context
	trim_scope = "inner", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
	mode = "topline", -- Line used to calculate context. Choices: 'cursor', 'topline'
	-- Separator between context and content. Should be a single character string, like '-'.
	-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
	separator = nil,
	zindex = 20, -- The Z-index of the context window
	on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
})
vim.keymap.set("n", "[c", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

-- oil
require("oil").setup({
	skip_confirm_for_simple_edits = true,
	view_options = {
		show_hidden = true,
	},
})
vim.keymap.set("n", "<c-n>", ":Oil<cr>", { silent = true })

-- fugitive

vim.keymap.set("n", "<c-g>", function()
	vim.cmd("Git | only")
end)
vim.keymap.set({ "n", "v" }, "<leader>gh", ":diffget //2<cr>")
vim.keymap.set({ "n", "v" }, "<leader>gl", ":diffget //3<cr>")

-- emett
vim.g.user_emmet_leader_key = "<C-q>"
vim.cmd("imap ,, <C-q>,")
vim.cmd("vmap ,, <C-q>,")

-- vimtex
vim.g.vimtex_view_method = "zathura"

-- undotree
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>")

-- colorizer

-- load plugins from plugins dir
local plugins = vim.api.nvim_get_runtime_file("lua/plugins/*.lua", true)
for _, file in ipairs(plugins) do
	pcall(require, file:match(".*/lua/(.+)%.lua$"):gsub("/", "."))
end
