return {

    'github/copilot.vim',
    'mattn/emmet-vim',

    "folke/zen-mode.nvim",
    'tpope/vim-unimpaired',
    'tpope/vim-obsession',
    -- 'simeji/winresizer',
    -- 'mbbill/undotree',

    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        },
    },

    -- 'tpope/vim-abolish',
    -- 'tpope/vim-repeat',
    -- 'lervag/vimtex',
    -- {
    --     'JoosepAlviste/nvim-ts-context-commentstring', 
    --     config = function()
    --         require("ts_context_commentstring").setup()
    --     end
    -- },

    -- { 
    --     'numToStr/Comment.nvim', 
    --     lazy = false,  
    --     config = function()
    --         require('Comment').setup ( {
    --             pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    --         } )
    --     end
    -- },

    -- Lua
    
    -- {
    --     "folke/zen-mode.nvim",
    --     opts = {
    --         plugins = {
    --             tmux = { enabled = false },
    --         },
    --
    --     }
    -- },
    -- lazy.nvim
    
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
            "rcarriga/nvim-notify",
        }
    },

    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
        },
    },
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
        end
    },
}
