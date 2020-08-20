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

function! vimrc#same_indent(dir) abort " {{{
    let lnum = line('.')
    let width = col('.') <= 1 ? 0 : strdisplaywidth(matchstr(getline(lnum)[: col('.')-2], '^\s*'))
    while 1 <= lnum && lnum <= line('$')
        let lnum += (a:dir ==# '+' ? 1 : -1)
        let line = getline(lnum)
        if width >= strdisplaywidth(matchstr(line, '^\s*')) && line =~# '^\s*\S'
            break
        endif
    endwhile
    return abs(line('.') - lnum) . a:dir
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

function! vimrc#helptags() abort " {{{
    packloadall
    silent! helptags ALL
endfunction " }}}

function! vimrc#move_win(key) abort " {{{
    let t:curwin = winnr()
    exec "wincmd ".a:key

    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction " }}}
