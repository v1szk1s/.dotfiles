return {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',

    config = function ()
        local on_attach = function(_, bufnr)
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end
                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end
            nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
            nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

            -- nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
            -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
            -- nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
            -- nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
            -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
            -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
            nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
            nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
        end

        require('mason').setup()
        require('mason-lspconfig').setup()
        -- require('neodev').setup()

        local servers = {
            clangd = {
                -- init_options = {
                -- },
            },
            gopls = {},
            pyright = {},
            -- rust_analyzer = {},
            tsserver = {},
            html = { filetypes = { 'html', 'twig', 'hbs'} },
            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {'vim'},
                    },
                },
            },
        }

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        -- require('luasnip.loaders.from_vscode').lazy_load()

        -- require("luasnip.loaders.from_lua").load({paths = "snippets"})
        -- Ensure the servers above are installed
        local mason_lspconfig = require 'mason-lspconfig'

        mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(servers),
        }

        mason_lspconfig.setup_handlers {
            function(server_name)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                }
            end,
        }

        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                -- Enable underline, use default values
                underline = false,
                -- Enable virtual text, override spacing to 4
                virtual_text = true,
                {
                    spacing = 20,
                },
                -- Use a function to dynamically turn signs off
                -- and on, using buffer local variables
                --
                -- signs = function(namespace, bufnr)
                --     return vim.b[bufnr].show_signs == true
                -- end,
                --
                -- Disable a feature
                update_in_insert = false,
            }
        )
    end,

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
        -- 'folke/neodev.nvim',
    },
}
