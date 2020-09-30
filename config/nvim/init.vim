set encoding=utf-8
scriptencoding utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp-3,euc-jp,cp932

let $MYVIMRCDIR = expand('<sfile>:p:h')
call map(sort(split(glob($MYVIMRCDIR . '/rc/*.vim'))), {->[execute('exec "so" v:val')]})

lua require('init')

filetype plugin indent on
syntax enable

colorscheme challenger_deep
