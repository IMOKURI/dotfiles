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
        event = "VimEnter",
        config = function()
            local servers = {
                "ansiblels",
                "astro",
                "bashls",
                "diagnosticls",
                "pyright",
                "ruff_lsp",
                "lua_ls",
            }

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            function OnAttach(on_attach)
                vim.api.nvim_create_autocmd("LspAttach", {
                    callback = function(args)
                        local bufnr = args.buf
                        local client = vim.lsp.get_client_by_id(args.data.client_id)
                        on_attach(client, bufnr)
                    end,
                })
            end

            OnAttach(function(client, bufnr)
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

                vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", { buffer = bufnr })
                vim.keymap.set("n", "<Leader>x", "<Cmd>lua vim.lsp.buf.code_action()<CR>", { buffer = bufnr })
                vim.keymap.set(
                    "n",
                    "<Leader>z",
                    "<Cmd>lua vim.lsp.buf.format({ async = true })<CR>",
                    { buffer = bufnr }
                )
                vim.keymap.set("x", "<Leader>z", "<Cmd>lua vim.lsp.buf.range_formatting()<CR>", { buffer = bufnr })
                vim.keymap.set("n", "<Leader>j", "<Cmd>lua vim.diagnostic.goto_next()<CR>", { buffer = bufnr })
                vim.keymap.set("n", "<Leader>k", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", { buffer = bufnr })
                vim.keymap.set("n", "<Leader>r", ":IncRename ", { buffer = bufnr }) -- depends on inc-rename.nvim

                local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
                for type, icon in pairs(signs) do
                    local hl = "DiagnosticSign" .. type
                    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
                end

                if client.supports_method("textDocument/inlayHint") then
                    vim.lsp.inlay_hint(bufnr, true)
                else
                    vim.notify(
                        ("%s(%d) does not support textDocument/inlayHint"):format(client.name, client.id),
                        vim.log.levels.DEBUG
                    )
                end
            end)

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
                                    args = { "-i", "4", "-sr", "-ci" },
                                },
                                stylua = {
                                    command = "stylua",
                                    args = { "--stdin-filepath", "%filename", "--", "-" },
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
                ["pyright"] = function()
                    lsp_config["pyright"].setup({
                        capabilities = capabilities,
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
                ["ruff_lsp"] = function()
                    lsp_config["ruff_lsp"].setup({
                        capabilities = capabilities,
                        init_options = {
                            settings = {
                                args = {},
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
                            },
                        },
                    })
                end,
            })
        end,
    },
}
