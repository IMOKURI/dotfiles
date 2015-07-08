
"##### 表示設定 #####

"編集中のファイル名を表示
set title

"行番号を表示
set number

"コードの色分け
syntax on

"インデントをスペース4つ分に設定
set tabstop=4

"オートインデント無効化
set noautoindent

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
NeoBundle 'Shougo/vimproc.vim', {'build': {'unix': 'make -f make_unix.mak'}}
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'kana/vim-filetype-haskell'
NeoBundle 'ujihisa/neco-ghc'
NeoBundle 'eagletmt/ghcmod-vim'

call neobundle#end()

filetype plugin indent on       " restore filetype


NeoBundleCheck

"##### プラグイン設定 #####

" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1

" Use smartcase.
let g:neocomplcache_enable_smart_case = 1

