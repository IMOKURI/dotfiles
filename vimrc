" Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

set packpath^=$HOME/.config/nvim
set packpath+=$HOME/.config/nvim/after
set runtimepath^=$HOME/.config/nvim
set runtimepath+=$HOME/.config/nvim/after

source $HOME/.config/nvim/init.vim
