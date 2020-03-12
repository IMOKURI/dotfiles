
let g:ale_linters = {
    \ 'vue': ['eslint']
    \ }

let g:ale_fixers = {
    \ 'vue': ['eslint']
    \ }

call pack_opt#ale()
