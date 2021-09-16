function! vimrc#auto_mkdir(dir, force) abort " {{{
    if !isdirectory(a:dir) && (a:force || input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
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
