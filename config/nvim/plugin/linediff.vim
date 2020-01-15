
xnoremap <silent> <Leader>l :Linediff<CR>

augroup MyAutoCmd
    autocmd CmdUndefined Linediff packadd linediff.vim
augroup END
