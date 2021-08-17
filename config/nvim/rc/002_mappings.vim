set encoding=utf-8
scriptencoding utf-8

" -----------------------------------------------------------------------------
" Map leader {{{
if !exists('g:mapleader')
    nnoremap <Space> <Nop>
    let g:mapleader = "\<Space>"
endif
" }}}

" -----------------------------------------------------------------------------
" File {{{

" ファイル保存
nnoremap <silent> <Leader>w <cmd>w<CR>

" すべてのバッファのファイルを保存
nnoremap <silent> <Leader><Leader>w <cmd>wa<CR>

" root権限でファイルを保存する
" cnoremap w!! w !sudo tee > /dev/null %

" windowを閉じる
nnoremap <silent> qq <cmd>close<CR>

" bufferを保存せず閉じる
nnoremap <silent> QQ <cmd>bdelete!<CR>

" 全てのタブを閉じる
nnoremap <silent> <Leader>q <cmd>qa<CR>

" すべてのタブを保存せず閉じる
nnoremap <silent> <Leader>Q <cmd>qa!<CR>

" カーソル下のディレクトリを開く
nnoremap gd :Explore <C-r><C-f><CR>

" }}}

" -----------------------------------------------------------------------------
" Terminal {{{

" ターミナルを開く
nnoremap <silent> te :terminal<CR>i

" ESCでターミナルモードからノーマルモードにする
tnoremap <silent> <ESC> <C-\><C-n>

" }}}

" -----------------------------------------------------------------------------
" Move {{{

" 表示行単位で移動する
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
xnoremap <expr> j v:count ? 'j' : 'gj'
xnoremap <expr> k v:count ? 'k' : 'gk'

" 先頭に移動する
" (末尾は L をFoldとの複合でマッピング)
nnoremap H ^
xnoremap H ^
xnoremap L $

" コマンドラインモード内を移動する
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>

" インサートモード中に移動する
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-h> <left>
inoremap <C-l> <right>

" }}}

" -----------------------------------------------------------------------------
" Buffer, Window {{{

" 直前のバッファに移動する
nnoremap <Leader><Tab> <C-^>

" ウィンドウを移動する
nnoremap <silent> <C-j> :call vimrc#move_win('j')<CR>
nnoremap <silent> <C-k> :call vimrc#move_win('k')<CR>
nnoremap <silent> <C-l> :call vimrc#move_win('l')<CR>
nnoremap <silent> <C-h> :call vimrc#move_win('h')<CR>

" }}}

" -----------------------------------------------------------------------------
" Fold {{{

" 折りたたみを開く
nnoremap <expr> l foldclosed('.') != -1 ? 'zo' : 'l'
nnoremap <expr> L foldclosed('.') != -1 ? 'zO' : '$'
nnoremap <silent> zl zR

" 折りたたみを閉じる
nnoremap <silent> , <cmd>call vimrc#smart_fold_closer()<CR>

" 現在いるところ以外の折り畳みを閉じる
nnoremap <silent> z, zMzv

" }}}

" -----------------------------------------------------------------------------
" Search, Replace {{{

" カーソル下の単語をハイライトして置換する
nmap # *:%s/<C-r>///g<Left><Left>

" 選択した文字列を検索する
xnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>")

" 選択反映を置換する
xnoremap # y:%s///g<Left><Left>

" 検索のハイライト表示を消す
nnoremap <Leader><Esc> :nohlsearch<CR>

" }}}

" -----------------------------------------------------------------------------
" Indent {{{

" インデントをコマンド1回にする
nnoremap > >>
nnoremap < <<

" }}}

" -----------------------------------------------------------------------------
" Yank, Paste {{{

" pasteモードにする
nnoremap <silent> <Leader>v <Cmd>set paste<CR>

" 1文字削除を削除レジスタにいれる
nnoremap <silent> x "_x

" }}}

" -----------------------------------------------------------------------------
" Disable {{{

" Exモード使わない
nmap Q <Nop>

" 削除してinsertモード使わない(vim-sandwichのため)
nmap s <Nop>
xmap s <Nop>

" }}}
