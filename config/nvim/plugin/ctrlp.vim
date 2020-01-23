
let g:ctrlp_map = '<Nop>'
let g:ctrlp_match_window = 'order:ttb,min:10'
let g:ctrlp_show_hidden = 1

nnoremap <Leader>f :<C-u>CtrlP<CR>
nnoremap <Leader>b :<C-u>CtrlPBuffer<CR>
nnoremap <Leader>e :<C-u>CtrlPCurFile<CR>
nnoremap <Leader>o :<C-u>CtrlPMRU<CR>

augroup MyAutoCmd
    autocmd CmdUndefined CtrlP,CtrlPBuffer,CtrlPCurFile,CtrlPMRU packadd ctrlp.vim
augroup END
