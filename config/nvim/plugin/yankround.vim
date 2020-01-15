
let g:yankround_dir = $XDG_DATA_HOME . '/yankround'
let g:yankround_use_region_hl = 1

nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)

if !hasmapto('yankround#is_active')
    nmap <C-p> <Plug>(yankround-prev)
    nmap <C-n> <Plug>(yankround-next)
endif
