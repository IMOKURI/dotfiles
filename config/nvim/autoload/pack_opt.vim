set encoding=utf-8
scriptencoding utf-8

function! pack_opt#deoplete() abort " {{{
    if exists('g:loaded_pack_opt_deoplete')
        return
    endif
    let g:loaded_pack_opt_deoplete = 1

    if has('nvim')
        let g:float_preview#docked = 0
        let g:float_preview#max_width = 60
        let g:float_preview#max_height = 20

        packadd float-preview.nvim
    else
        packadd nvim-yarp
        packadd vim-hug-neovim-rpc
    endif

    packadd deoplete.nvim
    packadd deoplete-tabnine
    packadd deoplete-emoji

    call deoplete#custom#var('around', {
        \ 'range_above': 30,
        \ 'range_below': 30,
        \ 'mark_above': '[↑]',
        \ 'mark_below': '[↓]',
        \ 'mark_changes': '[*]',
        \ })

    call deoplete#custom#var('buffer', {
        \ 'require_same_filetype': v:false
        \ })

    call deoplete#custom#var('file', {
        \ 'force_completion_length': 1
        \ })

    call deoplete#custom#option({
        \ 'auto_refresh_delay': 10
        \ })

    call deoplete#custom#source('tabnine', {
        \ 'rank': 100
        \ })

    call deoplete#enable()
endfunction " }}}

function! pack_opt#echodoc() abort " {{{
    if exists('g:loaded_pack_opt_echodoc')
        return
    endif
    let g:loaded_pack_opt_echodoc = 1

    if has('nvim')
        let g:echodoc#type = 'virtual'
    endif

    packadd echodoc.vim

    call echodoc#enable()
endfunction " }}}

function! pack_opt#ale() abort " {{{
    if exists('g:loaded_pack_opt_ale')
        return
    endif
    let g:loaded_pack_opt_ale = 1

    let g:ale_sign_error = 'E>'
    let g:ale_sign_warning = 'W>'
    let g:ale_sign_highlight_linenrs = 1

    let g:ale_virtualtext_cursor = 1

    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%severity%][%linter%] %s'

    packadd ale

    nmap <silent><expr> <C-p> yankround#is_active() ? "\<Plug>(yankround-prev)" : "\<Plug>(ale_previous_wrap)"
    nmap <silent><expr> <C-n> yankround#is_active() ? "\<Plug>(yankround-next)" : "\<Plug>(ale_next_wrap)"

    nmap <silent> <Leader>x <Plug>(ale_fix)
endfunction " }}}

" vim:set foldmethod=marker:
