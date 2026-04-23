vim.cmd("filetype plugin indent on")

vim.opt.breakindent = true

vim.opt.lz = false

vim.opt.splitright = true
vim.opt.splitbelow = false

vim.opt.list = false

-- vim.opt.listchars= {tab = "> ",trail = " ",multispace = ". ", lead = " ", extends="▶",precedes="◀",nbsp= "‿" }
vim.opt.listchars= {tab = "> ",trail = ".",multispace = ".", lead = " ", extends=">",precedes="<",nbsp= "_" }

-- Use Tree-sitter for folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Quality-of-life defaults
vim.opt.foldlevel = 99      -- open most folds by default
vim.opt.foldlevelstart = 99 -- keep them open when opening a file

-- vim.o.foldmethod = "indent"
-- vim.o.foldlevel = 20

vim.opt.fillchars = { eob = "-", fold = " " }

vim.opt.viewoptions:remove("options")

vim.o.nu = true
vim.o.relativenumber = true
vim.o.numberwidth = 3

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

vim.o.expandtab = true
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

vim.o.cursorline = false

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
--vim.o.isfname:append("@-@")

vim.o.updatetime = 350
vim.o.timeoutlen = 500

-- vim.opt.completeopt:append({ "menuone", "noselect", "popup" })
vim.opt.completeopt = { "menuone", "noinsert" }

-- vim.o.colorcolumn = "180"
