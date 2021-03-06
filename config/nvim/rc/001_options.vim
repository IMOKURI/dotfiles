set encoding=utf-8
scriptencoding utf-8

" -----------------------------------------------------------------------------
" Neovim provider {{{
if has('nvim')
    if glob('~/.local/pipx/venvs/neovim-remote/bin/python') != ''
        let g:python3_host_prog = expand('~/.local/pipx/venvs/neovim-remote/bin/python')
    end
    let g:loaded_node_provider = 0
    let g:loaded_perl_provider = 0
    let g:loaded_python_provider = 0
    let g:loaded_ruby_provider = 0
endif
" }}}

" -----------------------------------------------------------------------------
" View {{{

" 行番号を表示
set number

" 行番号を相対位置で表示
set relativenumber

" 制御文字を表示
set list

" 制御文字を指定
set listchars=tab:→\ ,nbsp:␣,trail:-,extends:»,precedes:«

" カーソルラインをハイライト
set cursorline

" 括弧入力時の対応する括弧を表示
set showmatch

" 120文字目にラインを表示
set colorcolumn=120

" 折返しのときにインデントがつく
set breakindent

" breakindentの記号
set showbreak=↳

" showbreakを左端に表示する
set breakindentopt=sbr

" indentの階層で折りたたみを行う
set foldmethod=indent

" 折りたたみの最大の深さ
set foldnestmax=10

" 画面端が3行見える状態でスクロールする
set scrolloff=3

" ステータスラインを常に表示する
if !has('nvim')
    set laststatus=2
endif

" モードを非表示にする
set noshowmode

" 画面の更新時間を設定(ms)
set updatetime=250

" 有効なときのみ再描画する
set lazyredraw

" ポップアップメニューを透過する
if exists('&pumblend')
    set pumblend=20
endif

" ポップアップメニューで表示する数
set pumheight=10

" diffのアルゴリズムを設定
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

" 24-bit RGB colorを有効化
if has('nvim') || has('termguicolors')
    set termguicolors
endif

" 補完時の冗長な表示を抑制
set shortmess+=c

" インラインのluaをハイライトする
let g:vimsyn_embed = 'l'

" }}}

" -----------------------------------------------------------------------------
" Edit {{{

" undoファイルを作成する
set undofile

" スワップファイルを作成する
set swapfile

" バックアップファイルを作成しない
set nobackup

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

" 保存していなくても移動できる
set hidden

" 矩形選択時に文字のないところにカーソルを移動できるようにする
set virtualedit+=block

" clipboard設定
if executable('win32yank.exe')
    let g:clipboard = {
        \   'name': 'win32yank',
        \   'copy': {
        \      '+': 'win32yank.exe -i --crlf',
        \      '*': 'win32yank.exe -i --crlf',
        \    },
        \   'paste': {
        \      '+': 'win32yank.exe -o --lf',
        \      '*': 'win32yank.exe -o --lf',
        \   },
        \   'cache_enabled': 0,
        \ }
endif
set clipboard+=unnamedplus

" 補完設定
set completeopt=menuone,noselect

" }}}

" -----------------------------------------------------------------------------
" Search {{{

" 大文字/小文字の区別なく検索する
set ignorecase

" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase

" 検索時に最後まで行ったら最初に戻る
set wrapscan

" ファイルを検索する際大文字/小文字を区別しない
set fileignorecase

" 置換内容を表示
if has('nvim')
    set inccommand=split
endif

" K でカーソルしたキーワードをヘルプで引く
set keywordprg=:help

" }}}

" -----------------------------------------------------------------------------
" Completion {{{

" ファイル名を補完する
set wildmode=longest,full

" 補完ディクショナリ設定
set dictionary=/usr/share/dict/words

" }}}
