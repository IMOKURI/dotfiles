set encoding=utf-8
scriptencoding utf-8

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
" Fold {{{

" 折りたたみを開く
nnoremap <expr> l foldclosed('.') != -1 ? 'zo' : 'l'
nnoremap <expr> L foldclosed('.') != -1 ? 'zO' : '$'
nnoremap <silent> zl zR

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

" }}}
