function! vimrc#auto_mkdir(dir, force) abort " {{{
    if !isdirectory(a:dir) && (a:force || input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction " }}}

function! vimrc#delete_hidden_buffers() abort " {{{
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction " }}}

function! vimrc#get_visual() abort " {{{
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][:col2 - 2]
    let lines[0] = lines[0][col1 - 1:]
    return join(lines, "\n")
endfunction " }}}

function! vimrc#hint_cmd_output(prefix, cmd) abort " {{{
    redir => str
        execute a:cmd
    redir END
    let more_old = &more
    set nomore
    echo str
    let &more = more_old
    return a:prefix . nr2char(getchar())
endfunction " }}}

function! vimrc#on_filetype() abort " {{{
  if execute('filetype') =~# 'OFF'
    " Lazy loading
    silent! filetype plugin indent on
    syntax enable
    filetype detect
  endif
endfunction " }}}

function! vimrc#repl_map_for(cmd) abort " {{{
    exec 'nnoremap <silent> tt :call vimrc#repl_send("' . s:repl_map_expand(a:cmd) . '")<CR>'
endfunction " }}}

function! s:repl_map_expand(cmd) abort " {{{
    let l:cmd = substitute(a:cmd, '[^\\]\zs%', expand('%'), 'g')
    return l:cmd
endfunction " }}}

function! vimrc#repl_send(str) abort " {{{
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

function! vimrc#smart_fold_closer() abort " {{{
    if foldlevel('.') == 0
        norm! zM
        return
    endif

    let foldc_lnum = foldclosed('.')
    norm! zc
    if foldc_lnum == -1
        return
    endif

    if foldclosed('.') != foldc_lnum
        return
    endif
    norm! zM
endfunction " }}}

function! vimrc#source_rc(path, ...) abort " {{{
  let l:use_global = get(a:000, 0, !has('vim_starting'))
  let l:abspath = resolve(expand('$XDG_CONFIG_HOME/nvim/rc/' . a:path))

  if !l:use_global
    execute 'source' fnameescape(l:abspath)
    return
  endif

  " substitute all 'set' to 'setglobal'
  let l:content = map(readfile(l:abspath),
        \ "substitute(v:val, '^\\W*\\zsset\\ze\\W', 'setglobal', '')")

  " create tempfile and source the tempfile
  let l:tempfile = tempname()

  try
    call writefile(l:content, l:tempfile)
    execute 'source' fnameescape(l:tempfile)
  finally
    if filereadable(l:tempfile)
      call delete(l:tempfile)
    endif
  endtry
endfunction " }}}

" vim:set foldmethod=marker:
