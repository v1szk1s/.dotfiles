vim.pack.add({
	"https://www.github.com/saghen/blink.lib",
	"https://www.github.com/saghen/blink.cmp",
	"https://www.github.com/L3MON4D3/LuaSnip",
})
local cmp = require("blink.cmp")
cmp.build():wait(60000)

cmp.setup({

	keymap = {
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide", "fallback" },
		-- ['<return>'] = { 'select_and_accept', 'fallback' },
		["<c-y>"] = { "select_and_accept", "fallback" },
		["<cr>"] = { "accept", "fallback" },

		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback_to_mappings" },
		["<C-n>"] = { "select_next", "fallback_to_mappings" },

		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },

		["<c-l>"] = { "snippet_forward", "fallback" },
		["<c-h>"] = { "snippet_backward", "fallback" },

		["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
	},

	appearance = {
		nerd_font_variant = "mono",
	},

	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		ghost_text = { enabled = true },
	},

	sources = {
		default = { "lsp", "path", "snippets", "lazydev", "buffer" },
		providers = {
			lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
		},
	},
	cmdline = {
		keymap = { preset = "default" },
		completion = { menu = { auto_show = true } },
	},

	snippets = { preset = "luasnip" },

	fuzzy = { implementation = "rust" },
	signature = { enabled = true },
})
