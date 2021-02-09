local M = {}
local h = require("helper")

local home_dir = os.getenv("HOME")

function M.setup()
end

function M.config()
    local lsp_status = require("lsp-status")
    lsp_status.register_progress()

    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities = lsp_status.capabilities
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local lspconfig = require("lspconfig")

    local on_attach_vim = function(client)
        local completion = require("completion")

        completion.on_attach(client)
        lsp_status.on_attach(client)

        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                virtual_text = true,
                underline = true,
                signs = true,
                update_in_insert = true,
            }
        )
    end

    lspconfig.bashls.setup{
        capabilities = capabilities,
        on_attach=on_attach_vim,
    }
    lspconfig.dockerls.setup{
        capabilities = capabilities,
        on_attach=on_attach_vim,
    }
    lspconfig.jsonls.setup{
        capabilities = capabilities,
        on_attach=on_attach_vim,
    }
    lspconfig.terraformls.setup{
        capabilities = capabilities,
        on_attach=on_attach_vim,
    }
    lspconfig.vimls.setup{
        capabilities = capabilities,
        on_attach=on_attach_vim,
    }

    lspconfig.diagnosticls.setup{
        capabilities = capabilities,
        on_attach = on_attach_vim,
        filetypes = {
            'json',
            'sh'
        },
        init_options = {
            formatters = {
                jq = {
                    command = "hjson",
                    args = {"-j"}
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

    lspconfig.sumneko_lua.setup{
        capabilities = capabilities,
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

    lspconfig.pyls.setup{
        capabilities = capabilities,
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
                            -- '--init-hook="import sys, pylint_venv; sys.path.append("."); pylint_venv.inithook(force_venv_activation=True)"',
                            '--init-hook="import pylint_venv; pylint_venv.inithook(force_venv_activation=True)"',
                            '--max-line-length=120',
                            '--disable=invalid-name,missing-docstring,broad-except,logging-fstring-interpolation,fixme'
                        }
                    },
                    pyls_isort = {
                        enabled = true
                    },
                    pyls_black = {
                        enabled = true,
                        line_length = 120
                    },
                    pyls_mypy = {
                        enabled = true,
                        live_mode = false,
                    }
                }
            }
        }
    }

    lspconfig.yamlls.setup{
        capabilities = capabilities,
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

    h.map("n", "<Leader>]", "<cmd>lua vim.lsp.buf.definition()<CR>")
    h.map("n", "<Leader>z", "<cmd>lua vim.lsp.buf.formatting()<CR>")
    h.map("x", "<Leader>z", "<cmd>lua vim.lsp.buf.formatting()<CR>")
    h.map("n", "<Leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>")
    h.map("n", "<Leader>d", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
    h.map("n", "<Leader>D", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
    h.map("n", "<Leader>j", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
    h.map("n", "<Leader>k", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
end

return M
