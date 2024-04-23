return {
    -- 'kmonad/kmonad-vim',
    -- 'github/copilot.vim',


    -- 'tpope/vim-sleuth', -- Automatically set the 'shiftwidth' and 'expandtab' options
    'tpope/vim-surround',
    'tpope/vim-repeat', -- to be able to repeat surround
    'tpope/vim-unimpaired', -- Pairs of handy bracket mappings
    'tpope/vim-eunuch',
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
            -- Use init for configuration, don't use the more common "config".
        end
    },
    {
        "folke/zen-mode.nvim",
        opts = {
            plugins = {
                tmux = { enabled = true },
            }
        },
        keys = {
            { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
        },
    },
    {
        'mbbill/undotree',
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
        },
    },

    {
        "folke/noice.nvim",
        -- event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            -- "rcarriga/nvim-notify",
        },

        config = function ()
            require("noice").setup({
                views = {
                    cmdline_popup = {
                        border = {
                            style = "none",
                            padding = { 0, 0 },
                        },
                        filter_options = {},
                        win_options = {
                            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                        },
                    },
                },
            })
        end
    },
}
