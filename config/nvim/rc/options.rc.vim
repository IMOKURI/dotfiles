set encoding=utf-8
scriptencoding utf-8

" -----------------------------------------------------------------------------
" Options {{{

" 文字コード判別
set fileencodings=ucs-bom,utf-8,iso-2022-jp-3,euc-jp,cp932

" }}}

" -----------------------------------------------------------------------------
" View {{{

" 行番号を表示
set number

" 行番号を相対位置で表示
set relativenumber

" 制御文字を表示
set list

" カーソルラインをハイライト
set cursorline

" 括弧入力時の対応する括弧を表示
set showmatch

" 80文字目にラインを表示
set colorcolumn=80

" 折返しのときにインデントがつく
set breakindent

" breakindentの記号
set showbreak=(//_//)

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
set clipboard+=unnamedplus

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

" }}}

" -----------------------------------------------------------------------------
" Completion {{{

" ファイル名を補完する
set wildmode=longest,full

" 補完ディクショナリ設定
set dictionary=/usr/share/dict/words

" 補完時にpreviewを表示しない
set completeopt-=preview

" }}}

" -----------------------------------------------------------------------------
" Netrw {{{

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

" }}}

" vim:set foldmethod=marker:
