local M = {}

local servers = {
    "bash-language-server",
    "diagnostic-languageserver",
    "dockerfile-language-server",
    "json-lsp",
    "lua-language-server",
    "pyright",
    "python-lsp-server",
    "terraform-ls",
    "vim-language-server",
}

function M.config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

    local on_attach_vim = function(_, bufnr)
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
        vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })
        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = {
                source = true,
            },
            underline = true,
            signs = true,
            update_in_insert = true,
            severity_sort = true,
        })

        vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", { buffer = bufnr })
        vim.keymap.set("n", "<Leader>C", "<Cmd>lua vim.lsp.buf.code_action()<CR>", { buffer = bufnr })
        vim.keymap.set("n", "<Leader>z", "<Cmd>lua vim.lsp.buf.format({ async = true })<CR>", { buffer = bufnr })
        vim.keymap.set("x", "<Leader>z", "<Cmd>lua vim.lsp.buf.range_formatting()<CR>", { buffer = bufnr })
        vim.keymap.set("n", "<Leader>j", "<Cmd>lua vim.diagnostic.goto_next()<CR>", { buffer = bufnr })
        vim.keymap.set("n", "<Leader>k", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", { buffer = bufnr })
        vim.keymap.set("n", "<Leader>r", ":IncRename ", { buffer = bufnr }) -- depends on inc-rename.nvim

        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
    end

    require("mason").setup()

    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
        ensure_installed = servers,
        automatic_installation = true,
    })

    local lsp_config = require("lspconfig")

    mason_lspconfig.setup_handlers({
        function(server_name)
            lsp_config[server_name].setup({
                capabilities = capabilities,
                on_attach = on_attach_vim,
            })
        end,

        ["diagnosticls"] = function()
            lsp_config["diagnosticls"].setup({
                capabilities = capabilities,
                on_attach = on_attach_vim,
                filetypes = {
                    "sh",
                    "lua",
                    "yaml",
                },
                init_options = {
                    formatters = {
                        shfmt = {
                            command = "shfmt",
                            args = { "-i", "4", "-sr", "-ci" },
                        },
                        stylua = {
                            command = "stylua",
                            args = { "--stdin-filepath", "%filename", "--", "-" },
                            rootPatterns = { ".git" },
                        },
                        prettier = {
                            command = "prettier",
                            args = {
                                "--stdin",
                                "--stdin-filepath",
                                "%filepath",
                            },
                            rootPatterns = { ".prettierrc.json", ".git" },
                        },
                    },
                    formatFiletypes = {
                        sh = "shfmt",
                        lua = "stylua",
                        yaml = "prettier",
                    },
                },
            })
        end,

        ["pylsp"] = function()
            lsp_config["pylsp"].setup({
                capabilities = capabilities,
                on_attach = on_attach_vim,
                settings = {
                    -- https://github.com/williamboman/nvim-lsp-installer/blob/main/lua/nvim-lsp-installer/servers/pylsp/README.md
                    -- Require setup command: PylspInstall pyls-isort python-lsp-black pylsp-mypy
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                enabled = false,
                                maxLineLength = 120,
                                ignore = {
                                    "E203", -- whitespace before ':'
                                    "W503", -- line break before binary operator
                                },
                            },
                            pyflakes = {
                                enabled = false,
                            },
                            autopep8 = {
                                enabled = false,
                            },
                            yapf = {
                                enabled = false,
                            },
                            pylsp_black = {
                                enabled = true,
                                line_length = 120,
                            },
                            pyls_isort = {
                                enabled = true,
                            },
                            pylsp_mypy = {
                                enabled = false,
                                live_mode = false,
                                dmypy = true,
                                strict = false,
                            },
                            memestra = {
                                enabled = true,
                            },
                        },
                    },
                },
            })
        end,

        ["pyright"] = function()
            lsp_config["pyright"].setup({
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
                            diagnosticMode = "workspace",
                            typeCheckingMode = "basic",
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            })
        end,

        ["sumneko_lua"] = function()
            lsp_config["sumneko_lua"].setup({
                capabilities = capabilities,
                on_attach = on_attach_vim,
                settings = {
                    -- https://github.com/sumneko/lua-language-server/wiki/Setting
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                            path = vim.split(package.path, ";"),
                        },
                        diagnostics = {
                            enable = true,
                            globals = vim.list_extend({
                                "after_each",
                                "before_each",
                                "describe",
                                "it",
                                "use",
                                "vim",
                            }, {}),
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                    },
                },
            })
        end,
    })
end

return M
