
let g:ansible_unindent_after_newline = 1
let g:ansible_extra_keywords_highlight = 1
let g:ansible_template_syntaxes = {'*.yaml.j2': 'yaml', '*.yml.j2': 'yaml'}

function! GoTaskFile()
    let l:task_file = "roles/" . expand("<cfile>") . "/tasks/main.y*ml"
    let l:found_task_file = split(glob(l:task_file), "\n")
    if len(l:found_task_file) == 0
        echo l:task_file . " not found"
    else
        execute "edit " . fnameescape(remove(l:found_task_file, 0))
    endif
endfunction

augroup MyAutoCmd
    autocmd FileType yaml nnoremap <silent> <leader>gf :call GoTaskFile()<CR>
    autocmd FileType yaml xnoremap <silent> <leader>gf :call GoTaskFile()<CR>
augroup END
