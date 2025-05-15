return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_dir = vim.fs.root(0, {
    "package.json",
    "tsconfig.json",
    ".git",
  }),
  settings = {},
}
