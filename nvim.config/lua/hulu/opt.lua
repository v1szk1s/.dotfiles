--vim.o.guicursor = ""

vim.cmd("filetype plugin indent on")
vim.o.syntax = "enable"

-- vim.o.clipboard = 'unnamedplus'
vim.opt.breakindent = true

vim.o.lz = false

vim.opt.splitright = true
vim.opt.splitbelow = false

vim.opt.list = false

-- vim.opt.listchars= {tab = "> ",trail = " ",multispace = ". ", lead = " ", extends="▶",precedes="◀",nbsp= "‿" }
vim.opt.listchars= {tab = "> ",trail = ".",multispace = ".", lead = " ", extends=">",precedes="<",nbsp= "_" }

vim.o.foldmethod = "indent"
vim.o.foldlevel = 99

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

vim.o.expandtab = false
vim.o.smartindent = true

vim.o.wrap = false
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
vim.o.signcolumn = "yes"
--vim.o.isfname:append("@-@")

vim.o.updatetime = 350
vim.o.timeoutlen = 500

-- vim.o.completeopt = 'menuone'
-- vim.o.colorcolumn = "180"


local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "Recording @" .. recording_register
    end
end

































