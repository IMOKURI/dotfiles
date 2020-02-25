if exists('did_load_filetypes')
    finish
endif

augroup filetypedetect
    " Dockerfile
    autocmd BufNewFile,BufRead Dockerfile.*
        \ setfiletype dockerfile

    autocmd BufNewFile,BufRead *.csv
        \ setfiletype csv

augroup END
