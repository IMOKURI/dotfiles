set encoding=utf-8
scriptencoding utf-8

"##### 文字コード設定 #####

" 文字コード判別
set fileencodings=utf-8,sjis,iso-2022-jp,euc-jp

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

" ポップアップメニューを透過する
if exists('&pumblend')
      set pumblend=20
endif

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

" ファイル名を補完する
set wildmode=longest,full

" 置換内容を表示
set inccommand=split

"##### ショートカットキー設定 #####

" backspaceでの削除を有効化
set backspace=indent,eol,start

" ファイル保存
nnoremap <silent> <Leader>w :<C-u>w<CR>

" root権限でファイルを保存する
nnoremap <silent> <Leader><Leader>w :<C-u>w !sudo tee > /dev/null %<CR>

" 常に全てのタブを閉じる
cnoremap q qa

" windowを閉じる
nnoremap <silent> <Leader>q :<C-u>close<CR>

" 新しいタブを開く
nnoremap <silent> st :<C-u>tabnew<CR>

" タブを移動する
nnoremap sn gt
nnoremap sp gT

" ESCでターミナルモードからコマンドモードにする
tnoremap <silent> <ESC> <C-\><C-n>

" インデントをコマンド1回にする
nnoremap > >>
nnoremap < <<

" 加算減算
nnoremap + <C-a>
nnoremap - <C-x>

" 表示行単位で移動する
nnoremap j gj
nnoremap k gk

" バッファを移動する
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" カーソル下の単語をハイライトする
nnoremap <silent> <Leader>h "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>

" カーソル下の単語をハイライトして置換する
nmap # <Leader>h:%s/<C-r>///g<Left><Left>

" バッファ内で置換する
nnoremap S :%s//g<LEFT><LEFT>

" Quick Fixのtoggle
function! ToggleQuickFix()
      let l:nr_current = winnr('$')
      cwindow
      let l:nr_quickfix = winnr('$')
      if l:nr_current == l:nr_quickfix
            cclose
      endif
endfunction
nnoremap <script> <silent> <Leader>c :call ToggleQuickFix()<CR>

" Location Listのtoggle
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

"##### その他設定 #####

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

" インサートモードから抜けるときにpasteモード解除
augroup insert_leave
      autocmd!
      autocmd InsertLeave * set nopaste
augroup END

" ヒストリーファイルを作成しない
let g:netrw_dirhistmax = 0
