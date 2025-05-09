vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
     local bufnr = args.buf

    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end
      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    -- LSP core actions
    nmap('<leader>r', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    -- Diagnostics
    nmap("<leader>vd", function() vim.diagnostic.open_float() end, 'Open diagnostic float')
    nmap("[d", function() vim.diagnostic.goto_next() end, 'Go to next diagnostic message')
    nmap("]d", function() vim.diagnostic.goto_prev() end, 'Go to previous diagnostic message')
    nmap(']e', function() vim.diagnostic.open_float() end, 'Open floating diagnostic message')
    nmap('[e', function() vim.diagnostic.setloclist() end, 'Open diagnostics list')

    -- Navigation
    nmap("gd", vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

    -- Symbols
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- Docs
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  end,
})

vim.diagnostic.config({
  virtual_text = true,  -- or a table with options like { spacing = 4, prefix = "●" }
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.lsp.enable({'clangd', 'lua_ls'})
