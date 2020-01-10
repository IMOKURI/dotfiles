set encoding=utf-8
scriptencoding utf-8

" -----------------------------------------------------------------------------
" File {{{

" ファイル保存
nnoremap <silent> <Leader>w :<C-u>w<CR>

" すべてのバッファのファイルを保存
nnoremap <silent> <Leader><Leader>w :<C-u>wa<CR>

" root権限でファイルを保存する
cnoremap w!! w !sudo tee > /dev/null %

" windowを閉じる
nnoremap <silent> qq :<C-u>close<CR>

" 全てのタブを閉じる
nnoremap <silent> <Leader>q :<C-u>qa<CR>

" すべてのタブを保存せず閉じる
nnoremap <silent> <Leader>Q :<C-u>qa!<CR>

" カーソル下のディレクトリを開く
nnoremap gd :Explore <C-r><C-f><CR>

" }}}

" -----------------------------------------------------------------------------
" Tab {{{

" 新しいタブを開く
nnoremap <silent> gt :<C-u>tabnew<CR>

" タブを移動する
nnoremap gn gt
nnoremap gp gT

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
nnoremap j gj
nnoremap k gk
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" 先頭に移動する
" (末尾は L をFoldとの複合でマッピング)
noremap H ^

" コマンドラインモード内を移動する
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

" インサートモード中に移動する
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-b> <left>
inoremap <C-f> <right>

" }}}

" -----------------------------------------------------------------------------
" Buffer, Window {{{

" 直前のバッファに移動する
nnoremap <Leader><Tab> <C-^>

" ウィンドウを移動する
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
if has('nvim')
    " TERM環境変数が悪そう
    nnoremap <BS> <C-w>h
else
    nnoremap <C-h> <C-w>h
endif

" ウィンドウを分割する
nnoremap <Leader>- <C-w>s
nnoremap <Leader><bar> <C-w>v

" ウィンドウの大きさを変更する
nnoremap <Leader><Up> <C-w>+
nnoremap <Leader><Down> <C-w>-
nnoremap <Leader><Right> <C-w>>
nnoremap <Leader><Left> <C-w><

" }}}

" -----------------------------------------------------------------------------
" Fold {{{

" 折りたたみを開く
nnoremap <expr> l foldclosed('.') != -1 ? 'zo' : 'l'
nnoremap <expr> L foldclosed('.') != -1 ? 'zO' : '$'
nnoremap <silent> zl zR

" 折りたたみを閉じる
nnoremap <silent> , :<C-u>call vimrc#smart_fold_closer()<CR>

" 現在いるところ以外の折り畳みを閉じる
nnoremap <silent> z, zMzv

" }}}

" -----------------------------------------------------------------------------
" Search, Replace {{{

" カーソル下の単語をハイライトして置換する
nmap # *:%s/<C-r>///g<Left><Left>

" バッファ内で置換する
nnoremap S :%s//g<LEFT><LEFT>

" }}}

" -----------------------------------------------------------------------------
" Indent {{{

" インデントをコマンド1回にする
nnoremap > >>
nnoremap < <<

" }}}

" -----------------------------------------------------------------------------
" Mark, Registry {{{

" マークをリストアップして{保存,復旧}する
nnoremap <expr> m  vimrc#hint_cmd_output('m', 'marks')
nnoremap <expr> `  vimrc#hint_cmd_output('`', 'marks') . 'zz'

" レジストリをリストアップする
nnoremap <expr> " vimrc#hint_cmd_output('"', 'registers')

" }}}

" -----------------------------------------------------------------------------
" Disable {{{

" Exモード使わない
nmap Q <Nop>

" }}}

" vim:set foldmethod=marker:
