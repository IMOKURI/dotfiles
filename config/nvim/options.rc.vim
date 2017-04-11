"##### 表示設定 #####

"行番号を表示
set number

"制御文字を表示
set list

"インデントをスペース4つ分に設定
set tabstop=4
set softtabstop=4

"オートインデントで挿入される幅
set shiftwidth=4

"スマートインデント有効化
set smartindent

"カーソルラインをハイライト
set cursorline

" 括弧入力時の対応する括弧を表示
set showmatch

"最後の行を出来る限り表示する
set display=lastline

"末尾から2行目にステータスラインを常時表示
set laststatus=2

"画面の更新時間を設定(ms)
set updatetime=250

"80文字目にラインを表示
set colorcolumn=80

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
nnoremap <Esc><Esc> :<C-u>set nohlsearch!<CR>

"##### ショートカットキー設定 #####

"backspaceでの削除を有効化
set backspace=indent,eol,start

"root権限でファイルを保存する
cmap w!! w !sudo tee > /dev/null %

"help画面をqで閉じる
autocmd FileType help nnoremap <buffer> q <C-w>c

"新しいタブを開く
nnoremap <C-t> :<C-u>tabnew<CR>

"##### その他設定 #####

" マウスの無効化
set mouse-=a

" ヒストリーファイルを作成しない
let g:netrw_dirhistmax = 0
