
let g:ale_linters = {
    \ 'sh': ['language_server']
    \ }

let g:ale_fixers = {
    \ 'sh': ['shfmt']
    \ }

call pack_opt#ale()
