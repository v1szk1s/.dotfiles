vim.pack.add({
    'https://www.github.com/nvim-telescope/telescope-fzf-native.nvim',
    'https://www.github.com/nvim-telescope/telescope.nvim',
})

require("telescope").setup({
  pickers = {
    find_files = {
      hidden = true,
      find_command = {
        "fd", "--type", "f", "--strip-cwd-prefix",
        "-I",
        "--hidden",
        "--exclude", ".git",
        "--exclude", "node_modules",
        "--exclude", "dist",
        "--exclude", "build",
      },
    },
  },
  defaults = {
    vimgrep_arguments = {
      "rg", "--color=never", "--no-heading", "--with-filename",
      "--line-number", "--column", "--smart-case",
      "--hidden", "--no-follow",
      "--glob", "!**/.git/*",
      "--glob", "!**/node_modules/*",
      "--glob", "!**/dist/*",
      "--glob", "!**/build/*",
      "--glob", "!*.lock",
    },
  },
})

-- 4) Load extension safely (will work once built)
pcall(require("telescope").load_extension, "fzf")

-- 5) Keymaps (unchanged)
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search Files" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search Grep" })
vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "[F]ind [G]it" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[F]ind current [W]ord" })

vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "[G]oto [R]eferences" })
vim.keymap.set("n", "gI", builtin.lsp_implementations, { desc = "[G]oto [I]mplementation" })
vim.keymap.set("n", "<leader>D", builtin.lsp_type_definitions, { desc = "Type [D]efinition" })
vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
vim.keymap.set("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols, { desc = "[W]orkspace [S]ymbols" })

vim.keymap.set("n", "<leader>/", function()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>s/", function()
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end, { desc = "[S]earch [/] in Open Files" })
