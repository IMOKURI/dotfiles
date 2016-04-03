
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if has('vim_starting')
  set runtimepath+=~/.vim/rc/
endif

runtime! basics/*.vim

if !empty(glob(s:dein_repo_dir.'/README.md'))
  runtime! plugins/*.vim
endif
