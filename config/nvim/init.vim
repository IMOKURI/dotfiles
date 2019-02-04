set encoding=utf-8
scriptencoding utf-8

if !exists('g:env')
  if has('win64') || has('win32') || has('win16')
    let g:env = 'WINDOWS'
  else
    let g:env = toupper(substitute(system('uname'), '\n', '', ''))
  endif
endif

if g:env =~# 'LINUX'

  let s:nvim_dir = expand('~/.config/nvim')

  let g:python_host_prog = ''
  let g:python3_host_prog = expand('~/.dotfiles/config/nvim/.venv/bin/python')

elseif g:env =~# 'WINDOWS'

  let s:nvim_dir = 'C:/Users/sugiyayo/AppData/Local/nvim'

  let g:python_host_prog = ''
  let g:python3_host_prog = 'C:\Users\sugiyayo\AppData\Local\Programs\Python\Python37-32\python'

endif

let s:dein_dir = s:nvim_dir . '/dein'
let s:toml_file = s:nvim_dir . '/dein.toml'
let s:toml_lazy_file = s:nvim_dir . '/deinlazy.toml'

let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
execute 'set runtimepath^=' . s:dein_repo_dir

" LeaderキーをSpaceに割り当て
let g:mapleader = "\<Space>"

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml(s:toml_file, {'lazy': 0})
  call dein#load_toml(s:toml_lazy_file, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

if has('nvim') || has('termguicolors')
  set termguicolors
endif

filetype plugin indent on
syntax on

runtime! theme.rc.vim
runtime! options.rc.vim
