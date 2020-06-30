if !has('nvim')
    finish
endif

" completion-nvim
let g:completion_enable_snippet = 'vim-vsnip'
let g:completion_matching_ignore_case = 1
let g:completion_auto_change_source = 1

let g:completion_chain_complete_list = {
    \ 'default' : {
    \   'default': [
    \     {'complete_items': ['lsp', 'snippet', 'buffers', 'path']},
    \     {'mode': '<c-p>'},
    \     {'mode': '<c-n>'}
    \   ]
    \ },
    \ 'python': [
    \     {'complete_items': ['ts', 'lsp', 'snippet', 'buffers', 'path']},
    \     {'mode': '<c-p>'},
    \     {'mode': '<c-n>'}
    \ ]
    \ }

augroup MyAutoCmd
    autocmd BufEnter * lua require'completion'.on_attach()
augroup END

inoremap <silent><expr> <c-n> completion#trigger_completion()

" completion-buffers
let g:completion_word_min_length = 1

" nvim-treesitter
" TSInstall python
" TSInstallInfo

" nvim-lsp
lua require'nvim_lsp'.pyls.setup{}
"lua require'nvim_lsp'.jedi_language_server.setup{}

nnoremap <silent> 1gD       <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <Leader>[ <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <Leader>] <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>k <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <Leader>s <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> <Leader>z <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <c-k>     <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gD        <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gW        <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd        <cmd>lua vim.lsp.buf.declaration()<CR>
xnoremap <silent> <Leader>z <cmd>lua vim.lsp.buf.formatting()<CR>

" diagnostic-nvim
nnoremap <silent> <Leader>d :<C-u>OpenDiagnostic<CR>
nnoremap <silent> <Leader>n :<C-u>NextDiagnosticCycle<CR>
nnoremap <silent> <Leader>p :<C-u>PrevDiagnosticCycle<CR>

let g:diagnostic_enable_virtual_text = 1
