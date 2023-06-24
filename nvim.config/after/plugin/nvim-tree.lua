-- disable netrw at the very start of your init.lua (strongly advised)

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true


-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  hijack_directories = {
      enable = true,
      auto_open = true,
  },
  renderer = {
    group_empty = false,
  },
  filters = {
    dotfiles = false,
  },
})

api = require("nvim-tree.api")

vim.keymap.set("n", "<C-n>", function()
    api.tree.toggle { find_file = true, focus = true };
end)
