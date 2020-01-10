set encoding=utf-8
scriptencoding utf-8

" -----------------------------------------------------------------------------
" Determine XDG base directory {{{
if empty($XDG_CONFIG_HOME)
    let $XDG_CONFIG_HOME = expand('~/.config')
endif

if empty($XDG_DATA_HOME)
    let $XDG_DATA_HOME = expand('~/.local/share')
endif
" }}}

" -----------------------------------------------------------------------------
" Set augroup {{{
augroup MyAutoCmd
    autocmd!
    autocmd FileType,Syntax,BufNewFile,BufNew,BufRead *?
        \ call vimrc#on_filetype()
augroup END

" }}}

if has('vim_starting')
    call vimrc#source_rc('init.rc.vim')
endif

call vimrc#source_rc('options.rc.vim')

call vimrc#source_rc('dein.rc.vim')

" -----------------------------------------------------------------------------
" Color scheme {{{
syntax on

if has('vim_starting') && !empty(argv())
    call vimrc#on_filetype()
endif

colorscheme challenger_deep

function! s:colorize(group, style) abort " {{{
    execute 'highlight' a:group
        \ 'guifg='   (has_key(a:style, 'fg')    ? a:style.fg.gui   : 'NONE')
        \ 'guibg='   (has_key(a:style, 'bg')    ? a:style.bg.gui   : 'NONE')
        \ 'ctermfg=' (has_key(a:style, 'fg')    ? a:style.fg.cterm : 'NONE')
        \ 'ctermbg=' (has_key(a:style, 'bg')    ? a:style.bg.cterm : 'NONE')
endfunction " }}}

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

if has('nvim')
    call s:colorize('ActiveWindow',   {'bg': s:bg,        'fg': s:norm})
    call s:colorize('InactiveWindow', {'bg': s:bg_subtle, 'fg': s:norm})
    set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
endif

call s:colorize('NormalFloat', {'bg': s:bg, 'fg': s:norm})

" ALE Highlight {{{
call s:colorize('ALEError',   {'bg': s:bg_subtle, 'fg': s:dark_red})
call s:colorize('ALEWarning', {'bg': s:bg_subtle, 'fg': s:dark_yellow})

if has('nvim-0.3.2')
    call s:colorize('ALEErrorSignLineNr',        {'bg': s:bg_subtle, 'fg': s:dark_red})
    call s:colorize('ALEStyleErrorSignLineNr',   {'bg': s:bg_subtle, 'fg': s:dark_red})
    call s:colorize('ALEWarningSignLineNr',      {'bg': s:bg_subtle, 'fg': s:dark_yellow})
    call s:colorize('ALEStyleWarningSignLineNr', {'bg': s:bg_subtle, 'fg': s:dark_yellow})
endif
" }}}

call s:colorize('Folded',            {'bg': s:bg_subtle,   'fg': s:blue})

call s:colorize('CursorLineNr',      {'bg': s:bg_subtle,   'fg': s:yellow})
call s:colorize('DimLineNr',         {'bg': s:bg_subtle,   'fg': s:dark_asphalt})
call s:colorize('HighlightedLineNr', {'bg': s:bg_subtle,   'fg': s:green})

call s:colorize('YankRoundRegion',   {'bg': s:norm_subtle, 'fg': s:bg_subtle})

if exists('&blend')
    highlight PmenuSel blend=0
endif
" }}}

" -----------------------------------------------------------------------------
" Status line {{{
function! LightLineFugitive() abort " {{{
    try
        return exists('*fugitive#head') ? ' ' . fugitive#head() : ''
    catch
    endtry
    return ''
endfunction " }}}

function! LightLineReadOnly() " {{{
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

let g:lightline#ale#indicator_checking = '(」・ω・)」うー '
let g:lightline#ale#indicator_ok = '(/・ω・)/にゃー'

" LightLine settings {{{
let g:lightline = {
    \ 'colorscheme': 'challenger_deep',
    \ 'active': {
    \   'left': [
    \     [ 'mode', 'paste' ],
    \     [ 'fugitive', 'readonly', 'filepath', 'modified' ],
    \     [ 'linter_checking', 'linter_warnings', 'linter_errors', 'linter_ok' ]
    \   ],
    \   'right': [
    \     [ 'percent', 'lineinfo' ],
    \     [ 'filetype' ],
    \     [ 'anzu', 'fileformat', 'fileencoding' ]
    \   ]
    \ },
    \ 'tabline': {
    \   'left': [[ 'tabs' ]],
    \   'right': [[ 'none' ]]
    \ },
    \ 'component_expand': {
    \   'linter_checking': 'lightline#ale#checking',
    \   'linter_warnings': 'lightline#ale#warnings',
    \   'linter_errors': 'lightline#ale#errors',
    \   'linter_ok': 'lightline#ale#ok',
    \ },
    \ 'component_type': {
    \   'linter_warnings': 'warning',
    \   'linter_errors': 'error',
    \ },
    \ 'component_function': {
    \   'fugitive': 'LightLineFugitive',
    \   'readonly': 'LightLineReadOnly',
    \   'filepath': 'LightLineFilePath',
    \   'anzu': 'anzu#search_status'
    \ }
    \ }

let g:lightline.separator    = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }
" }}}

" LightLine color palette {{{
let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette

let s:palette.tabline.tabsel = [
    \ [ s:bg_subtle.gui, s:cyan.gui,      s:bg_subtle.cterm, s:cyan.cterm ]
    \ ]

let s:palette.tabline.right = [
    \ [ s:bg_subtle.gui, s:bg_subtle.gui, s:bg_subtle.cterm, s:bg_subtle.cterm ]
    \ ]

let s:palette.normal.left = [
    \ [ s:bg_subtle.gui, s:blue.gui,      s:bg_subtle.cterm, s:blue.cterm ],
    \ [ s:bg_subtle.gui, s:dark_blue.gui, s:bg_subtle.cterm, s:dark_blue.cterm ]
    \ ]
let s:palette.normal.right = [
    \ [ s:bg_subtle.gui, s:blue.gui,      s:bg_subtle.cterm, s:blue.cterm ],
    \ [ s:bg_subtle.gui, s:dark_blue.gui, s:bg_subtle.cterm, s:dark_blue.cterm ]
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
    \ [ s:bg_subtle.gui, s:green.gui,      s:bg_subtle.cterm, s:green.cterm ],
    \ [ s:bg_subtle.gui, s:dark_green.gui, s:bg_subtle.cterm, s:dark_green.cterm ]
    \ ]
let s:palette.visual.right = [
    \ [ s:bg_subtle.gui, s:green.gui,      s:bg_subtle.cterm, s:green.cterm ],
    \ [ s:bg_subtle.gui, s:dark_green.gui, s:bg_subtle.cterm, s:dark_green.cterm ]
    \ ]

let s:palette.replace.left = [
    \ [ s:bg_subtle.gui, s:red.gui,      s:bg_subtle.cterm, s:red.cterm ],
    \ [ s:bg_subtle.gui, s:dark_red.gui, s:bg_subtle.cterm, s:dark_red.cterm ]
    \ ]
let s:palette.replace.right = [
    \ [ s:bg_subtle.gui, s:red.gui,      s:bg_subtle.cterm, s:red.cterm ],
    \ [ s:bg_subtle.gui, s:dark_red.gui, s:bg_subtle.cterm, s:dark_red.cterm ]
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
" }}}

" -----------------------------------------------------------------------------
" Commands {{{
command! -range=% REPLSendSelection call vimrc#repl_send(vimrc#get_visual())
command! REPLSendLine call vimrc#repl_send(getline('.'))
command! -complete=shellcmd -nargs=+ REPLMap call vimrc#repl_map_for(<q-args>)
" }}}

" -----------------------------------------------------------------------------
" Autocommands {{{
augroup MyAutoCmdOld " {{{
    autocmd!

    autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif

    autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
    autocmd CursorHold,CursorHoldI,WinEnter * setlocal cursorline

    autocmd InsertLeave * set nopaste

    autocmd BufWritePre * call vimrc#auto_mkdir(expand('<afile>:p:h:s?suda://??'), v:cmdbang)

    if has('nvim')
        autocmd TermOpen * let g:last_terminal_job_id = b:terminal_job_id
    else
        autocmd TerminalOpen * let g:last_terminal_job_id = bufnr('')
    endif
augroup END " }}}

augroup MyAutoCmdFileType " {{{
    autocmd!

    autocmd FileType vim let g:vim_indent_cont = &shiftwidth
    autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2

    autocmd FileType python nnoremap <silent> <CR><CR> :call vimrc#repl_send('python ' . expand('%'))<CR>
    autocmd FileType bash,sh nnoremap <silent> <CR><CR> :call vimrc#repl_send('bash ' . expand('%'))<CR>
    autocmd FileType yaml nnoremap <silent> <CR><CR> :call vimrc#repl_send('ansible-playbook ' . expand('%'))<CR>
augroup END " }}}
" }}}

" -----------------------------------------------------------------------------
" Mappings {{{
" Exモード使わない
nmap Q <Nop>

" ファイル保存
nnoremap <silent> <Leader>w :<C-u>w<CR>

" すべてのバッファのファイルを保存
nnoremap <silent> <Leader><Leader>w :<C-u>wa<CR>

" root権限でファイルを保存する
cnoremap w!! w !sudo tee > /dev/null %

" windowを閉じる
nnoremap <silent> qq :<C-u>close<CR>

" 全てのタブを閉じる
nnoremap <silent> <Leader>q :<C-u>qa<CR>

" すべてのタブを保存せず閉じる
nnoremap <silent> <Leader>Q :<C-u>qa!<CR>

" 新しいタブを開く
nnoremap <silent> gt :<C-u>tabnew<CR>

" カーソル下のディレクトリを開く
nnoremap gd :Explore <C-r><C-f><CR>

" タブを移動する
nnoremap gn gt
nnoremap gp gT

" ターミナルを開く
nnoremap <silent> te :terminal<CR>i

" ESCでターミナルモードからコマンドモードにする
tnoremap <silent> <ESC> <C-\><C-n>

" 行/選択範囲をターミナルに送る
nnoremap <silent> <Leader><CR> :REPLSendLine<CR>
xnoremap <silent> <Leader><CR> :REPLSendSelection<CR>

" インデントをコマンド1回にする
nnoremap > >>
nnoremap < <<

" 表示行単位で移動する
nnoremap j gj
nnoremap k gk
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" ウィンドウを移動する
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
if has('nvim')
    " TERM環境変数が悪そう
    nnoremap <BS> <C-w>h
else
    nnoremap <C-h> <C-w>h
endif

" ウィンドウを分割する
nnoremap <Leader>- <C-w>s
nnoremap <Leader><bar> <C-w>v

" ウィンドウの大きさを変更する
nnoremap <Leader><Up> <C-w>+
nnoremap <Leader><Down> <C-w>-
nnoremap <Leader><Right> <C-w>>
nnoremap <Leader><Left> <C-w><

" 直前のバッファに移動する
nnoremap <Leader><Tab> <C-^>

" 先頭に移動する
noremap H ^

" 折りたたみを開く
nnoremap <expr> l foldclosed('.') != -1 ? 'zo' : 'l'
nnoremap <expr> L foldclosed('.') != -1 ? 'zO' : '$'

" 折りたたみを閉じる
nnoremap <silent> , :<C-u>call vimrc#smart_fold_closer()<CR>

" 現在いるところ以外の折り畳みを閉じる
nnoremap <silent> z, zMzv

" カーソル下の単語をハイライトして置換する
nmap # *:%s/<C-r>///g<Left><Left>

" バッファ内で置換する
nnoremap S :%s//g<LEFT><LEFT>

" コマンドラインモード内を移動する
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

" マークをリストアップして{保存,復旧}する
nnoremap <expr> m  vimrc#hint_cmd_output('m', 'marks')
nnoremap <expr> `  vimrc#hint_cmd_output('`', 'marks') . 'zz'

" レジストリをリストアップする
nnoremap <expr> " vimrc#hint_cmd_output('"', 'registers')

" # を入力したときに行頭に移動しない
"inoremap # x<BS>#

" インサートモード中に移動する
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-b> <left>
inoremap <C-f> <right>
" }}}

" vim:set foldmethod=marker:
