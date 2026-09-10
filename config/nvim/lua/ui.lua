local augroup = vim.api.nvim_create_augroup

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 25,
		})
	end,
})

require("vim._core.ui2").enable({
	enable = true,
	msg = { -- Options related to the message module.
		---@type 'cmd'|'msg' Default message target, either in the
		---cmdline or in a separate ephemeral message window.
		---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
		---or table mapping |ui-messages| kinds and triggers to a target.
		targets = "cmd",
		dialog = { -- Options related to dialog window.
			height = 0.5, -- Maximum height.
		},
		messagesopt = { -- Options related to msg window.
			timeout = 4000, -- Time a message is visible in the message window.
			maxheight = 0.5, -- Maximum height.
		},
		pager = { -- Options related to message window.
			height = 0.5, -- Maximum height.
		},
	},
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
