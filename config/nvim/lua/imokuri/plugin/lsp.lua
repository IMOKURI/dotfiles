return {
    {
        "Mofiqul/trld.nvim",
        event = "VeryLazy",
        opts = {
            position = "bottom",
        },
    },
    {
        "Wansmer/symbol-usage.nvim",
        event = "VeryLazy",
        opts = {
            vt_position = "end_of_line",
        },
    },
    {
        "nvimtools/none-ls.nvim",
        event = "VeryLazy",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup()

            null_ls.register(null_ls.builtins.formatting.prettier)
            null_ls.register(null_ls.builtins.formatting.shfmt.with({ extra_args = { "-i", vim.bo.softtabstop } }))
            null_ls.register(null_ls.builtins.formatting.stylua)
        end,
    },
    {
        "smjonas/inc-rename.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        event = "VeryLazy",
        config = function()
            vim.diagnostic.config({
                update_in_insert = true,
                severity_sort = true,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(event)
                    local client = vim.lsp.get_client_by_id(event.data.client_id)

                    vim.keymap.set("n", "K", vim.lsp.buf.hover)
                    vim.keymap.set("n", "<Leader>[", function() Snacks.picker.lsp_references() end)
                    vim.keymap.set("n", "<Leader>]", function() Snacks.picker.lsp_definitions() end)
                    vim.keymap.set("n", "<Leader>j", function() vim.diagnostic.jump({ count = 1 }) end)
                    vim.keymap.set("n", "<Leader>k", function() vim.diagnostic.jump({ count = -1 }) end)
                    vim.keymap.set("n", "<Leader>r", ":IncRename ")
                    vim.keymap.set("n", "<Leader>x", vim.lsp.buf.code_action)
                    vim.keymap.set("n", "<Leader>z", function() vim.lsp.buf.format({ async = true }) end)

                    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
                    for type, icon in pairs(signs) do
                        local hl = "DiagnosticSign" .. type
                        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
                    end

                    if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                        vim.lsp.inlay_hint.enable(true)
                        vim.keymap.set(
                            "n",
                            "<Leader>I",
                            function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end
                        )
                    else
                        vim.notify(
                            ("%s(%d) does not support textDocument/inlayHint"):format(client.name, client.id),
                            vim.log.levels.DEBUG
                        )
                    end
                end,
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            vim.lsp.config("*", { capabilities = capabilities })

            vim.lsp.config.astro = {
                init_options = {
                    typescript = {
                        tsdk = vim.fn.expand(
                            "~/.local/share/mise/installs/npm-astrojs-language-server/latest/node_modules/typescript/lib"
                        ),
                    },
                },
            }

            vim.lsp.config.ruff = {
                init_options = {
                    settings = {
                        lineLength = 120,
                    },
                },
            }

            vim.lsp.config.lua_ls = {
                settings = {
                    -- https://github.com/LuaLS/lua-language-server/wiki/Settings
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                            path = vim.split(package.path, ";"),
                        },
                        diagnostics = {
                            globals = vim.list_extend({
                                "Snacks",
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
            }

            vim.lsp.enable({ "astro", "bashls", "dockerls", "lua_ls", "ruff", "ty" })
        end,
    },
}
