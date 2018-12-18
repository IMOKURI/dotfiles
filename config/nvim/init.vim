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
  " ... to do Linux-specific stuff.

  let s:nvim_dir = expand('~/.config/nvim')
  let s:dein_dir = s:nvim_dir . '/dein'
  let s:toml_file = s:nvim_dir . '/dein.toml'
  let s:toml_lazy_file = s:nvim_dir . '/deinlazy.toml'

  let g:python_host_prog = substitute(system('ls /root/.virtualenvs/py2-*/bin/python'), '\n', '', 'g')
  let g:python3_host_prog = substitute(system('ls /root/.virtualenvs/py3-*/bin/python'), '\n', '', 'g')

elseif g:env =~# 'WINDOWS'
  " ... to do Windows-specific stuff.

  let s:nvim_dir = 'C:/Users/sugiyayo/AppData/Local/nvim'
  let s:dein_dir = s:nvim_dir . '/dein'
  let s:toml_file = s:nvim_dir . '/dein.toml'
  let s:toml_lazy_file = s:nvim_dir . '/deinlazy.toml'

  let g:python_host_prog = 'C:\Python27\python2'
  let g:python3_host_prog = 'C:\Users\sugiyayo\AppData\Local\Programs\Python\Python37-32\python'

elseif g:env =~# 'CYGWIN'
  " ... to do Cygwin-specific stuff.

elseif g:env =~# 'MINGW'
  " ... to do MinGW-specific stuff (Git Bash, mainly).

endif

" LeaderキーをSpaceに割り当て
let mapleader = "\<Space>"

let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

execute 'set runtimepath^=' . s:dein_repo_dir

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

if (has('termguicolors'))
  set termguicolors
endif

filetype plugin on
filetype indent on
syntax on

runtime! theme.rc.vim
runtime! options.rc.vim
