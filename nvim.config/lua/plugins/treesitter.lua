local check_file_size = function(_, bufnr)
    return vim.api.nvim_buf_line_count(bufnr) > 100000
end

return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    init = function(plugin)
        require('lazy.core.loader').add_to_rtp(plugin)
        require 'nvim-treesitter.query_predicates'
    end,

    configs = function ()
        require('nvim-treesitter.configs').setup {
            auto_install = true,
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    -- init_selection = '<c-space>',
                    -- node_incremental = '<c-space>',
                    -- scope_incremental = '<c-s>',
                    -- node_decremental = '<M-space>',
                },
            },
            -- textobjects = {
            --     select = {
            --         enable = true,
            --         lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            --         keymaps = {
            --             -- You can use the capture groups defined in textobjects.scm
            --             ['aa'] = '@parameter.outer',
            --             ['ia'] = '@parameter.inner',
            --             ['af'] = '@function.outer',
            --             ['if'] = '@function.inner',
            --             ['ac'] = '@class.outer',
            --             ['ic'] = '@class.inner',
            --         },
            --     },
            -- },
        }
    end,
    main = 'nvim-treesitter.configs',
    opts = {
        ensure_installed = {
            -- 'lua',
            -- 'query',
            -- 'markdown',
            -- 'markdown_inline',
            -- 'javascript',
            -- 'jsdoc',
            -- 'typescript',
            -- 'tsx',
            -- 'json',
            -- 'html',
            -- 'graphql',
            -- 'vue',
            -- 'yaml',
            -- 'css',
            -- 'bash',
            -- 'scss',
            -- 'vim',
            -- 'vimdoc',
            -- 'sql',
            -- 'regex',
            -- 'svelte',
        },
        highlight = {
            enable = true,
            disable = check_file_size,
        },
        indent = {
            enable = true,
        },
    },
}

