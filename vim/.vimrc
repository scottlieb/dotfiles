" Plugins
" -------

call plug#begin()

" Better C/C++ syntax highlighting
Plug 'bfrg/vim-c-cpp-modern'

" Insert/delete brackets, quotes, etc. in pairs
Plug 'jiangmiao/auto-pairs'

" Status-line
Plug 'itchyny/lightline.vim'

" Colourscheme
Plug 'jeffkreeftmeijer/vim-dim'

call plug#end()

" Colourscheme / Status-Line
" --------------------------

set background=light
colorscheme dim " follows terminal colorscheme :)
set laststatus=2

" Some syntax-highlighting improvements
highlight Comment cterm=italic
highlight CursorLine cterm=none
highlight CursorLineNr cterm=none ctermbg=DarkMagenta ctermfg=White
highlight Function ctermfg=Cyan
highlight Type ctermfg=DarkBlue
highlight cType ctermfg=DarkRed
highlight Structure ctermfg=DarkRed
highlight Visual ctermfg=DarkMagenta ctermbg=none
highlight ColorColumn ctermbg=White
highlight String ctermfg=Green
highlight Constant ctermfg=Magenta

" full path in status-line
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
      \ },
      \ 'colorscheme': 'seoul256'
      \ }

" Editor Settings
" ---------------

set ttimeoutlen=5

set nocompatible
set title
set number
set relativenumber
set scrolloff=10
set colorcolumn=120
set cursorline
set signcolumn=number
set nowrap

set path+=**/*

set ignorecase
set smartcase

set tabstop=8
set softtabstop=4
set shiftwidth=4
set copyindent
set smarttab
set autoindent
set smartindent
filetype plugin indent on

let &t_SI = "\<esc>[5 q"  " blinking I-beam in insert mode
let &t_SR = "\<esc>[3 q"  " blinking underline in replace mode
let &t_EI = "\<esc>[ q"  " default cursor (usually blinking block) otherwise

" Use ';' to run commands
noremap ; :
