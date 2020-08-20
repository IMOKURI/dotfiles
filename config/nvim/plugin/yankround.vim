
let g:yankround_dir = expand(stdpath('data') . '/yankround')
let g:yankround_use_region_hl = 1

nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)

nmap <Leader>P <Plug>(yankround-prev)
nmap <Leader>N <Plug>(yankround-next)
