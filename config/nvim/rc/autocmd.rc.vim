
augroup MyAutoCmd " {{{

    autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif

    autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
    autocmd CursorHold,CursorHoldI,WinEnter * setlocal cursorline

    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number | set relativenumber | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &number | set norelativenumber | endif

    autocmd InsertLeave * set nopaste

    autocmd BufWritePre * call vimrc#auto_mkdir(expand('<afile>:p:h:s?suda://??'), v:cmdbang)

augroup END " }}}
