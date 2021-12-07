" Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" Only use default plugin
set packpath=
set runtimepath=$VIMRUNTIME

" View options
set number
set list
set cursorline
set showmatch
set colorcolumn=120
set scrolloff=3
set laststatus=2

" Edit options
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set smartindent
set hidden

" Search options
set ignorecase
set smartcase
set wrapscan
set fileignorecase

" Leader key mapping
nnoremap <Space> <Nop>
let g:mapleader = "\<Space>"

" File mappings
nnoremap <silent> <Leader>w :<C-u>write<CR>
nnoremap <silent> <Leader><Leader>w :<C-u>wall<CR>
nnoremap <silent> qq :<C-u>close<CR>
nnoremap <silent> QQ :<C-u>bdelete!<CR>
nnoremap <silent> <Leader>q :<C-u>qall<CR>
nnoremap <silent> <Leader>Q :<C-u>qall!<CR>

" Move mappings
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
xnoremap <expr> j v:count ? 'j' : 'gj'
xnoremap <expr> k v:count ? 'k' : 'gk'
nnoremap H ^
xnoremap H ^
nnoremap L $
xnoremap L $
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-h> <left>
inoremap <C-l> <right>
nnoremap <Leader><Tab> <C-^>
