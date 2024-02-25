return {
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },

    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
        -- See `:help ibl`
        main = 'ibl',
        opts = {},
    },

    {
        'numToStr/Comment.nvim',
        keys = {
            { 'gc', mode = { 'n', 'v' }, 'gcc' },
        },
        opts = {
            pre_hook = function(ctx)
                return require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()(ctx)
            end,
        },
    },

    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        ft = { 'typescriptreact' },
        opts = {
            enable_autocmd = false,
        },
    },

}
