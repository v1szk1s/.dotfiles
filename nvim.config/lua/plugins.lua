return {
    'github/copilot.vim',
    'mattn/emmet-vim',
    'tpope/vim-sleuth',

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
        'tpope/vim-unimpaired', -- Pairs of handy bracket mappings
        event = "VeryLazy",
    },
    -- 'tpope/vim-abolish',
    -- 'tpope/vim-repeat',
    -- 'lervag/vimtex',

    {
        'tpope/vim-fugitive',

        keys = {
            { "<leader>gs", "<cmd>Git<cr>", desc = "Git" },
        },
        -- config = function()
        --     vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
        -- end
    },

    {
        'mbbill/undotree',
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
        },
    },

    -- {
    --     'norcalli/nvim-colorizer.lua',
    --     event = "VeryLazy",
    --     config = function()
    --         require('colorizer').setup()
    --     end
    --
    -- },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
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

        keys = {
            { "<leader>mh", "<cmd>NoiceTelescope<cr>", desc = "Noice Telescope" },
        },
        config = function ()
            require("noice").setup({
                -- cmdline = {
                --     format = {
                --         search_down = {
                --             view = "cmdline",
                --         },
                --         search_up = {
                --             view = "cmdline",
                --         },
                --     },
                -- },
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
    { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- config = function()
            --     require('mason').setup()
            --     require('mason-lspconfig').setup()
            -- end,
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
        },
    },
}
