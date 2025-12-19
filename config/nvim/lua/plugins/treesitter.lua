vim.pack.add({
  {
    src = "https://www.github.com/nvim-treesitter/nvim-treesitter",
    version = "master",
  },
  'https://www.github.com/nvim-treesitter/nvim-treesitter-textobjects',
})

require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "html" },
  sync_install = false,
  auto_install = true;
  highlight = { enable = true },
  indent = { enable = true },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
})
