" ###########
" # plugins #
" ###########

call plug#begin()

" fuzzy-finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" LSP Client + Completion (disabled for now)
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Better C/C++ syntax highlighting
Plug 'bfrg/vim-c-cpp-modern'

" Insert/delete brackets, quotes, etc. in pairs
Plug 'jiangmiao/auto-pairs'

" Git Gutter
Plug 'mhinz/vim-signify'

" Status-line
Plug 'itchyny/lightline.vim'

" Colourscheme
Plug 'jeffkreeftmeijer/vim-dim'

call plug#end()

" ###################
" # editor settings #
" ###################

" colourscheme and status-line settings
set background=light
colorscheme dim " follows terminal colorscheme :)
set laststatus=2

" full path in status-line
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
      \ },
      \ 'colorscheme': 'seoul256'
      \ }

" Some syntax-highlighting improvements
" highlight CocHighlightText cterm=bold,underline
" highlight CocErrorHighlight cterm=underline ctermfg=Red
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

" for git vim-signify
set updatetime=500

" fast escape
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

" ############
" # mappings #
" ############

" fzf mappings

" search for git files
nnoremap <C-f> :GFiles<Cr> 
" search for files (not only git)
nnoremap <C-F> :Files<Cr>
" search for string
nnoremap <C-s> :Ag<Cr>
" search for word under cursor
nnoremap <C-S> :Ag <C-R><C-W><Cr>
" search open buffers
nnoremap <C-a> :Buffers<Cr>

" other helpful mappings
noremap ; :

" #######
" # CoC #
" #######

" " Use tab for trigger completion with characters ahead and navigate
" " NOTE: There's always complete item selected by default, you may want to enable
" " no select by `"suggest.noselect": true` in your configuration file
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config
" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1) :
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" 
" " Make <CR> to accept selected completion item or notify coc.nvim to format
" " <C-g>u breaks current undo, please make your own choice
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" 
" function! CheckBackspace() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" 
" " Use <c-space> to trigger completion
" if has('nvim')
"   inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif
" 
" " Use `[g` and `]g` to navigate diagnostics
" " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
" nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
" nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)
" 
" " GoTo code navigation
" nmap <silent><nowait> gd <Plug>(coc-definition)
" nmap <silent><nowait> gy <Plug>(coc-type-definition)
" nmap <silent><nowait> gi <Plug>(coc-implementation)
" nmap <silent><nowait> gr <Plug>(coc-references)
" 
" " Use K to show documentation in preview window
" nnoremap <silent> K :call ShowDocumentation()<CR>
" 
" function! ShowDocumentation()
"   if CocAction('hasProvider', 'hover')
"     call CocActionAsync('doHover')
"   else
"     call feedkeys('K', 'in')
"   endif
" endfunction
" 
" " Highlight the symbol and its references when holding the cursor
" autocmd CursorHold * silent call CocActionAsync('highlight')
" 
" " Symbol renaming
" nmap <F2> <Plug>(coc-rename)
" 
" " Formatting selected code
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
" 
" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s)
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
" augroup end
" 
" " Applying code actions to the selected code block
" " Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)
" 
" " Remap keys for applying code actions at the cursor position
" nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" " Remap keys for apply code actions affect whole buffer
" nmap <leader>as  <Plug>(coc-codeaction-source)
" " Apply the most preferred quickfix action to fix diagnostic on the current line
" nmap <leader>qf  <Plug>(coc-fix-current)
" 
" " Remap keys for applying refactor code actions
" nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
" xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
" nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
" 
" " Run the Code Lens action on the current line
" nmap <leader>cl  <Plug>(coc-codelens-action)
" 
" " Map function and class text objects
" " NOTE: Requires 'textDocument.documentSymbol' support from the language server
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)
" 
" " Add `:Format` command to format current buffer
" command! -nargs=0 Format :call CocActionAsync('format')
" 
" " Add `:Fold` command to fold current buffer
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" 
" " Add `:OR` command for organize imports of the current buffer
" command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
" 
" " Add (Neo)Vim's native statusline support
" " NOTE: Please see `:h coc-status` for integrations with external plugins that
" " provide custom statusline: lightline.vim, vim-airline
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" 
" " Mappings for CoCList
" " Show all diagnostics
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
