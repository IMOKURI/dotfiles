set encoding=utf-8
scriptencoding utf-8

let g:dein#auto_recache = 1

if has('nvim')
    let g:dein#install_progress_type = 'title'

    let s:dein_dir = $XDG_DATA_HOME . '/dein/nvim'
else
    let s:dein_dir = $XDG_DATA_HOME . '/dein/vim'
endif

let s:default_toml = expand('$XDG_CONFIG_HOME/nvim/rc/dein_default.toml')
let s:lazy_toml = expand('$XDG_CONFIG_HOME/nvim/rc/dein_lazy.toml')

call dein#begin(s:dein_dir, [expand('<sfile>'), s:default_toml, s:lazy_toml])

call dein#load_toml(s:default_toml, {'lazy': 0})
call dein#load_toml(s:lazy_toml, {'lazy' : 1})

" Session Manager {{{
function! s:lambdalisue_session_vim() abort
    nnoremap ss :SessionSave
endfunction

call dein#add('lambdalisue/session.vim', {
    \ 'on_source': 'denite.nvim',
    \ 'hook_add': function('s:lambdalisue_session_vim'),
    \ })
" }}}

call dein#end()

if dein#check_install()
    call dein#install()
    call dein#source(['deoplete.nvim', 'denite.nvim'])
    call dein#remote_plugins()
endif

if !has('vim_starting')
    call dein#call_hook('source')
    call dein#call_hook('post_source')
endif

" Neoterm calls autoload functions in ftdetect.
" So source neoterm before filetype on.
call dein#source('neoterm')

" vim:set foldmethod=marker:
