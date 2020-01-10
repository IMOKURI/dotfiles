if exists('did_load_filetypes')
    finish
endif

augroup filetypedetect
    " Dockerfile
    autocmd BufNewFile,BufRead Dockerfile.*
        \ setfiletype dockerfile

    " Jenkinsfile
    autocmd BufNewFile,BufRead .*Jenkinsfile
        \ setfiletype Jenkinsfile

augroup END
