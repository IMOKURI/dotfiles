
augroup MyAutoCmd " {{{

    autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif

    autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
    autocmd CursorHold,CursorHoldI,WinEnter * setlocal cursorline

    autocmd InsertLeave * set nopaste

    autocmd BufWritePre * call vimrc#auto_mkdir(expand('<afile>:p:h:s?suda://??'), v:cmdbang)

augroup END " }}}
