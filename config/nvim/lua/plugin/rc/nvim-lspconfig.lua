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

    lspconfig.pyright.setup{
        capabilities = capabilities,
        on_attach = on_attach_vim,
        settings = {
            -- https://github.com/microsoft/pyright/blob/master/docs/settings.md
            pyright = {},
            python = {
                pythonPath = vim.fn.exepath("python"),
                analysis = {
                    autoImportCompletions = true,
                    autoSearchPaths = true,
                    diagnosticMode = 'workspace',
                    typeCheckingMode = 'basic',
                    useLibraryCodeForTypes = true
                }
            }
        }
    }

    lspconfig.pylsp.setup{
        capabilities = capabilities,
        on_attach = on_attach_vim,
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = {
                        enabled = false,
                    },
                    pylsp_black = {
                        line_length = 120,
                    },
                    -- pylsp_mypy = {
                    --     live_mode = false,
                    -- }
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
                completion = true,
                schemas = {
                    kubernetes = "/*"
                }
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

    vim.fn.sign_define(
        "LspDiagnosticsSignError",
        { texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError" }
    )
    vim.fn.sign_define(
        "LspDiagnosticsSignWarning",
        { texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning" }
    )
    vim.fn.sign_define(
        "LspDiagnosticsSignInformation",
        { texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation" }
    )
    vim.fn.sign_define(
        "LspDiagnosticsSignHint",
        { texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint" }
    )
end

return M
