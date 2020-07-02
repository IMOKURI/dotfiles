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
    \ 'bash': [
    \     {'complete_items': ['ts', 'lsp', 'snippet', 'buffers', 'path']},
    \     {'mode': '<c-p>'},
    \     {'mode': '<c-n>'}
    \ ],
    \ 'json': [
    \     {'complete_items': ['ts', 'lsp', 'buffers', 'path']},
    \     {'mode': '<c-p>'},
    \     {'mode': '<c-n>'}
    \ ],
    \ 'lua': [
    \     {'complete_items': ['ts', 'buffers', 'path']},
    \     {'mode': '<c-p>'},
    \     {'mode': '<c-n>'}
    \ ],
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

lua <<EOF
-- nvim-treesitter
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
    },
    ensure_installed = {
        'bash',
        'json',
        'lua',
        'python'
    }
}

-- nvim-lsp
local on_attach_vim = function()
    require'completion'.on_attach()
    require'diagnostic'.on_attach()
end

local nvim_lsp = require'nvim_lsp'

nvim_lsp.bashls.setup{on_attach=on_attach_vim}

nvim_lsp.dockerls.setup{on_attach=on_attach_vim}

-- nvim_lsp.jedi_language_server.setup{on_attach=on_attach_vim}

nvim_lsp.vimls.setup{on_attach=on_attach_vim}

nvim_lsp.diagnosticls.setup{
    on_attach = on_attach_vim,
    filetypes = {
        'json',
        'sh'
    },
    init_options = {
        formatters = {
            jq = {
                command = "jq",
                args = {"--indent", "4", "."}
            },
            shfmt = {
                command = "shfmt",
                args = {"-i", "4", "-sr", "-ci"}
            }
        },
        formatFiletypes = {
            json = "jq",
            sh = "shfmt"
        }
    }

}

nvim_lsp.pyls.setup{
    on_attach = on_attach_vim,
    settings = {
        pyls = {
            plugins = {
                pycodestyle = {
                    enabled = true,
                    maxLineLength = 120
                },
                pylint = {
                    enabled = true,
                    args = {
                        '--max-line-length=120',
                        '--disable=invalid-name'
                    }
                }
            }
        }
    }
}

nvim_lsp.yamlls.setup{
    on_attach = on_attach_vim,
    settings = {
        yaml = {
            format = {
                enable = true
            },
            validate = true,
            hover = true,
            completion = true
        }
    }
}
EOF

nnoremap <silent> 1gD       <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <Leader>[ <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <Leader>] <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>k <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <Leader>s <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> <Leader>z <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <Leader>K <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gD        <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gW        <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd        <cmd>lua vim.lsp.buf.declaration()<CR>
xnoremap <silent> <Leader>z <cmd>lua vim.lsp.buf.formatting()<CR>

" diagnostic-nvim
command! -buffer -nargs=0 ShowLineDiagnostics lua require'jumpLoc'.openLineDiagnostics()
nnoremap <silent> <Leader>d <cmd>ShowLineDiagnostic<CR>
nnoremap <silent> <Leader>D <cmd>OpenDiagnostic<CR>
nnoremap <silent> <Leader>n <cmd>NextDiagnosticCycle<CR>
nnoremap <silent> <Leader>p <cmd>PrevDiagnosticCycle<CR>

let g:diagnostic_enable_virtual_text = 1
