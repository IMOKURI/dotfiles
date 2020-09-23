local M = {}

local home_dir = os.getenv("HOME")

function M.setup()
end

function M.config()
    local lsp_status = require("lsp-status")
    lsp_status.register_progress()

    local nvim_lsp = require("nvim_lsp")

    local on_attach_vim = function(client)
        local completion = require("completion")
        local diagnostic = require("diagnostic")

        completion.on_attach(client)
        diagnostic.on_attach()
        lsp_status.on_attach(client)
    end

    nvim_lsp.bashls.setup{
        capabilities = lsp_status.capabilities,
        on_attach=on_attach_vim,
    }
    nvim_lsp.dockerls.setup{
        capabilities = lsp_status.capabilities,
        on_attach=on_attach_vim,
    }
    nvim_lsp.terraformls.setup{
        capabilities = lsp_status.capabilities,
        on_attach=on_attach_vim,
    }
    nvim_lsp.vimls.setup{
        capabilities = lsp_status.capabilities,
        on_attach=on_attach_vim,
    }

    nvim_lsp.diagnosticls.setup{
        capabilities = lsp_status.capabilities,
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

    nvim_lsp.sumneko_lua.setup{
        capabilities = lsp_status.capabilities,
        on_attach = on_attach_vim,
        cmd = {
            home_dir .. "/src/lua-language-server/bin/Linux/lua-language-server",
            "-E",
            home_dir .. "/src/lua-language-server/main.lua"
        },
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    path = vim.split(package.path, ';'),
                },
                diagnostics = {
                    enable = true,
                    globals = vim.list_extend(
                        {
                            "use",
                            "vim",
                        },
                        {}
                    )
                }
            }
        }
    }

    nvim_lsp.pyls.setup{
        capabilities = lsp_status.capabilities,
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
                    },
                    pyls_isort = {
                        enabled = true
                    },
                    pyls_black = {
                        enabled = true,
                        line_length = 120
                    }
                }
            }
        }
    }

    nvim_lsp.yamlls.setup{
        capabilities = lsp_status.capabilities,
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
end

return M
