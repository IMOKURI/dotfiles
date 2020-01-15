
let g:ctrlp_map = '<Nop>'

nnoremap <Leader>f :<C-u>CtrlP<CR>
nnoremap <Leader>b :<C-u>CtrlPBuffer<CR>
nnoremap <Leader>e :<C-u>CtrlPCurFile<CR>
nnoremap <Leader>o :<C-u>CtrlPMRU<CR>

augroup MyAutoCmd
    autocmd CmdUndefined CtrlP,CtrlPBuffer,CtrlPCurFile,CtrlPMRU packadd ctrlp.vim
augroup END
