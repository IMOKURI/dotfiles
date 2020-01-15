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
" Reset augroup {{{
augroup MyAutoCmd
    autocmd!
augroup END
" }}}

if has('vim_starting')
    call vimrc#source_rc('init.rc.vim')
endif

call vimrc#source_rc('options.rc.vim')

call vimrc#source_rc('mappings.rc.vim')

call vimrc#source_rc('autocmd.rc.vim')

call vimrc#source_rc('syntax.rc.vim')

" vim:set foldmethod=marker:
