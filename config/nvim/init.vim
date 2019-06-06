set encoding=utf-8
scriptencoding utf-8

filetype off
filetype plugin indent off

let g:mapleader = "\<Space>"
let g:maplocalleader = '`'

" -----------------------------------------------------------------------------
" Detect platform
" -----------------------------------------------------------------------------
if !exists('g:env')
    if has('win64') || has('win32') || has('win16')
        let g:env = 'WINDOWS'
    else
        let g:env = toupper(substitute(system('uname'), '\n', '', ''))
    endif
endif

if empty($XDG_CONFIG_HOME)
    if g:env =~# 'LINUX'
        let $XDG_CONFIG_HOME = expand('~/.config')
    elseif g:env =~# 'WINDOWS'
        let $XDG_CONFIG_HOME = expand('~/AppData/Local')
    endif
endif

" -----------------------------------------------------------------------------
" Plugin settings
" -----------------------------------------------------------------------------
let s:nvim_dir = $XDG_CONFIG_HOME . '/nvim'

if g:env =~# 'LINUX'
    let g:python3_host_prog = s:nvim_dir . '/.venv/bin/python'
elseif g:env =~# 'WINDOWS'
    let g:python3_host_prog = s:nvim_dir . '/.venv/Scripts/python'
endif

let g:python_host_prog = ''

let s:dein_dir = s:nvim_dir . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . s:dein_repo_dir
endif

"---------------------------------------------------------------------------"
" Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator |
"------------------|--------|--------|---------|--------|--------|----------|
" map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |
" nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |
" vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |
" omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |
" xmap / xnoremap  |    -   |   -    |    -    |   @    |   -    |    -     |
" smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |
" map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |
" imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |
" cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |
"---------------------------------------------------------------------------"

call dein#begin(s:dein_dir)

call dein#add('Shougo/dein.vim')

call dein#add('challenger-deep-theme/vim')
call dein#add('jacoborus/tender.vim')
call dein#add('itchyny/lightline.vim')

call dein#add('airblade/vim-gitgutter')
call dein#add('tpope/vim-fugitive')

function! s:lambdalisue_suda_vim()
    let g:suda_smart_edit = 1
endfunction

call dein#add('lambdalisue/suda.vim', {
            \ 'hook_add': function('s:lambdalisue_suda_vim')
            \ })

call dein#add('tpope/vim-sleuth')

function! s:t9md_vim_quickhl()
    nmap <silent> <Leader>m <Plug>(quickhl-manual-this)
    xmap <silent> <Leader>m <Plug>(quickhl-manual-this)
    nnoremap <silent> <Leader>M :<C-u>QuickhlManualReset<CR>
endfunction

call dein#add('t9md/vim-quickhl', {
            \ 'hook_add': function('s:t9md_vim_quickhl')
            \ })

function! s:cohama_lexima_vim()
endfunction

call dein#add('cohama/lexima.vim', {
            \ 'hook_add': function('s:cohama_lexima_vim')
            \ })

call dein#add('thiagoalmeidasa/vim-ansible-vault')

call dein#add('dhruvasagar/vim-table-mode')

call dein#add('mechatroner/rainbow_csv')

function! s:xolox_vim_session()
    let s:local_session_directory = getcwd() . '/.vimsessions'
    if isdirectory(s:local_session_directory)
        let g:session_directory = s:local_session_directory
        let g:session_autosave = 'yes'
        let g:session_autoload = 'yes'
        let g:session_autosave_periodic = 1
        let g:session_autosave_silent = 1
        set sessionoptions-=help
    else
        let g:session_autosave = 'no'
        let g:session_autoload = 'no'
    endif
    unlet s:local_session_directory
endfunction

call dein#add('xolox/vim-misc')
call dein#add('xolox/vim-session', {
            \ 'depends': 'vim-misc',
            \ 'hook_add': function('s:xolox_vim_session')
            \ })

function! s:ncm2_float_preview()
    let g:float_preview#docked = 1
endfunction

call dein#add('ncm2/float-preview.nvim', {
            \ 'on_i': 1,
            \ 'hook_add': function('s:ncm2_float_preview')
            \ })

function! s:shougo_deoplete_nvim()
    let g:deoplete#enable_at_startup = 1
endfunction

call dein#add('Shougo/deoplete.nvim', {
            \ 'on_i': 1,
            \ 'hook_add': function('s:shougo_deoplete_nvim')
            \ })

call dein#add('fszymanski/deoplete-emoji', {
            \ 'depends': 'deoplete.nvim',
            \ })

call dein#add('deoplete-plugins/deoplete-jedi', {
            \ 'depends': 'deoplete.nvim',
            \ 'on_ft': 'python'
            \ })
call dein#add('Vimjas/vim-python-pep8-indent', {
            \ 'on_i': 1,
            \ 'on_ft': 'python'
            \ })

call dein#add('martinda/Jenkinsfile-vim-syntax', {
            \ 'on_path': '.*Jenkinsfile'
            \ })

function! s:neomake_neomake()
    augroup call_neomake
        autocmd!
        autocmd InsertLeave,BufWritePost * Neomake
    augroup END

    "let g:neomake_open_list = 2
    let g:neomake_tempfile_dir = '/tmp/neomake%:p:h'
    let g:neomake_echo_current_error = 0
    let g:neomake_virtualtext_prefix = '> '
    let g:neomake_error_sign = {'text': 'E>', 'texthl': 'NeomakeErrorSign'}
    let g:neomake_warning_sign = {'text': 'W>', 'texthl': 'NeomakeWarningSign',}
    let g:neomake_info_sign = {'text': 'I>', 'texthl': 'NeomakeInfoSign'}

    let g:neomake_python_enabled_makers = ['flake8', 'pylint']
    let g:neomake_shellcheck_args = ['-fgcc']
    let g:neomake_c_enabled_makers = ['gcc']
    let g:neomake_c_gcc_args = [
                \ '-fsyntax-only',
                \ '-std=gnu99',
                \ '-Wall',
                \ '-Wextra',
                \ '-fopenmp',
                \ '-I./include',
                \ ]
endfunction

call dein#add('neomake/neomake', {
            \ 'hook_add': function('s:neomake_neomake')
            \ })

function! s:sbdchd_neoformat()
    nnoremap <silent> <Leader>n :Neoformat<CR>

    let g:neoformat_basic_format_align = 1
    let g:neoformat_basic_format_retab = 1
    let g:neoformat_basic_format_trim = 1
endfunction

call dein#add('sbdchd/neoformat', {
            \ 'hook_add': function('s:sbdchd_neoformat')
            \ })

function! s:thinca_vim_showtime()
    nnoremap <silent> <Leader>s :ShowtimeStart<CR>
endfunction

call dein#add('thinca/vim-showtime', {
            \ 'hook_source': function('s:thinca_vim_showtime')
            \ })

function! s:shougo_denite_nvim_hook_add()
    nnoremap <silent> <Leader>b :Denite buffer<CR>
    nnoremap <silent> <Leader>f :Denite file/rec<CR>
    nnoremap <silent> <Leader>o :Denite file/old<CR>
    nnoremap <silent> <Leader>g :Denite grep<CR>
    nnoremap <silent> <Leader>c :DeniteCursorWord grep<CR>
    nnoremap <silent> <Leader>t :Denite tag<CR>
    nnoremap <silent> <Leader>h :Denite menu<CR>
endfunction

function! s:shougo_denite_nvim_hook_source()

    augroup Denite
        autocmd!
        autocmd FileType denite call s:denite_my_settings()
        autocmd FileType denite-filter call s:denite_filter_my_settings()
    augroup END

    function! s:denite_my_settings() abort
        nnoremap <silent><buffer><expr> <CR>
                    \ denite#do_map('do_action')
        nnoremap <silent><buffer><expr> <ESC>
                    \ denite#do_map('quit')
        nnoremap <silent><buffer><expr> i
                    \ denite#do_map('open_filter_buffer')
        nnoremap <silent><buffer><expr> <Space>
                    \ denite#do_map('toggle_select').'j'
        nnoremap <silent><buffer><expr> -
                    \ denite#do_map('move_up_path')
    endfunction

    function! s:denite_filter_my_settings() abort
        nnoremap <silent><buffer><expr> <ESC>
                    \ denite#do_map('quit')
    endfunction

    call denite#custom#option('_', {
                \ 'prompt': '>>',
                \ 'split': 'floating',
                \ 'highlight_window_background': 'CursorLine',
                \ 'highlight_filter_background': 'CursorLine',
                \ 'smartcase': 'true',
                \ })

    if executable('rg')
        call denite#custom#var('file/rec', 'command',
                    \ ['rg', '--files', '--glob', '!.git'])

        call denite#custom#var('grep', 'command', ['rg'])
        call denite#custom#var('grep', 'default_opts',
                    \ ['-i', '--vimgrep', '--no-heading'])
        call denite#custom#var('grep', 'recursive_opts', [])
        call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
        call denite#custom#var('grep', 'separator', ['--'])
        call denite#custom#var('grep', 'final_opts', [])
    endif

    let s:menus = {}

    call denite#custom#var('menu', 'menus', s:menus)

endfunction

call dein#add('Shougo/denite.nvim', {
            \ 'on_cmd': 'Denite',
            \ 'hook_add': function('s:shougo_denite_nvim_hook_add'),
            \ 'hook_source': function('s:shougo_denite_nvim_hook_source')
            \ })

function! s:pocari_vim_denite_emoji()
    nnoremap <silent> <Leader>u :Denite emoji<CR>
endfunction

call dein#add('junegunn/vim-emoji')
call dein#add('pocari/vim-denite-emoji', {
            \ 'depends': ['denite.nvim', 'vim-emoji'],
            \ 'on_source': 'denite.nvim',
            \ 'hook_add': function('s:pocari_vim_denite_emoji'),
            \ })

call dein#end()

if dein#check_install()
    call dein#install()
    call dein#remote_plugins()
endif

if !empty(dein#check_clean())
    call map(dein#check_clean(), "delete(v:val, 'rf')")
    call dein#recache_runtimepath()
endif

" -----------------------------------------------------------------------------
" netrw
" -----------------------------------------------------------------------------
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

" -----------------------------------------------------------------------------
" Color scheme
" -----------------------------------------------------------------------------
if has('nvim') || has('termguicolors')
    set termguicolors
endif

filetype plugin indent on
syntax on

colorscheme challenger_deep

function! LightLineFugitive()
    try
        return exists('*fugitive#head') ? fugitive#head() : ''
    catch
    endtry
    return ''
endfunction

function! LightlineNeomake()
    let l:winnr = winnr()
    let l:bufnr = winbufnr(l:winnr)
    let l:neomake_status_str = neomake#statusline#get(l:bufnr, {
                \ 'format_running': '({{running_job_names}})',
                \ 'format_loclist_unknown': '(」・ω・)」うー',
                \ 'format_loclist_ok': '(/・ω・)/にゃー',
                \ 'format_loclist_type_default': '{{type}}:{{count}} ',
                \ 'format_loclist_issues': '%s',
                \ 'format_quickfix_ok': '',
                \ 'format_quickfix_issues': '%s'
                \ })
    return l:neomake_status_str
endfunction

let g:lightline = {
            \ 'colorscheme': 'tender',
            \ 'active': {
            \   'left': [
            \     [ 'mode', 'paste' ],
            \     [ 'fugitive', 'readonly', 'filename', 'modified' ],
            \     [ 'neomake' ]
            \   ],
            \   'right': [
            \     [ 'lineinfo' ],
            \     [ 'percent' ],
            \     [ 'fileformat', 'fileencoding', 'filetype' ]
            \   ]
            \ },
            \ 'component_function': {
            \   'neomake': 'LightlineNeomake',
            \   'fugitive': 'LightLineFugitive'
            \ }
            \ }

augroup custom_filetype
    autocmd!
    autocmd BufRead,BufNewFile Dockerfile.* setf dockerfile
augroup END

" This does not work. Use ginit.vim instead.
"if has('gui_running')
"    Guifont! Migu 1M:h12
"endif

" -----------------------------------------------------------------------------
" Useful function
" -----------------------------------------------------------------------------

augroup remember_cursor
    autocmd!
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line ("'\"") <= line("$") |
                \   exe "normal! g'\"" |
                \ endif
augroup END

augroup auto_cursorline
    autocmd!
    autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
    autocmd CursorHold,CursorHoldI * setlocal cursorline
augroup END

augroup nopaste_when_insert_leave
    autocmd!
    autocmd InsertLeave * set nopaste
augroup END

function! LocationNext()
    try
        lnext
    catch
        try | lfirst | catch | endtry
    endtry
endfunction

nnoremap <silent> <C-p> :<C-u>lprevious<CR>
nnoremap <silent> <C-n> :call LocationNext()<CR>

" -----------------------------------------------------------------------------
" Mapping
" -----------------------------------------------------------------------------
" Exploreを開く
nnoremap <silent> <Leader>e :Explore<CR>

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
nnoremap <silent> <Leader><Leader>q :<C-u>qa!<CR>

" 新しいタブを開く
nnoremap <silent> gt :<C-u>tabnew<CR>

" タブを移動する
nnoremap gn gt
nnoremap gp gT

" 先頭/末尾に移動する
noremap H ^
noremap L $

" ESCでターミナルモードからコマンドモードにする
tnoremap <silent> <ESC> <C-\><C-n>

" インデントをコマンド1回にする
nnoremap > >>
nnoremap < <<

" 加算減算
nnoremap + <C-a>
nnoremap - <C-x>
vnoremap + <C-a>
vnoremap - <C-x>

" 「次の（前の）検索候補」を画面の中心に表示する
nnoremap n nzz
nnoremap N Nzz

" 表示行単位で移動する
nnoremap j gj
nnoremap k gk

" バッファを移動する
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" ウィンドウを分割する
nnoremap <Leader>- <C-w>s
nnoremap <Leader><bar> <C-w>v

" 相対行番号のトグル
nnoremap <silent> <Leader>r :set relativenumber!<CR>

" 検索結果のハイライトをEsc連打でクリアする
nnoremap <silent> <Esc><Esc> :<C-u>set nohlsearch!<CR>

" カーソル下の単語をハイライトする
nnoremap * *N

" カーソル下の単語をハイライトして置換する
nmap # *:%s/<C-r>///g<Left><Left>

" バッファ内で置換する
nnoremap S :%s//g<LEFT><LEFT>

" レジスタからペーストする
nnoremap <Leader>p "0p
nnoremap <Leader>P "0P

" # を入力したときに行頭に移動しない
inoremap # x<BS>#

" 行末に移動する
inoremap <C-l> <ESC>A

" jsonを整形する
cnoremap jq %!jq --indent 4 .

" -----------------------------------------------------------------------------
" Options
" -----------------------------------------------------------------------------
" 文字コード判別
set fileencodings=utf-8,sjis,iso-2022-jp,euc-jp

" 曖昧な幅の文字の論理幅を1に
set ambiwidth=single

" 行番号を表示
set number

" 行番号を相対位置で表示
set relativenumber

" 制御文字を表示
set list

" タブをスペースに変換
set expandtab

" インデントをスペース4つ分に設定
set tabstop=4

" タブとその削除をスペース4つ分に設定
set softtabstop=4

" >> コマンドで挿入される幅
set shiftwidth=4

" >> で挿入する際、shiftwidthの倍数になるように調整
set shiftround

" スマートインデント有効化
set smartindent

" カーソルラインをハイライト
set cursorline

" 行頭に移動しない
set nostartofline

" 括弧入力時の対応する括弧を表示
set showmatch

" 折返しのときにインデントがつく
set breakindent

" breakindentの記号
set showbreak=>>>

" showbreakを左端に表示する
set breakindentopt=sbr

" 画面端が3行見える状態でスクロールする
set scrolloff=3

" 最後の行を出来る限り表示する
set display=lastline

" 末尾から2行目にステータスラインを常時表示
set laststatus=2

" モードを非表示にする
set noshowmode

" ファイルが変更されたとき、再読込する
set autoread

" 保存していなくても移動できる
set hidden

" 画面の更新時間を設定(ms)
set updatetime=250

" 80文字目にラインを表示
set colorcolumn=80

" 有効なときのみ再描画する
set lazyredraw

" preview windowを表示しない
set completeopt-=preview

" ポップアップメニューを透過する
if exists('&pumblend')
    set pumblend=20
endif

" ポップアップメニューで表示する数
set pumheight=10

" 大文字/小文字の区別なく検索する
set ignorecase

" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase

" インクリメンタルサーチ
set incsearch

" 検索時に最後まで行ったら最初に戻る
set wrapscan

" ファイルを検索する際大文字/小文字を区別しない
set fileignorecase

" ファイル名補完を行う
set wildmenu

" ファイル名を補完する
set wildmode=longest,full

" ファイル名補完をポップアップで表示する
if has('nvim')
    silent! set wildoptions=pum
endif

" 置換内容を表示
if has('nvim')
    set inccommand=split
endif

set virtualedit+=block

" backspaceでの削除を有効化
set backspace=indent,eol,start

" clipboard設定
set clipboard+=unnamedplus

" undoファイルを作成する
set undofile

" スワップファイルを作成しない
set noswapfile

" バックアップファイルを作成しない
set nobackup
