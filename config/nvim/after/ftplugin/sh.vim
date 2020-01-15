
nnoremap <silent> <CR><CR> :call repl#repl_send('bash ' . expand('%'))<CR>

let g:ale_linters = {
    \ 'sh': ['language_server']
    \ }

let g:ale_fixers = {
    \ 'sh': ['shfmt']
    \ }
