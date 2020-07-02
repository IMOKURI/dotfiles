set encoding=utf-8
scriptencoding utf-8

" '(」・ω・)」うー '
" '(/・ω・)/にゃー'

" g:lightline {{{
let g:lightline = {
    \ 'colorscheme': 'challenger_deep',
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' },
    \ 'active': {
    \   'left': [
    \     [ 'mode', 'paste' ],
    \     [ 'fugitive', 'readonly', 'filepath', 'modified' ]
    \   ],
    \   'right': [
    \     [ 'percent', 'lineinfo' ],
    \     [ 'filetype' ],
    \     [ 'fileformat', 'fileencoding' ]
    \   ]
    \ },
    \ 'inactive': {
    \   'left': [
    \     [ 'inactive' ],
    \     [ 'fugitive', 'readonly', 'filepath', 'modified' ]
    \   ],
    \   'right': [
    \     [ 'percent', 'lineinfo' ],
    \     [ 'filetype' ],
    \     [ 'fileformat', 'fileencoding' ]
    \   ]
    \ },
    \ 'tabline': {
    \   'left': [[ 'tabs' ]],
    \   'right': [[ 'none' ]]
    \ },
    \ 'component_function': {
    \   'fugitive': 'LightLineFugitive',
    \   'inactive': 'LightLineInactive',
    \   'readonly': 'LightLineReadOnly',
    \   'filepath': 'LightLineFilePath',
    \ }
    \ }
" }}}

function! LightLineFugitive() abort " {{{
    try
        return exists('*fugitive#head') ? ' ' . fugitive#head() : ''
    catch
    endtry
    return ''
endfunction " }}}

function! LightLineInactive() abort " {{{
    return 'INACTIVE'
endfunction " }}}

function! LightLineReadOnly() abort " {{{
    return &filetype !~? 'help' && &readonly ? '' : ''
endfunction " }}}

function! LightLineFilePath() abort " {{{
    " ファイル名を下位3階層のみの表示にする
    try
        if expand('%:p:~') =~# '^suda://'
            let g:is_suda = 'suda://'
        else
            let g:is_suda = ''
        endif

        if expand('%:p:~:s?suda://??') =~# '^/[^/]*\/[^/]*\/[^/]*$'
            return expand('%:p:~')
        elseif expand('%:p:~:s?suda://??') =~# '/[^/]*\/[^/]*\/[^/]*$'
            return g:is_suda . expand('%:p:~:s?suda://??:s?.*\(/[^/]*\/[^/]*\/[^/]*\)$?...\1?')
        else
            return expand('%:p:~')
        endif
    catch
    endtry
    return ''
endfunction "}}}
