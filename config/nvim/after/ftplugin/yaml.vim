
setlocal tabstop=2 softtabstop=2 shiftwidth=2

nnoremap <silent> <CR><CR> :call repl#repl_send('ansible-playbook ' . expand('%'))<CR>

packadd vim-ansible-vault

let g:ale_linters = {
    \ 'yaml': ['yamllint']
    \ }

let g:ale_fixers = {
    \ 'yaml': ['prettier']
    \ }

let g:ale_yaml_yamllint_options='-d "{rules: {line-length: disable}}"'

call pack_opt#ale()
