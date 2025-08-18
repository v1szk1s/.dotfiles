return {
    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.4',

    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
    },

    config = function()
        require('telescope').setup {
            pickers = {
                find_files = {
                    hidden = true
                }
            },
            defaults = {
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                    '--hidden' -- Add this flag to include dotfiles
                },
                file_ignore_patterns = {
                    "node_modules",
                    "tags",
                    ".git/",
                    ".svn/",
                    "pack",
                }
            }
        }

        pcall(require('telescope').load_extension, 'fzf')

        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search Files' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search Grep' })
        vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[F]ind [G]it' })
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[F]ind [H]elp' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[F]ind current [W]ord' })

        vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = '[G]oto [R]eferences'})
        vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations, { desc = '[G]oto [I]mplementation'})
        vim.keymap.set('n', '<leader>D', require('telescope.builtin').lsp_type_definitions, { desc = 'Type [D]efinition'})
        vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, { desc = '[D]ocument [S]ymbols'})
        vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, { desc = '[W]orkspace [S]ymbols'})

        -- vim.keymap.set('n', '<leader>sk', 'Telescope keymaps<cr>', { desc = '[F]ind [H]elp' })
        -- vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        -- vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
        -- vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })

        vim.keymap.set('n', '<leader>/', function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = '[/] Fuzzily search in current buffer' })

        vim.keymap.set('n', '<leader>s/', function()
            builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            }
        end, { desc = '[S]earch [/] in Open Files' })

    end
}
