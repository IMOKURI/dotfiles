
call textobj#user#plugin('line', {
    \   '-': {
    \     'select-a-function': 'CurrentLineA',
    \     'select-a': 'al',
    \     'select-i-function': 'CurrentLineI',
    \     'select-i': 'il',
    \   },
    \ })

function! CurrentLineA() abort " {{{
    normal! 0
    let head_pos = getpos('.')
    normal! $
    let tail_pos = getpos('.')
    return ['v', head_pos, tail_pos]
endfunction " }}}

function! CurrentLineI() " {{{
    normal! ^
    let head_pos = getpos('.')
    normal! g_
    let tail_pos = getpos('.')
    let non_blank_char_exists_p = getline('.')[head_pos[2] - 1] !~# '\s'
    return
        \ non_blank_char_exists_p
        \ ? ['v', head_pos, tail_pos]
        \ : 0
endfunction " }}}
