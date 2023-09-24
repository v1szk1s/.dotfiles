return {
    'rstacruz/vim-closer',
    'tpope/vim-endwise',
    'mattn/emmet-vim',
    'tpope/vim-abolish',
    --    'tpope/vim-repeat',
    --'tpope/vim-unimpaired',
    'lervag/vimtex',

    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.1',
        -- or                            , branch = '0.1.x',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },
    --
    -- { 'catppuccin/nvim',       name = 'catppuccin' },
    --    { 'folke/tokyonight.nvim', name = 'tokyonight' },
    {
        'mbbill/undotree',
        conf = function()
            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
        end
    },
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
        end
    },
    'tpope/vim-commentary',
    --    'tpope/vim-surround',
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
    --
    {
        "ziontee113/color-picker.nvim",
        config = function()
            require("color-picker")
        end,
    },
    --
    {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    },
    --
}
