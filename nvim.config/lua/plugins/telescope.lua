return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',

    -- branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- Fuzzy Finder Algorithm which requires local dependencies to be built.
        -- Only load if `make` is available. Make sure you have the system
        -- requirements installed.
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            -- NOTE: If you are having trouble with this installation,
            --       refer to the README for telescope-fzf-native for more instructions.
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
                file_ignore_patterns = {
                    "node_modules",
                    "tags",
                    ".git/",
                    "pack",
                }
            }
        }

        local builtin = require('telescope.builtin')



        vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
        -- vim.keymap.set('n', '<leader>fj', builtin.find_files, { desc = '[ FJ] Search Files' })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search Files' })

        -- vim.keymap.set('n', '<leader>fk', builtin.live_grep, { desc = '[ FK] Search Grep' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search Grep' })

        vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[F]ind [G]it' })

        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[F]ind [H]elp' })

        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
        -- vim.keymap.set('n', '<c-f>', builtin.live_grep, { desc = '[S]earch by [G]rep' })
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

        -- vim.keymap.set('n', '<leader>p', function()
        --     -- You can pass additional configuration to telescope to change theme, layout, etc.
        --     require('telescope.builtin').find_files({
        --         find_command = { "find ~/egyetem/6 ~/egyetem ~/projects ~ ~/work ~/personal $DOTFILES ~/playground", "-mindepth 1", "-maxdepth 1", "-type d"}
        --
        --     })
        -- end, { desc = '[/] Fuzzily search in current buffer' })

        vim.keymap.set('n', '<leader>s/', function()
            builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            }
        end, { desc = '[S]earch [/] in Open Files' })

    end
}
