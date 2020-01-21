set encoding=utf-8
scriptencoding utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp-3,euc-jp,cp932

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
" Map leader {{{
if !exists('g:mapleader')
    nnoremap <Space> <Nop>
    let g:mapleader = "\<Space>"
endif
" }}}

" -----------------------------------------------------------------------------
" Reset augroup {{{
augroup MyAutoCmd
    autocmd!
augroup END
" }}}

call vimrc#source_rc('options.rc.vim')

call vimrc#source_rc('mappings.rc.vim')

call vimrc#source_rc('autocmd.rc.vim')

" -----------------------------------------------------------------------------
" Syntax {{{
filetype plugin indent on
syntax enable
" }}}

" -----------------------------------------------------------------------------
" Neovim provider settings {{{
if has('nvim')
    let g:loaded_node_provider = 0
    let g:loaded_perl_provider = 0
    let g:loaded_python3_provider = 0
    let g:loaded_python_provider = 0
    let g:loaded_ruby_provider = 0
endif
" }}}

" vim:set foldmethod=marker:
