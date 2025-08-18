return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000 , config = true,
		opts = {}
	},
	"rebelot/kanagawa.nvim",
	"catppuccin/nvim",
	"rose-pine/neovim", name = "rose-pin",
	{
		'projekt0n/github-nvim-theme',
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require('github-theme').setup({
			})

			vim.cmd('colorscheme rose-pine')
			-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		end,
	},
	{
		"folke/tokyonight.nvim",
		-- lazy = false, -- make sure we load this during startup if it is your main colorscheme
		-- priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
		end,
	},
}
