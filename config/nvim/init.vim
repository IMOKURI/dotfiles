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

  " LeaderキーをSpaceに割り当て
  let mapleader = "\<Space>"

  let s:dein_dir = expand('~/.config/nvim/dein')
  let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

  execute 'set runtimepath^=' . s:dein_repo_dir

  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
    call dein#load_toml('~/.config/nvim/deinlazy.toml', {'lazy': 1})

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
  runtime! plugins.rc.vim

elseif g:env =~# 'WINDOWS'
  " ... to do Windows-specific stuff.

elseif g:env =~# 'CYGWIN'
  " ... to do Cygwin-specific stuff.

elseif g:env =~# 'MINGW'
  " ... to do MinGW-specific stuff (Git Bash, mainly).

endif

runtime! options.rc.vim
