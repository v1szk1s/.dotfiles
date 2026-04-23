local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 25,
        })
    end,
})


local auto_format = augroup('AutoFormat', {})

autocmd('BufWritePost', {
    pattern = "*.go",
    group = auto_format,
    callback = function()
        vim.lsp.buf.format()
    end
})
