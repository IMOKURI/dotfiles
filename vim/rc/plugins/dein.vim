"##### プラグインインストール #####

let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

let s:toml      = '~/.vim/rc/plugins/dein.toml'
let s:lazy_toml = '~/.vim/rc/plugins/dein_lazy.toml'

execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml(s:toml,{'lazy': 0})
  call dein#load_toml(s:lazy_toml,{'lazy': 1})

  call dein#end()
  call dein#save_state()
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

" Theme
autocmd ColorScheme * highlight Normal ctermbg=none
colorscheme tender

" Settings of lightline
let g:lightline = {
  \ 'colorscheme': 'tender',
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

" bash supportカスタムテンプレートファイル
let g:BASH_CustomTemplateFile = '~/.vim/rc/templates/bash.templates'
