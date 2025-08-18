return {
    -- 'tpope/vim-abolish', -- better replace
    -- 'tpope/vim-eunuch',
    -- 'vuciv/golf',

    'tpope/vim-unimpaired', -- Pairs of handy bracket mappings
    'tpope/vim-sleuth', -- This plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file...
    'tpope/vim-surround',
    'tpope/vim-repeat', -- to be able to repeat surround
    {
        'stevearc/oil.nvim',
        init = function()
            require("oil").setup({
                keymaps = {
                    ["l"] = "actions.select",
                    ["h"] = { "actions.parent", mode = "n" },
                },
            })
            vim.keymap.set("n", "<c-n>", ":Oil<cr>", {silent = true})
        end,
    },
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
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },
}
