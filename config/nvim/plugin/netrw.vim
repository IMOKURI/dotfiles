
" one file per line with timestamp information and file size
let g:netrw_liststyle=1

" suppress the banner
let g:netrw_banner=0

" human-readable
let g:netrw_sizestyle='H'

" specify format string to vim's strftime()
let g:netrw_timefmt='%Y/%m/%d(%a) %H:%M:%S'

" The home directory for where bookmarks and history are saved
let g:netrw_home=expand('~')

" the settings that netrw buffers have
let g:netrw_bufsettings='noma nomod nu rnu nowrap ro nobl'
