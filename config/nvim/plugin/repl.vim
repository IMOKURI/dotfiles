if exists('g:loaded_repl')
    finish
endif
let g:loaded_repl = 1

if has('nvim')
    autocmd TermOpen * let g:last_terminal_job_id = b:terminal_job_id
else
    autocmd TerminalOpen * let g:last_terminal_job_id = bufnr('')
endif

command! -range=% REPLSendSelection call repl#repl_send(repl#get_visual())
command! REPLSendLine call repl#repl_send(getline('.'))
command! -complete=shellcmd -nargs=+ REPLMap call repl#repl_map_for(<q-args>)

nnoremap <silent> <Leader><CR> :REPLSendLine<CR>
xnoremap <silent> <Leader><CR> :REPLSendSelection<CR>
