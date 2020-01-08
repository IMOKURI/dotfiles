set encoding=utf-8
scriptencoding utf-8

" -----------------------------------------------------------------------------
" Determine XDG base directory {{{
if empty($XDG_CONFIG_HOME)
    let $XDG_CONFIG_HOME = expand('~/.config')
endif

if empty($XDG_DATA_HOME)
    let $XDG_DATA_HOME = expand('~/.local/share')
endif
" }}}

" -----------------------------------------------------------------------------
" Provider settings {{{
if has('nvim')
    let s:provider_dir = $XDG_DATA_HOME . '/provider.nvim'

    let g:python3_host_prog = s:provider_dir . '/python/.venv/bin/python'
    let g:node_host_prog = s:provider_dir . '/nodejs/node_modules/.bin/neovim-node-host'

    let g:loaded_python_provider = 0
    let g:loaded_ruby_provider = 0
endif
" }}}

" -----------------------------------------------------------------------------
" dein install {{{
if has('nvim')
    let s:dein_dir = $XDG_DATA_HOME . '/dein/nvim'
else
    let s:dein_dir = $XDG_DATA_HOME . '/dein/vim'
endif
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}

" -----------------------------------------------------------------------------
" Map leader {{{
if !exists('g:mapleader')
    nnoremap <Space> <Nop>
    let g:mapleader = "\<Space>"
endif
" }}}

" vim:set foldmethod=marker:
