if &runtimepath !~# '/neoterm'
    finish
endif

let g:neoterm_autoscroll = 1
let g:neoterm_default_mod = 'botright'
let g:neoterm_repl_python = 'python'

nnoremap <silent> <C-t> :Ttoggle<CR>
tnoremap <silent> <C-t> <C-\><C-n>:Ttoggle<CR>

nnoremap <silent> <C-y> :Topen<CR><C-w>ji
tnoremap <silent> <C-y> <C-\><C-n><C-w>k
