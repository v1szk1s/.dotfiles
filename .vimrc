set history=500
let mapleader = ","

" Basic settings
set nocompatible

set ruler
set number
set relativenumber
set numberwidth=3
set wrap
set ignorecase

set hlsearch
set incsearch 

set noerrorbells
set novisualbell

set notimeout
set nottimeout

" fuzzy find vagy mi
set path+=**
set wildmenu



"nerdtree
let NERDTreeShowHidden=1

syntax enable
filetype plugin on

""""""""""""
" Mappings:
""""""""""""

" moving between splits
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" tabs
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>n :tabnext<cr>


nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

nnoremap <space> viwy

"uppercase a word
nnoremap <c-u> viwU

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>rs :source $MYVIMRC<cr>
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

inoremap { {}<esc>i
inoremap ( ()<esc>i
inoremap [ []<esc>i

inoremap jk <esc>

"nerdtree mapping:
nnoremap <leader>t :NERDTree<cr>
nnoremap <leader>f :NERDTreeFocus<CR>

""""""""""
"comments:
"""""""""
autocmd FileType javascript nnoremap <buffer> <leader>c I//<esc>

""""""""""
"comments:
"""""""""



""""""""""
" Plugins
"
""""""""""

call plug#begin()
  Plug 'preservim/nerdtree'
call plug#end()

