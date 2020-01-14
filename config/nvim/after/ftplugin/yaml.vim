
setlocal tabstop=2 softtabstop=2 shiftwidth=2

nnoremap <silent> <CR><CR> :call repl#repl_send('ansible-playbook ' . expand('%'))<CR>

packadd vim-ansible-vault
