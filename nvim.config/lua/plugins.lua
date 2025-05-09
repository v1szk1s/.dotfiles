return {
    -- 'tpope/vim-abolish', -- better replace
    -- 'tpope/vim-eunuch',

    'tpope/vim-sleuth', -- Automatically set the 'shiftwidth' and 'expandtab' options
    'tpope/vim-surround',
    'tpope/vim-repeat', -- to be able to repeat surround
    'tpope/vim-unimpaired', -- Pairs of handy bracket mappings

    -- {
    --         'mrcjkb/rustaceanvim',
    --         version = '^5', -- Recommended
    --         lazy = false, -- This plugin is already lazy
    -- },
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
        end
    },
    {
        'mattn/emmet-vim',
        init = function ()
            vim.g.user_emmet_leader_key='<C-q>'

            vim.cmd("imap ,, <C-q>,")
            vim.cmd("vmap ,, <C-q>,")
         end
    },
    {
        "lervag/vimtex",
        init = function()
            vim.g.vimtex_view_method = 'zathura'
        end
    },
    -- {
    --     "folke/zen-mode.nvim",
    --     opts = {
    --         plugins = {
    --             tmux = { enabled = false },
    --         }
    --     },
    --     keys = {
    --         { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    --     },
    -- },
    {
        'mbbill/undotree',
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
        },
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require 'colorizer'.setup {
                '*'; -- Highlight all files, but customize some others.
                css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
                html = { names = false; } -- Disable parsing "names" like Blue or Gray
            }
        end
    },
}
