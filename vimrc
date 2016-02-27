
"##### 表示設定 #####

"編集中のファイル名を表示
set title

"現在のモードを表示
set showmode

"行番号を表示
set number

"カラースキーマ設定
colorscheme elflord

"コードの色分け
syntax on

"インデントをスペース2つ分に設定
set tabstop=2

"タブをスペース2つ分に設定
set softtabstop=2

"オートインデント有効化
"ペースト時はインデントが入らないよう「:a!」でペーストモードにする
set autoindent

"スマートインデント有効化
set smartindent

"タブの代わりにスペースを使う
set expandtab

"スマートタブ有効化
set smarttab

"インデント1つにつき使うスペースの数
set shiftwidth=2

"改行時の自動コメントアウトを無効化
autocmd FileType * setlocal formatoptions-=ro

" 括弧入力時の対応する括弧を表示
set showmatch

" 対応する括弧の表示時間を2にする
set matchtime=2

"最後の行を出来る限り表示する
set display=lastline


"##### 検索設定 #####

"大文字/小文字の区別なく検索する
set ignorecase

"検索文字列に大文字が含まれている場合は区別して検索する
set smartcase

"インクリメンタルサーチ
set incsearch

"「次の（前の）検索候補」を画面の中心に表示する
nnoremap n nzz
nnoremap N Nzz

"検索時に最後まで行ったら最初に戻る
set wrapscan

"検索結果のハイライトをEsc連打でクリアする
nnoremap <ESC><ESC> :nohlsearch<CR>


"##### その他設定 #####

"ビープ音OFF
set vb t_vb=

"swpファイル出力先変更
set directory=~/.vim/swp//

"##### プラグインインストール #####

set nocompatible
filetype off  " for NeoBundle

if has('vim_starting')
  set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundleFetch 'Shougo/neobundle-vim-recipes', {'force' : 1}

" NeoBundleのプラグインインストール
NeoBundle 'Shougo/vimproc.vim', {'build': {'unix': 'make -f make_unix.mak'}}  " 非同期処理

NeoBundle 'Shougo/neocomplcache.vim'    " 入力補完 neo-completion with cache

NeoBundle 'Shougo/neosnippet'           " スニペット
NeoBundle 'Shougo/neosnippet-snippets'

NeoBundle 'Shougo/unite.vim'            " 統合ユーザインターフェース

NeoBundle 'ujihisa/unite-colorscheme'   " カラースキーマ一覧表示

NeoBundle 'neovimhaskell/haskell-vim'   " Haskell シンタックスハイライト＆インデント
NeoBundle 'ujihisa/neco-ghc'            " Haskell 入力補完
NeoBundle 'eagletmt/ghcmod-vim'         " Haskell 構文チェック

NeoBundle 'ConradIrwin/vim-bracketed-paste'  " ペースト時に自動的にpaste modeになる

call neobundle#end()

filetype plugin indent on
filetype indent on
syntax on

NeoBundleCheck

"##### プラグイン設定 #####

" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1

" Use smartcase.
let g:neocomplcache_enable_smart_case = 1

" *.hsのファイルを保存したときにコンパイルエラー・ワーニングをチェックする
" 開いたquickfixの画面は :ccl で閉じる
" 開いたquickfixの画面には :copen で移動する
autocmd BufWritePost *.hs GhcModCheckAndLintAsync

" <Space>g をghcmod-vimプラグインのprefixキーにする
nnoremap [ghcmod] <Nop>
nmap     <Space>g [ghcmod]

" <Space>gt を :GhcModType に割り当てる
nnoremap <silent> [ghcmod]t :GhcModType<CR>

" <Space>gc を :GhcModTypeClear に割り当てる
nnoremap <silent> [ghcmod]c :GhcModTypeClear<CR>

