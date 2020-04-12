
let g:sh_fold_enabled = 7

set foldmethod=syntax

let g:ale_linters = {
    \ 'sh': ['language_server']
    \ }

let g:ale_fixers = {
    \ 'sh': ['shfmt']
    \ }

call pack_opt#ale()
