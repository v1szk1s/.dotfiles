return {
    -- 'tpope/vim-endwise',
    {
        'altermo/ultimate-autopair.nvim',
        event = { 'InsertEnter',  'CmdlineEnter' },
        branch = 'v0.6',
        opts = {
            tabout = {
                enable = true,
                hopout = true,
            },
        },
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
