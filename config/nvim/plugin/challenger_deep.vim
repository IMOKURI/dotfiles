
" Palette {{{
let s:red            = {'gui': '#ff8080', 'cterm': '204'}
let s:dark_red       = {'gui': '#ff5458', 'cterm': '203'}

let s:yellow         = {'gui': '#ffe9aa', 'cterm': '228'}
let s:dark_yellow    = {'gui': '#ffb378', 'cterm': '215'}

let s:green          = {'gui': '#95ffa4', 'cterm': '120'}
let s:dark_green     = {'gui': '#62d196', 'cterm': '119'}

let s:blue           = {'gui': '#91ddff', 'cterm': '159'}
let s:dark_blue      = {'gui': '#65b2ff', 'cterm': '75'}

let s:purple         = {'gui': '#c991e1', 'cterm': '141'}
let s:dark_purple    = {'gui': '#906cff', 'cterm': '135'}

let s:cyan           = {'gui': '#aaffe4', 'cterm': '122'}
let s:dark_cyan      = {'gui': '#63f2f1', 'cterm': '121'}

let s:clouds         = {'gui': '#cbe3e7', 'cterm': '253'}
let s:dark_clouds    = {'gui': '#a6b3cc', 'cterm': '252'}

let s:asphalt        = {'gui': '#1e1c31', 'cterm': '233'}
let s:asphalt_subtle = {'gui': '#100E23', 'cterm': '232'}
let s:dark_asphalt   = {'gui': '#565575', 'cterm': '236'}

let s:norm        = s:clouds
let s:norm_subtle = s:dark_clouds

let s:bg          = s:asphalt
let s:bg_subtle   = s:asphalt_subtle
let s:bg_dark     = s:dark_asphalt
" }}}

function! CustomizeColors() abort " {{{
    if has('nvim')
        call vimrc#colorize('ActiveWindow',   {'bg': s:bg,        'fg': s:norm})
        call vimrc#colorize('InactiveWindow', {'bg': s:bg_subtle, 'fg': s:norm})
        set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
    endif

    call vimrc#colorize('NormalFloat', {'bg': s:bg, 'fg': s:norm})

    " ALE Highlight {{{
    call vimrc#colorize('ALEError',   {'bg': s:bg_subtle, 'fg': s:dark_red})
    call vimrc#colorize('ALEWarning', {'bg': s:bg_subtle, 'fg': s:dark_yellow})

    if has('nvim-0.3.2')
        call vimrc#colorize('ALEErrorSignLineNr',        {'bg': s:bg_subtle, 'fg': s:dark_red})
        call vimrc#colorize('ALEStyleErrorSignLineNr',   {'bg': s:bg_subtle, 'fg': s:dark_red})
        call vimrc#colorize('ALEWarningSignLineNr',      {'bg': s:bg_subtle, 'fg': s:dark_yellow})
        call vimrc#colorize('ALEStyleWarningSignLineNr', {'bg': s:bg_subtle, 'fg': s:dark_yellow})
    endif
    " }}}

    call vimrc#colorize('Folded',            {'bg': s:bg_subtle,   'fg': s:blue})

    call vimrc#colorize('CursorLineNr',      {'bg': s:bg_subtle,   'fg': s:yellow})
    call vimrc#colorize('DimLineNr',         {'bg': s:bg_subtle,   'fg': s:dark_asphalt})
    call vimrc#colorize('HighlightedLineNr', {'bg': s:bg_subtle,   'fg': s:green})

    call vimrc#colorize('YankRoundRegion',   {'bg': s:norm_subtle, 'fg': s:bg_subtle})

    " LightLine color palette {{{
    let s:palette = g:lightline#colorscheme#challenger_deep#palette

    let s:palette.tabline.tabsel = [
        \ [ s:bg_subtle.gui, s:cyan.gui,        s:bg_subtle.cterm, s:cyan.cterm ]
        \ ]

    let s:palette.tabline.right = [
        \ [ s:bg_subtle.gui, s:bg_subtle.gui,   s:bg_subtle.cterm, s:bg_subtle.cterm ]
        \ ]

    let s:palette.normal.left = [
        \ [ s:bg_subtle.gui, s:blue.gui,        s:bg_subtle.cterm, s:blue.cterm ],
        \ [ s:bg_subtle.gui, s:dark_blue.gui,   s:bg_subtle.cterm, s:dark_blue.cterm ]
        \ ]
    let s:palette.normal.right = [
        \ [ s:bg_subtle.gui, s:blue.gui,        s:bg_subtle.cterm, s:blue.cterm ],
        \ [ s:bg_subtle.gui, s:dark_blue.gui,   s:bg_subtle.cterm, s:dark_blue.cterm ]
        \ ]

    let s:palette.insert.left = [
        \ [ s:bg_subtle.gui, s:yellow.gui,      s:bg_subtle.cterm, s:yellow.cterm ],
        \ [ s:bg_subtle.gui, s:dark_yellow.gui, s:bg_subtle.cterm, s:dark_yellow.cterm ]
        \ ]
    let s:palette.insert.right = [
        \ [ s:bg_subtle.gui, s:yellow.gui,      s:bg_subtle.cterm, s:yellow.cterm ],
        \ [ s:bg_subtle.gui, s:dark_yellow.gui, s:bg_subtle.cterm, s:dark_yellow.cterm ]
        \ ]

    let s:palette.visual.left = [
        \ [ s:bg_subtle.gui, s:green.gui,       s:bg_subtle.cterm, s:green.cterm ],
        \ [ s:bg_subtle.gui, s:dark_green.gui,  s:bg_subtle.cterm, s:dark_green.cterm ]
        \ ]
    let s:palette.visual.right = [
        \ [ s:bg_subtle.gui, s:green.gui,       s:bg_subtle.cterm, s:green.cterm ],
        \ [ s:bg_subtle.gui, s:dark_green.gui,  s:bg_subtle.cterm, s:dark_green.cterm ]
        \ ]

    let s:palette.replace.left = [
        \ [ s:bg_subtle.gui, s:red.gui,         s:bg_subtle.cterm, s:red.cterm ],
        \ [ s:bg_subtle.gui, s:dark_red.gui,    s:bg_subtle.cterm, s:dark_red.cterm ]
        \ ]
    let s:palette.replace.right = [
        \ [ s:bg_subtle.gui, s:red.gui,         s:bg_subtle.cterm, s:red.cterm ],
        \ [ s:bg_subtle.gui, s:dark_red.gui,    s:bg_subtle.cterm, s:dark_red.cterm ]
        \ ]

    let s:palette.inactive.left = [
        \ [ s:bg_subtle.gui, s:purple.gui,      s:bg_subtle.cterm, s:purple.cterm ],
        \ [ s:bg_subtle.gui, s:dark_purple.gui, s:bg_subtle.cterm, s:dark_purple.cterm ]
        \ ]
    let s:palette.inactive.right = [
        \ [ s:bg_subtle.gui, s:purple.gui,      s:bg_subtle.cterm, s:purple.cterm ],
        \ [ s:bg_subtle.gui, s:dark_purple.gui, s:bg_subtle.cterm, s:dark_purple.cterm ]
        \ ]
    " }}}

endfunction " }}}

augroup CustomizeColors
    autocmd!
    autocmd ColorScheme * call CustomizeColors()
augroup END

colorscheme challenger_deep

" vim:set foldmethod=marker:
