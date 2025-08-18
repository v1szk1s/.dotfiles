vim.lsp.enable({'clangd', 'lua_ls', 'tsserver', 'gopls'})


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
    nmap(']e', function() vim.diagnostic.open_float() end, 'Open floating diagnostic message')
    nmap('[e', function() vim.diagnostic.setloclist() end, 'Open diagnostics list')

    -- Navigation
    nmap("gd", vim.lsp.buf.definition, '[G]oto [D]efinition')

    -- Docs
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    vim.keymap.set('n', '<leader>td', function()
      Diagnostics_enabled = not Diagnostics_enabled
      vim.diagnostic.enable(Diagnostics_enabled)
      print("Diagnostics " .. (Diagnostics_enabled and "enabled" or "disabled"))
    end, { desc = 'Toggle diagnostics' })


  end,
})

vim.diagnostic.config({
  virtual_text = true,  -- or a table with options like { spacing = 4, prefix = "●" }
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
