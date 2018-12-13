"##### 文字コード設定 #####

" 文字コード判別
set encoding=utf-8
set fileencodings=utf-8,sjis,iso-2022-jp,euc-jp

" vim script内でマルチバイトを使う設定
scriptencoding utf-8

" □や○文字が崩れる問題を解決
set ambiwidth=double

"##### 表示設定 #####

" 行番号を表示
set number

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

" 画面端が5行見える状態でスクロールする
set scrolloff=5

" 最後の行を出来る限り表示する
set display=lastline

" 末尾から2行目にステータスラインを常時表示
set laststatus=2

" モードを非表示にする
set noshowmode

" 画面の更新時間を設定(ms)
set updatetime=250

" 80文字目にラインを表示
set colorcolumn=80

" 有効なときのみ再描画する
set lazyredraw

"##### 検索設定 #####

" 大文字/小文字の区別なく検索する
set ignorecase

" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase

" インクリメンタルサーチ
set incsearch

" 「次の（前の）検索候補」を画面の中心に表示する
nnoremap n nzz
nnoremap N Nzz

" 検索時に最後まで行ったら最初に戻る
set wrapscan

" 検索結果のハイライトをEsc連打でクリアする
nnoremap <Esc><Esc> :<C-u>set nohlsearch!<CR>

" ファイルを検索する際大文字/小文字を区別しない
set fileignorecase

"##### ショートカットキー設定 #####

" backspaceでの削除を有効化
set backspace=indent,eol,start

" root権限でファイルを保存する
cnoremap w!! w !sudo tee > /dev/null %

" 常に全てのタブを閉じる
cmap q qa

" help画面をqで閉じる
augroup help_quit
      autocmd!
      autocmd FileType help nnoremap <buffer> q <C-w>c
augroup END

" 新しいタブを開く
nnoremap st :<C-u>tabnew<CR>

" タブを移動する
nnoremap sn gt
nnoremap sp gT

" ESCでターミナルモードからコマンドモードにする
tnoremap <silent> <ESC> <C-\><C-n>

" インデントをコマンド1回にする
nnoremap > >>
nnoremap < <<

" 表示行単位で移動する
nnoremap j gj
nnoremap k gk

"##### その他設定 #####

" マウスの無効化
set mouse-=a

" clipboard設定
set clipboard+=unnamed

" カーソル位置記憶
augroup remember_cursor
      autocmd!
      autocmd BufReadPost *
            \ if line("'\"") > 0 && line ("'\"") <= line("$") |
            \   exe "normal! g'\"" |
            \ endif
augroup END

" ヒストリーファイルを作成しない
let g:netrw_dirhistmax = 0
