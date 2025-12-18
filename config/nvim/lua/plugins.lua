vim.pack.add({
    'https://www.github.com/tpope/vim-abolish', -- better replace
    'https://www.github.com/tpope/vim-fugitive',  -- manage git
    'https://www.github.com/tpope/vim-sleuth', -- This plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file...
    'https://www.github.com/tpope/vim-surround',
    'https://www.github.com/tpope/vim-repeat', -- to be able to repeat surround
    'https://www.github.com/stevearc/oil.nvim',
    'https://www.github.com/mattn/emmet-vim',
    -- 'https://www.github.com/lervag/vimtex',
    'https://www.github.com/mbbill/undotree',
    'https://www.github.com/norcalli/nvim-colorizer.lua',
    'https://www.github.com/nvim-lua/plenary.nvim',
    'https://www.github.com/folke/lazydev.nvim',
    {
      src = 'https://www.github.com/ThePrimeagen/harpoon',
      version = 'harpoon2'
    },
})

-- oil
require("oil").setup({
    skip_confirm_for_simple_edits = true,
    view_options = {
        show_hidden = true,
    },
})
vim.keymap.set("n", "<c-n>", ":Oil<cr>", {silent = true})

-- fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
vim.keymap.set({"n", "v"}, "<leader>gh", ":diffget //2<cr>");
vim.keymap.set({"n", "v"}, "<leader>gl", ":diffget //3<cr>");

-- emett
vim.g.user_emmet_leader_key='<C-q>'
vim.cmd("imap ,, <C-q>,")
vim.cmd("vmap ,, <C-q>,")

-- vimtex
vim.g.vimtex_view_method = 'zathura'

-- undotree
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>");

-- colorizer

-- load plugins from plugins dir
local plugins = vim.api.nvim_get_runtime_file("lua/plugins/*.lua", true)
for _, file in ipairs(plugins) do
    pcall(require, file:match(".*/lua/(.+)%.lua$"):gsub('/', '.'))
end
