set encoding=utf-8
scriptencoding utf-8

function! CustomizeLexima() abort " {{{
    if exists('g:loaded_pack_opt_lexima')
        return
    endif
    let g:loaded_pack_opt_lexima = 1

    packadd lexima.vim

    " Japanese Bracket
    call lexima#add_rule({'char': '「', 'input_after': '」'})
    call lexima#add_rule({'char': '」', 'at': '\%#」', 'leave': 1})
    call lexima#add_rule({'char': '<BS>', 'at': '「\%#」', 'delete': 1})

    " Jinja2
    call lexima#add_rule({'char': '%', 'at': '{\%#}', 'input_after': '%'})
    call lexima#add_rule({'char': '%', 'at': '{%\%#%}', 'leave': 2})
    call lexima#add_rule({'char': '}', 'at': '{%\%#%}', 'leave': 2})
    call lexima#add_rule({'char': '<BS>', 'at': '{%\%#%}', 'delete': 1})

    call lexima#add_rule({'char': '<Space>', 'at': '{%\%#%}', 'input_after': '<Space>'})
    call lexima#add_rule({'char': '%', 'at': '{% \%# %}', 'leave': 3})
    call lexima#add_rule({'char': '}', 'at': '{% \%# %}', 'leave': 3})
    call lexima#add_rule({'char': '<BS>', 'at': '{% \%# %}', 'delete': 1})
endfunction " }}}

augroup MyAutoCmd
    autocmd InsertEnter * call CustomizeLexima()
augroup END
