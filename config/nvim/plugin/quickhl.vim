
" nmap <silent> <Leader>m <Plug>(quickhl-manual-this)
" xmap <silent> <Leader>m <Plug>(quickhl-manual-this)
" nmap <silent> <Leader>M <Plug>(quickhl-manual-reset)

nmap <silent> <Leader>m :call quickhl#manual#this('n')<CR>
xmap <silent> <Leader>m :call quickhl#manual#this('v')<CR>
nmap <silent> <Leader>M :call quickhl#manual#reset()<CR>

augroup MyAutoCmd
    autocmd FuncUndefined quickhl#manual#this packadd vim-quickhl
augroup END
