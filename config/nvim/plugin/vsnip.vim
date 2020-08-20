
" g:vsnip_snippet_dir = '$MYVIMRCDIR/snippet'

imap <expr> <C-k> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-k>'
smap <expr> <C-k> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-k>'
imap <expr> <C-j> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-j>'
smap <expr> <C-j> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-j>'
