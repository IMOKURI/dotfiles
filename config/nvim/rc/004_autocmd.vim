augroup MyAutoCmd " {{{
    autocmd!

    autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif

    autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
    autocmd CursorHold,CursorHoldI,WinEnter * setlocal cursorline

    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number | set relativenumber | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &number | set norelativenumber | endif

    autocmd InsertLeave * set nopaste

    if has('nvim-0.5.0')
        autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
    endif

    autocmd BufWritePre * lua require("util").auto_mkdir(vim.fn.expand('<afile>:p:h:s?suda://??'), vim.api.nvim_eval('v:cmdbang'))

augroup END " }}}
