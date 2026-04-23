vim.pack.add({
  'https://github.com/stevearc/conform.nvim',
})

require("conform").setup({
  formatters_by_ft = {
    javascript      = { "oxfmt" },
    javascriptreact = { "oxfmt" },
    typescript      = { "oxfmt" },
    typescriptreact = { "oxfmt" },
    json            = { "oxfmt" },
    css             = { "oxfmt" },
    html            = { "oxfmt" },
    lua             = { "stylua" },  -- keep stylua for lua
    rust = { "rustfmt" },
  },
  format_on_save = {
    async = false,
    timeout_ms = 2000,
  },
})
