
xnoremap <silent> <Leader>c :Commentary<CR>

augroup MyAutoCmd
    autocmd CmdUndefined Commentary packadd vim-commentary
augroup END
