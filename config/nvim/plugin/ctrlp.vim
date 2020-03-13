
let g:ctrlp_map = '<Nop>'
let g:ctrlp_match_window = 'order:ttb,min:10'
let g:ctrlp_show_hidden = 1

if executable('rg')
    set grepprg=rg\ --color=never
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
else
    let g:ctrlp_clear_cache_on_exit = 0
endif

nnoremap <Leader>f :<C-u>CtrlP<CR>
nnoremap <Leader>b :<C-u>CtrlPBuffer<CR>
nnoremap <Leader>e :<C-u>CtrlPCurFile<CR>
nnoremap <Leader>o :<C-u>CtrlPMRU<CR>

augroup MyAutoCmd
    autocmd CmdUndefined CtrlP,CtrlPBuffer,CtrlPCurFile,CtrlPMRU packadd ctrlp.vim
augroup END
