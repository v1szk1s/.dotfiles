return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },

  -- Detect the project root the same way "gopls" does.
  -- root_dir = function(fname)
  --   return vim.fs.dirname(
  --     vim.fs.find({ 'go.work', 'go.mod', '.git' }, { upward = true })[1]
  --   ) or vim.fs.dirname(fname)
  -- end,

  settings = {
    gopls = {
      completeUnimported = true,
      analyses = {
        unusedparams  = true,
        unreachable   = true,
      },
      staticcheck = true,
    },
  },
}
