require("hulu.set")
require("hulu.remap")

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        dofile(os.getenv("DOTFILES") .. "/nvim.config/lua/hulu/remap.lua")
    end,
})
