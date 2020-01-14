function! pack_opt#deoplete() abort " {{{
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
    if has('nvim')
        let g:echodoc#type = 'virtual'
    endif

    packadd echodoc.vim

    call echodoc#enable()
endfunction " }}}

" vim:set foldmethod=marker:
