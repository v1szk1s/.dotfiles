require('telescope').setup{ 
  defaults = { 
    file_ignore_patterns = { 
      "node_modules",
      "tags",
    }
  }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-f>', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>g', function() 
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

vim.keymap.set('n', '<C-g>', function() 
	builtin.grep_string();
end)

