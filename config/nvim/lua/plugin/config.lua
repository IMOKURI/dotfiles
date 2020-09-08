vim.g.completion_enable_snippet = 'vim-vsnip'
vim.g.completion_matching_ignore_case = 1
vim.g.completion_auto_change_source = 1

vim.g.completion_chain_complete_list = {
    default = {
        default = {
            {complete_items = {'lsp', 'snippet', 'buffers', 'path'}},
            {mode = '<c-p>'},
            {mode = '<c-n>'}
        }
    },
    bash = {
        {complete_items = {'ts', 'lsp', 'snippet', 'buffers', 'path'}},
        {mode = '<c-p>'},
        {mode = '<c-n>'}
    },
    json = {
        {complete_items = {'ts', 'lsp', 'buffers', 'path'}},
        {mode = '<c-p>'},
        {mode = '<c-n>'}
    },
    lua = {
        {complete_items = {'ts', 'buffers', 'path'}},
        {mode = '<c-p>'},
        {mode = '<c-n>'}
    },
    python = {
        {complete_items = {'ts', 'lsp', 'snippet', 'buffers', 'path'}},
        {mode = '<c-p>'},
        {mode = '<c-n>'}
    }
}

vim.api.nvim_command('augroup MyAutoCmd')
vim.api.nvim_command("autocmd BufEnter * lua require'completion'.on_attach()")
vim.api.nvim_command('augroup END')

vim.api.nvim_command('inoremap <silent><expr> <c-n> completion#trigger_completion()')

-- completion-buffers
vim.g.completion_word_min_length = 1

-- nvim-treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        'bash',
        'json',
        'lua',
        'python'
    },
    highlight = {
        enable = true,
    },
    refactor = {
        highlight_definitions = {
            enable = true
        },
        highlight_current_scope = {
            enable = true
        },
    },
}

-- nvim-lsp
local on_attach_vim = function()
    require'completion'.on_attach()
    require'diagnostic'.on_attach()
end

local nvim_lsp = require'nvim_lsp'

nvim_lsp.bashls.setup{on_attach=on_attach_vim}

nvim_lsp.dockerls.setup{on_attach=on_attach_vim}

nvim_lsp.terraformls.setup{on_attach=on_attach_vim}

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
                        '--init-hook="import pylint_venv; pylint_venv.inithook(force_venv_activation=True)"',
                        '--max-line-length=120',
                        '--disable=invalid-name,missing-docstring'
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

vim.api.nvim_command('nnoremap <silent> 1gD       <cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.api.nvim_command('nnoremap <silent> <Leader>[ <cmd>lua vim.lsp.buf.references()<CR>')
vim.api.nvim_command('nnoremap <silent> <Leader>] <cmd>lua vim.lsp.buf.definition()<CR>')
vim.api.nvim_command('nnoremap <silent> <Leader>d <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
vim.api.nvim_command('nnoremap <silent> <Leader>k <cmd>lua vim.lsp.buf.hover()<CR>')
vim.api.nvim_command('nnoremap <silent> <Leader>s <cmd>lua vim.lsp.buf.document_symbol()<CR>')
vim.api.nvim_command('nnoremap <silent> <Leader>z <cmd>lua vim.lsp.buf.formatting()<CR>')
vim.api.nvim_command('nnoremap <silent> <Leader>K <cmd>lua vim.lsp.buf.signature_help()<CR>')
vim.api.nvim_command('nnoremap <silent> gD        <cmd>lua vim.lsp.buf.implementation()<CR>')
vim.api.nvim_command('nnoremap <silent> gW        <cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
vim.api.nvim_command('nnoremap <silent> gd        <cmd>lua vim.lsp.buf.declaration()<CR>')
vim.api.nvim_command('xnoremap <silent> <Leader>z <cmd>lua vim.lsp.buf.formatting()<CR>')

-- diagnostic-nvim
vim.api.nvim_command('nnoremap <silent> <Leader>D <cmd>OpenDiagnostic<CR>')
vim.api.nvim_command('nnoremap <silent> <Leader>n <cmd>NextDiagnosticCycle<CR>')
vim.api.nvim_command('nnoremap <silent> <Leader>p <cmd>PrevDiagnosticCycle<CR>')

vim.g.diagnostic_enable_virtual_text = 1
