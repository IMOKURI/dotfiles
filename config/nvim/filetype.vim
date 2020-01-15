if exists('did_load_filetypes')
    finish
endif

augroup filetypedetect
    " Dockerfile
    autocmd BufNewFile,BufRead Dockerfile.*
        \ setfiletype dockerfile

augroup END
