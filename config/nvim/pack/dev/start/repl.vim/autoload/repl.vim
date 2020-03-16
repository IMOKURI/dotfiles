function! repl#get_visual() abort " {{{
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][:col2 - 2]
    let lines[0] = lines[0][col1 - 1:]
    return join(lines, "\n")
endfunction " }}}

function! repl#repl_send(str) abort " {{{
    " Create terminal if not exist.
    if !exists('g:last_terminal_job_id')
        execute 'Ttoggle'
        execute 'sleep 1'
    endif

    " Open terminal if not display in current window.
    let s:chan_info = nvim_get_chan_info(g:last_terminal_job_id)
    if bufwinnr(s:chan_info.buffer) == -1
        execute 'Ttoggle'
    endif

    let s:str = a:str
    if s:str[-1] !=# "\n"
        let s:str .= "\n"
    endif
    let s:str = substitute(s:str, "\n", "\<CR>", 'g')

    if has('nvim')
        call chansend(g:last_terminal_job_id, [s:str])
    else
        call term_sendkeys(g:last_terminal_job_id, s:str)
    endif
endfunction " }}}

function! repl#repl_map_for(cmd) abort " {{{
    exec 'nnoremap <silent> <Leader><Leader><CR> :call repl#repl_send("' . s:repl_map_expand(a:cmd) . '")<CR>'
endfunction " }}}

function! s:repl_map_expand(cmd) abort " {{{
    let l:cmd = substitute(a:cmd, '[^\\]\zs%', expand('%'), 'g')
    return l:cmd
endfunction " }}}

" vim:set foldmethod=marker:
