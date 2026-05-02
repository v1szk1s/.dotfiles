vim.cmd.colorscheme("default")

local keyword_fg = "#5f87ff"
-- local function_fg = "#ffd75f"
--
local function apply()
	vim.api.nvim_set_hl(0, "Keyword", { fg = keyword_fg })
	-- vim.api.nvim_set_hl(0, "Function", { fg = function_fg })
end

-- local function apply()
-- 	-- vim.api.nvim_set_hl(0, "Keyword", { fg = "#5f87ff" })
-- 	-- vim.api.nvim_set_hl(0, "Keyword", { fg = "#05824b" })
-- 	vim.api.nvim_set_hl(0, "Keyword", { fg = "#5fafaf" })
-- end

apply()

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "default-keyword",
	callback = apply,
})
