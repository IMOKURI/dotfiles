
setlocal foldmethod=marker

let g:vim_indent_cont = &shiftwidth

let g:ale_linters = {
    \ 'vim': ['vint']
    \ }

call pack_opt#ale()
