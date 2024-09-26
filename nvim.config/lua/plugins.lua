return {
    -- 'kmonad/kmonad-vim',
    -- 'github/copilot.vim',


    -- 'tpope/vim-sleuth', -- Automatically set the 'shiftwidth' and 'expandtab' options
    'tpope/vim-abolish', -- better replace
    'tpope/vim-surround',
    'tpope/vim-repeat', -- to be able to repeat surround
    'tpope/vim-unimpaired', -- Pairs of handy bracket mappings
    'tpope/vim-eunuch',
    -- 'tpope/vim-dispatch',
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
    {
        "folke/zen-mode.nvim",
        opts = {
            plugins = {
                tmux = { enabled = false },
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
                routes = {
                    {
                        filter = {
                            event = "lsp",
                            kind = "progress",
                            cond = function(message)
                                local client = vim.tbl_get(message.opts, "progress", "client")
                                return client == "lua_ls" or client == "pylsp"
                            end,
                        },
                        opts = { skip = true },
                    },
                },
            })
        end
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
