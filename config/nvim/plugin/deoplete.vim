
augroup MyAutoCmd " {{{
    autocmd InsertEnter * call pack_opt#deoplete()
    autocmd CompleteDone * call pack_opt#echodoc()
augroup END " }}}

" vim:set foldmethod=marker:
