" Basic settings
set hidden                 " For tabs
set number relativenumber  " Line numbers
set mouse=a                " Get mouse working
set encoding=utf-8         " Set encoding to utf-8
set cursorline             " Highlights current line
set ignorecase             " Ignore case when matching
set smartcase              " Smart case
set splitbelow splitright  " Splits below and right instead of above and right
set tabstop=2              " 2 spaces for a tab
set softtabstop=2          " See multiple spaces as tabstops
set shiftwidth=2           " Shift indentation with 2 spaces
set smarttab
set expandtab              " Converts tabs to spaces
set autoindent             " Indent new line line the previous
set clipboard+=unnamedplus " Use system clipboard

let mapleader=","

" Tab completions
set wildmode=longest,list,full

" Reopen file at last cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"Plugins
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'takac/vim-hardtime'
Plug 'mhinz/vim-startify'
Plug 'liuchengxu/vim-which-key'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'bfredl/nvim-ipy'
"Plug 'Chiel92/vim-autoformat'
call plug#end()
" CoCplugs: coc-prettier, coc-pairs, coc-tsserver, coc-python, coc-json,
" -coc-html, coc-css

" Color scheme
"set termguicolors          " True colors
syntax on                  " Syntax highlighting
colorscheme gruvbox        " Take colorscheme from terminal
"set background=dark " use dark mode
autocmd BufRead *.py setlocal colorcolumn=80
"highlight ColorColumn ctermbg=0 guibg=lightgrey

" NERDtree settings
nmap <C-f> :NERDTreeToggle<CR>

" Which-key
nnoremap <silent> <leader> :WhichKey '<,>'<CR>

" Navigate between buffers
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-W>l

" CoC
source $HOME/.config/nvim/coc.vim

" Autoformat
" noremap <F3> :Autoformat<CR>
" au BufWrite * :Autoformat
