vim.pack.add({
    'https://www.github.com/L3MON4D3/LuaSnip',
    'https://www.github.com/saghen/blink.cmp',
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local spec = ev.data.spec
    local name = spec and spec.name
    local kind = ev.data.kind
    local path = ev.data.path

    if name == "LuaSnip" and (kind == "install" or kind == "update") then
      if vim.fn.executable("make") ~= 1 then
        vim.notify("LuaSnip: make not found; cannot install_jsregexp", vim.log.levels.WARN)
        return
      end

      vim.notify("LuaSnip: running make install_jsregexp in " .. path)
      vim.system({ "make", "install_jsregexp" }, { cwd = path }, function(res)
        vim.schedule(function()
          vim.notify(
            ("LuaSnip: install_jsregexp exit=%d\n%s\n%s"):format(
              res.code, res.stdout or "", res.stderr or ""
            ),
            res.code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
          )
        end)
      end)
    end
  end,
})

-- local function pack_hooks(ev)
--   local name = ev.data.spec.name
--   local kind = ev.data.kind
--
--   if name == "LuaSnip" and (kind == "install" or kind == "update") then
--     if vim.fn.executable("make") == 1 then
--       vim.system({ "make install_jsregexp" }, { cwd = ev.data.path })
--     end
--   end
-- end
--
-- vim.api.nvim_create_autocmd("PackChanged", { callback = pack_hooks })

require('blink-cmp').setup({
    keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <c-y> to accept ([y]es) the completion.
      --    This will auto-import if your LSP supports it.
      --    This will expand snippets if the LSP sent a snippet.
      -- 'super-tab' for tab to accept
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- For an understanding of why the 'default' preset is recommended,
      -- you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      preset = 'default',

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },

    snippets = { preset = 'luasnip' },

    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    -- See :h blink-cmp-config-fuzzy for more information
    fuzzy = { implementation = 'lua' },
    signature = { enabled = true },
  })
