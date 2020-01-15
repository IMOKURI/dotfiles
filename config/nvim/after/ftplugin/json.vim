
let g:ale_linters = {
    \ 'json': ['jq']
    \ }

let g:ale_fixers = {
    \ 'json': ['jq']
    \ }

let g:ale_json_jq_options = '--indent 4'

call pack_opt#ale()
