set encoding=utf-8
scriptencoding utf-8

" -----------------------------------------------------------------------------
" Neovim provider settings {{{
if has('nvim')
    let g:loaded_node_provider = 0
    let g:loaded_python_provider = 0
    let g:loaded_python3_provider = 0
    let g:loaded_ruby_provider = 0
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
