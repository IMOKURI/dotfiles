return {
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "Mofiqul/trld.nvim",
            "Wansmer/symbol-usage.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "neovim/nvim-lspconfig",
            "smjonas/inc-rename.nvim",
            "williamboman/mason.nvim",
        },
        event = "VeryLazy",
        config = function()
            local servers = {
                "ansiblels",
                "astro",
                "bashls",
                "diagnosticls",
                "pyright",
                "ruff",
                "lua_ls",
            }

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    vim.lsp.handlers["textDocument/publishDiagnostics"] =
                        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                            virtual_text = {
                                source = true,
                            },
                            underline = true,
                            signs = true,
                            update_in_insert = true,
                            severity_sort = true,
                        })

                    local opts = { buffer = bufnr }
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<Leader>x", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<Leader>z", function() vim.lsp.buf.format({ async = true }) end, opts)
                    vim.keymap.set("n", "<Leader>r", ":IncRename ", opts) -- depends on inc-rename.nvim

                    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
                    for type, icon in pairs(signs) do
                        local hl = "DiagnosticSign" .. type
                        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
                    end

                    if client.supports_method("textDocument/inlayHint") then
                        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                    else
                        vim.notify(
                            ("%s(%d) does not support textDocument/inlayHint"):format(client.name, client.id),
                            vim.log.levels.DEBUG
                        )
                    end
                end,
            })

            vim.keymap.set("n", "<Leader>j", vim.diagnostic.goto_next)
            vim.keymap.set("n", "<Leader>k", vim.diagnostic.goto_prev)

            require("inc_rename").setup()
            require("trld").setup()
            require("mason").setup()
            require("symbol-usage").setup({
                vt_position = "end_of_line",
            })

            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup({
                ensure_installed = servers,
                automatic_installation = true,
            })

            local lsp_config = require("lspconfig")

            local prettier_options = {
                "--print-width",
                "120",
                "--stdin",
                "--stdin-filepath",
                "%filepath",
            }

            mason_lspconfig.setup_handlers({
                function(server_name) lsp_config[server_name].setup({ capabilities = capabilities }) end,
                ["diagnosticls"] = function()
                    lsp_config["diagnosticls"].setup({
                        capabilities = capabilities,
                        filetypes = {
                            "css",
                            "javascript",
                            "json",
                            "lua",
                            "sh",
                            "typescript",
                            "yaml",
                        },
                        init_options = {
                            formatters = {
                                shfmt = {
                                    command = "shfmt",
                                    args = { "-i", "2", "-sr", "-ci" },
                                },
                                stylua = {
                                    command = "stylua",
                                    args = { "--search-parent-directories", "--stdin-filepath", "%filepath", "--", "-" },
                                    rootPatterns = { ".git" },
                                },
                                prettier = {
                                    command = "prettier",
                                    args = prettier_options,
                                    rootPatterns = { ".git" },
                                },
                                prettier4 = {
                                    command = "prettier",
                                    args = vim.tbl_extend("force", prettier_options, { "--tab-width", "4" }),
                                    rootPatterns = { ".git" },
                                },
                            },
                            formatFiletypes = {
                                css = "prettier",
                                javascript = "prettier",
                                json = "prettier4",
                                lua = "stylua",
                                sh = "shfmt",
                                typescript = "prettier",
                                yaml = "prettier",
                            },
                        },
                    })
                end,
                ["ruff"] = function()
                    lsp_config["ruff"].setup({
                        capabilities = capabilities,
                        init_options = {
                            settings = {
                                lineLength = 120,
                            },
                        },
                    })
                end,
                ["pyright"] = function()
                    lsp_config["pyright"].setup({
                        capabilities = capabilities,
                        settings = {
                            -- https://github.com/microsoft/pyright/blob/master/docs/settings.md
                            pyright = {
                                -- Using Ruff's import organizer
                                disableOrganizeImports = true,
                            },
                            python = {
                                analysis = {
                                    -- Ignore all files for analysis to exclusively use Ruff for linting
                                    ignore = { "*" },
                                },
                            },
                        },
                    })
                end,
                ["lua_ls"] = function()
                    lsp_config["lua_ls"].setup({
                        capabilities = capabilities,
                        settings = {
                            -- https://github.com/LuaLS/lua-language-server/wiki/Settings
                            Lua = {
                                runtime = {
                                    version = "LuaJIT",
                                    path = vim.split(package.path, ";"),
                                },
                                diagnostics = {
                                    globals = vim.list_extend({
                                        "vim",
                                    }, {}),
                                },
                                completion = {
                                    callSnippet = "Replace",
                                },
                                hint = {
                                    enable = true,
                                },
                                format = {
                                    enable = false,
                                },
                            },
                        },
                    })
                end,
            })
        end,
    },
}
