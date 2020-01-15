set encoding=utf-8
scriptencoding utf-8

function! pack_opt#ale() abort " {{{
    if exists('g:loaded_pack_opt_ale')
        return
    endif
    let g:loaded_pack_opt_ale = 1

    let g:ale_sign_error = 'E>'
    let g:ale_sign_warning = 'W>'
    let g:ale_sign_highlight_linenrs = 1

    let g:ale_virtualtext_cursor = 1

    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%severity%][%linter%] %s'

    packadd ale

    nmap <silent><expr> <C-p> yankround#is_active() ? "\<Plug>(yankround-prev)" : "\<Plug>(ale_previous_wrap)"
    nmap <silent><expr> <C-n> yankround#is_active() ? "\<Plug>(yankround-next)" : "\<Plug>(ale_next_wrap)"

    nmap <silent> <Leader>x <Plug>(ale_fix)
endfunction " }}}

function! pack_opt#lexima() abort " {{{
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

" vim:set foldmethod=marker:
