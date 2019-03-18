set encoding=utf-8
scriptencoding utf-8

filetype off
filetype plugin indent off

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

if g:env =~# 'LINUX'
  let s:nvim_dir = expand('~/.config/nvim')
  let g:python_host_prog = '/usr/bin/python2'
  let g:python3_host_prog = s:nvim_dir . '/.venv/bin/python'

elseif g:env =~# 'WINDOWS'
  let s:nvim_dir = '$USERPROFILE/AppData/Local/nvim'
  let g:python_host_prog = ''
  let g:python3_host_prog = s:nvim_dir . '/.venv/Scripts/python'
  set shell=\"C:/Program\ Files/Git/bin/bash.exe\"

endif

let g:mapleader = "\<Space>"
let g:maplocalleader = '\'

" -----------------------------------------------------------------------------
" Plugin settings
" -----------------------------------------------------------------------------
let s:dein_dir = s:nvim_dir . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
execute 'set runtimepath^=' . s:dein_repo_dir

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

function! s:t9md_vim_quickhl()
  nmap <silent> <Leader>m <Plug>(quickhl-manual-this)
  xmap <silent> <Leader>m <Plug>(quickhl-manual-this)
  nnoremap <silent> <Leader>M :<C-u>QuickhlManualReset<CR>
endfunction

function! s:ttpope_vim_fugitive()
  nnoremap <silent> <Leader>s :<C-u>Gstatus<CR>
  nnoremap <silent> <Leader>d :<C-u>Gdiff<CR>
endfunction

function! s:xolox_vim_session()
  let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
  if isdirectory(s:local_session_directory)
    let g:session_directory = s:local_session_directory
    let g:session_autosave = 'yes'
    let g:session_autoload = 'yes'
    let g:session_autosave_periodic = 1
  else
    let g:session_autosave = 'no'
    let g:session_autoload = 'no'
  endif
  unlet s:local_session_directory
endfunction

function! s:shougo_deoplete_nvim()
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#auto_complete_delay = 0
  let g:deoplete#auto_complete_start_length = 1
endfunction

function! s:neomake_neomake_hook_add()
  augroup neomake
    autocmd!
    autocmd InsertLeave,BufWritePost * Neomake
  augroup END
endfunction

function! s:neomake_neomake_hook_source()
  let g:neomake_open_list = 2
  let g:neomake_error_sign = {'text': 'E>', 'texthl': 'NeomakeErrorSign'}
  let g:neomake_warning_sign = {'text': 'W>', 'texthl': 'NeomakeWarningSign',}
  let g:neomake_info_sign = {'text': 'I>', 'texthl': 'NeomakeInfoSign'}
  let g:neomake_shellcheck_args = ['-fgcc']
endfunction

function! s:sbdchd_neoformat_hook_add()
  nnoremap <silent> <Leader>n :Neoformat<CR>
endfunction

function! s:sbdchd_neoformat_hook_source()
  let g:neoformat_basic_format_align = 1
  let g:neoformat_basic_format_retab = 1
  let g:neoformat_basic_format_trim = 1
endfunction

function! s:shougo_denite_nvim_hook_add()
  nnoremap <silent> <Leader>p :Denite file_rec<CR>
  nnoremap <silent> <Leader>g :Denite grep<CR>
endfunction

function! s:shougo_denite_nvim_hook_source()
  if executable('rg')
    call denite#custom#var('file_rec', 'command',
          \ ['rg', '--files', '--glob', '!.git'])
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'final_opts', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'default_opts',
          \ ['--vimgrep', '--no-heading'])
  endif

  call denite#custom#map('insert', '<C-j>',
        \ '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('insert', '<C-k>',
        \ '<denite:move_to_previous_line>', 'noremap')

  call denite#custom#option('default', 'prompt', '>')
endfunction

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#add('Shougo/dein.vim')

  call dein#add('challenger-deep-theme/vim')
  call dein#add('jacoborus/tender.vim')
  call dein#add('itchyny/lightline.vim')

  call dein#add('t9md/vim-quickhl', {
        \ 'hook_add': function('s:t9md_vim_quickhl')
        \ })

  call dein#add('airblade/vim-gitgutter')
  call dein#add('tpope/vim-fugitive', {
        \ 'hook_add': function('s:ttpope_vim_fugitive')
        \ })

  call dein#add('tpope/vim-sleuth')

  call dein#add('xolox/vim-misc')
  call dein#add('xolox/vim-session', {
        \ 'depends': 'vim-misc',
        \ 'hook_add': function('s:xolox_vim_session')
        \ })

  call dein#add('Shougo/deoplete.nvim', {
        \ 'on_i': 1,
        \ 'hook_source': function('s:shougo_deoplete_nvim')
        \ })

  call dein#add('zchee/deoplete-jedi', {
        \ 'depends': 'deoplete.nvim',
        \ 'on_ft': 'python'
        \ })
  call dein#add('Vimjas/vim-python-pep8-indent', {
        \ 'on_i': 1,
        \ 'on_ft': 'python'
        \ })

  call dein#add('neomake/neomake', {
        \ 'hook_add': function('s:neomake_neomake_hook_add'),
        \ 'hook_source': function('s:neomake_neomake_hook_source')
        \ })

  call dein#add('sbdchd/neoformat', {
        \ 'hook_add': function('s:sbdchd_neoformat_hook_add'),
        \ 'hook_source': function('s:sbdchd_neoformat_hook_source')
        \ })

  call dein#add('Shougo/denite.nvim', {
        \ 'on_cmd': 'Denite',
        \ 'hook_add': function('s:shougo_denite_nvim_hook_add'),
        \ 'hook_source': function('s:shougo_denite_nvim_hook_source')
        \ })

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
  call dein#remote_plugins()
endif

command! DeinUpdate if dein#check_update() | call dein#update() | endif
command! DeinClean call map(dein#check_clean(), "delete(v:val, 'rf')") | call dein#recache_runtimepath()

" -----------------------------------------------------------------------------
" Color schema
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

let g:lightline = {
      \ 'colorscheme': 'tender',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive'
      \ }
      \ }

if has('gui_running')
  Guifont! Migu 1M:h12
endif

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

augroup nopaste_when_insert_leave
  autocmd!
  autocmd InsertLeave * set nopaste
augroup END

function! ToggleQuickFix()
  let l:nr_current = winnr('$')
  cwindow
  let l:nr_quickfix = winnr('$')
  if l:nr_current == l:nr_quickfix
    cclose
  endif
endfunction
nnoremap <script> <silent> <Leader>c :call ToggleQuickFix()<CR>

function! ToggleLocationList()
  let l:nr_current = winnr('$')
  lwindow
  let l:nr_location = winnr('$')
  if l:nr_current == l:nr_location
    lclose
  endif
endfunction
nnoremap <script> <silent> <Leader>l :call ToggleLocationList()<CR>

" Location Listのエラーに移動する
nnoremap <silent> <C-p> :<C-u>lprevious<CR>
nnoremap <silent> <C-n> :<C-u>lnext<CR>

" -----------------------------------------------------------------------------
" Mapping
" -----------------------------------------------------------------------------
" カレントディレクトリでExploreを開く
nnoremap <silent> <Leader>e :E %:h<CR>

" ctagsを生成する
nnoremap <silent> <Leader>t :!ctags -R -f tags<CR>

" ファイル保存
nnoremap <silent> <Leader>w :<C-u>w<CR>

" root権限でファイルを保存する
nnoremap <silent> <Leader><Leader>w :<C-u>w !sudo tee > /dev/null %<CR>

" windowを閉じる
nnoremap <silent> qq :<C-u>close<CR>

" 全てのタブを閉じる
nnoremap <silent> <Leader>q :<C-u>qa<CR>

" 新しいタブを開く
nnoremap <silent> gt :<C-u>tabnew<CR>

" タブを移動する
nnoremap gn gt
nnoremap gp gT

" ESCでターミナルモードからコマンドモードにする
tnoremap <silent> <ESC> <C-\><C-n>

" インデントをコマンド1回にする
nnoremap > >>
nnoremap < <<

" 加算減算
nnoremap + <C-a>
nnoremap - <C-x>

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
nnoremap <C-w>- <C-w>s
nnoremap <C-w><bar> <C-w>v

" 検索結果のハイライトをEsc連打でクリアする
nnoremap <Esc><Esc> :<C-u>set nohlsearch!<CR>

" カーソル下の単語をハイライトして置換する
nmap # <Leader>h:%s/<C-r>///g<Left><Left>

" バッファ内で置換する
nnoremap S :%s//g<LEFT><LEFT>

" -----------------------------------------------------------------------------
" Options
" -----------------------------------------------------------------------------
" 文字コード判別
set fileencodings=utf-8,sjis,iso-2022-jp,euc-jp

" □や○文字が崩れる問題を解決
set ambiwidth=double

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

" 括弧入力時の対応する括弧を表示
set showmatch

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

" 画面の更新時間を設定(ms)
set updatetime=250

" 80文字目にラインを表示
set colorcolumn=80

" 有効なときのみ再描画する
set lazyredraw

" ポップアップメニューを透過する
if exists('&pumblend')
  set pumblend=20
endif

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
  set wildoptions=pum
endif

" 置換内容を表示
if has('nvim')
  set inccommand=split
endif

" backspaceでの削除を有効化
set backspace=indent,eol,start

" clipboard設定
set clipboard+=unnamed

" スワップファイルを作成しない
set noswapfile

" バックアップファイルを作成しない
set nobackup

" ヒストリーファイルを作成しない
let g:netrw_dirhistmax = 0
