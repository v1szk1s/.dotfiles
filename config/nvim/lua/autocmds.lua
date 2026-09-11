local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 25,
		})
	end,
})

vim.api.nvim_create_autocmd("RecordingEnter", {
	callback = function()
		vim.notify("Recording @" .. vim.fn.reg_recording())
	end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
	callback = function()
		vim.notify("Stopped recording")
	end,
})

_G.Statusline = function()
	local reg = vim.fn.reg_recording()
	local macro = reg ~= "" and (" REC @" .. reg .. " ") or ""
	return macro .. "%f %m%=%l:%c %p%%"
end

vim.o.statusline = "%!v:lua.Statusline()"

vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
	callback = function()
		vim.cmd("redrawstatus")
	end,
})
