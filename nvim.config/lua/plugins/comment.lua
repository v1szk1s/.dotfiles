return {
    {
        'numToStr/Comment.nvim',
        opts = {
            pre_hook = function(ctx)
                return require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()(ctx)
            end,
        },
        config = function()
            require('Comment').setup()
            vim.keymap.set({'n'}, '<c-_>', function()
                return vim.v.count == 0
                    and '<Plug>(comment_toggle_linewise_current)'
                    or '<Plug>(comment_toggle_linewise_count)'
            end, { noremap = true, expr = true })

            vim.keymap.set('x', '<c-_>', '<Plug>(comment_toggle_linewise_visual)')
        end,
    },

    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        ft = { 'typescriptreact' },
        opts = {
            enable_autocmd = false,
        },
    },

}
