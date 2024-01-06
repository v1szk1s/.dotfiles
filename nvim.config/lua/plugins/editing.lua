return {
    -- 'tpope/vim-endwise',
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    {
        'ggandor/leap.nvim',
        config = function()
            require('leap').set_default_keymaps()
        end,
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
