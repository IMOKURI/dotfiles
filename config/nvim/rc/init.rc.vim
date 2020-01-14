set encoding=utf-8
scriptencoding utf-8

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
" Map leader {{{
if !exists('g:mapleader')
    nnoremap <Space> <Nop>
    let g:mapleader = "\<Space>"
endif
" }}}

" vim:set foldmethod=marker:
