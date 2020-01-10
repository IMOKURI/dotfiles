
syntax on

autocmd MyAutoCmd FileType,Syntax,BufNewFile,BufNew,BufRead *?
    \ call vimrc#on_filetype()

if has('vim_starting') && !empty(argv())
    call vimrc#on_filetype()
endif

colorscheme challenger_deep
