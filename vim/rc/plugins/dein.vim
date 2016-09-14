"##### プラグインインストール #####

if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

let s:toml      = '~/.vim/rc/plugins/dein.toml'
let s:lazy_toml = '~/.vim/rc/plugins/dein_lazy.toml'

execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
filetype indent on
syntax on

"##### プラグイン設定 #####

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1

" Use smartcase.
let g:neocomplete#enable_smart_case = 1

" Settings of lightline
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'fugitive': 'LightLineFugitive'
  \ }
  \ }

" ステータスバーにgitのHEADのブランチを表示する関数
function! LightLineFugitive()
  try
    return exists('*fugitive#head') ? fugitive#head() : ''
  catch
  endtry
  return ''
endfunction

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
