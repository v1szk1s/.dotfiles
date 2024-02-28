--vim.o.guicursor = ""

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 0
vim.g.netrw_preview = 1






vim.o.foldmethod = "indent"
vim.o.foldlevel = 10

function _G.custom_fold_text()
    local line = vim.fn.getline(vim.v.foldstart)
    local line_count = vim.v.foldend - vim.v.foldstart + 1
    return "|-- " .. line:gsub("%s+", "") .. ": " .. line_count .. " lines"

end

vim.opt.foldtext = 'v:lua.custom_fold_text()'

vim.opt.fillchars = { eob = "-", fold = " " }

vim.opt.viewoptions:remove("options")

vim.o.nu = true
vim.o.relativenumber = true
vim.o.numberwidth = 3

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.smartindent = true

vim.o.wrap = true
vim.o.linebreak = true

vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.autoread = true

vim.o.showmode = false

vim.o.termguicolors = true

vim.o.scrolloff = 8

vim.o.cursorline = true

vim.o.ignorecase = true
vim.o.smartcase = true
-- vim.o.signcolumn = "yes"
--vim.o.isfname:append("@-@")

vim.o.updatetime = 250
vim.o.timeoutlen = 300


vim.o.completeopt = 'menuone,noselect'


--vim.o.colorcolumn = "80"


































