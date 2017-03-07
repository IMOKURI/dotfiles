"##### 表示設定 #####

"編集中のファイル名を表示
set title

"現在のモードを表示
set showmode

"行番号を表示
set number

"カーソルラインをハイライト
set cursorline

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
"set expandtab

"スマートタブ有効化
"set smarttab

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

"末尾から2行目にステータスラインを常時表示
set laststatus=2

"画面の更新時間を設定(ms)
set updatetime=250

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

"スペース2回で単語をハイライトする
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>

"#で、単語をハイライトして、置換する
nmap # <Space><Space>:%s/<C-r>///g<Left><Left>

"##### その他設定 #####

"ビープ音OFF
set vb t_vb=


"##### ショートカットキー設定 #####

"backspaceでの削除を有効化
set backspace=indent,eol,start

"root権限でファイルを保存する
cmap w!! w !sudo tee > /dev/null %

"help画面をqで閉じる
autocmd FileType help nnoremap <buffer> q <C-w>c

"新しいタブを開く
nnoremap <C-t> :<C-u>tabnew<CR>
