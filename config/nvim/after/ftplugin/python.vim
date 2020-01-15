
nnoremap <silent> <CR><CR> :call repl#repl_send('python ' . expand('%'))<CR>

let g:ale_linters = {
    \ 'python': ['flake8', 'pylint']
    \ }

let g:ale_fixers = {
    \ 'python': ['autopep8', 'yapf', 'black', 'isort']
    \ }

let g:ale_python_flake8_options = '--ignore=E501'
let g:ale_python_pylint_options = '--max-line-length=120 --disable=missing-docstring'

call pack_opt#ale()