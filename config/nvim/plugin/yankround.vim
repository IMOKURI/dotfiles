
let g:yankround_dir = $XDG_DATA_HOME . '/yankround'
let g:yankround_use_region_hl = 1

nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)

nmap <C-P> <Plug>(yankround-prev)
nmap <C-N> <Plug>(yankround-next)
