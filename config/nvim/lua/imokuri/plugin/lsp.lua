return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "Mofiqul/trld.nvim",
            "Wansmer/symbol-usage.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "nvimtools/none-ls.nvim",
            "smjonas/inc-rename.nvim",
        },
        event = "VeryLazy",
        config = function()
            vim.diagnostic.config({
                virtual_text = { current_line = true, source = true },
                underline = true,
                signs = true,
                update_in_insert = true,
                severity_sort = true,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(event)
                    local bufnr = event.buf
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    local opts = { buffer = bufnr }

                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<Leader>[", function() Snacks.picker.lsp_references() end)
                    vim.keymap.set("n", "<Leader>]", function() Snacks.picker.lsp_definitions() end)
                    vim.keymap.set("n", "<Leader>j", function() vim.diagnostic.jump({ count = 1 }) end)
                    vim.keymap.set("n", "<Leader>k", function() vim.diagnostic.jump({ count = -1 }) end)
                    vim.keymap.set("n", "<Leader>r", ":IncRename ", opts)
                    vim.keymap.set("n", "<Leader>x", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<Leader>z", function() vim.lsp.buf.format({ async = true }) end, opts)

                    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
                    for type, icon in pairs(signs) do
                        local hl = "DiagnosticSign" .. type
                        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
                    end

                    if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                    else
                        vim.notify(
                            ("%s(%d) does not support textDocument/inlayHint"):format(client.name, client.id),
                            vim.log.levels.DEBUG
                        )
                    end
                end,
            })

            require("inc_rename").setup()
            require("symbol-usage").setup({ vt_position = "end_of_line" })
            require("trld").setup()

            local null_ls = require("null-ls")
            null_ls.setup()

            null_ls.register(null_ls.builtins.formatting.prettier)
            null_ls.register(null_ls.builtins.formatting.shfmt.with({ extra_args = { "-i", vim.bo.softtabstop } }))
            null_ls.register(null_ls.builtins.formatting.stylua)

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config("*", { capabilities = capabilities })

            vim.lsp.config.ruff = {
                init_options = {
                    settings = {
                        lineLength = 120,
                    },
                },
            }

            vim.lsp.config.pyright = {
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

            vim.lsp.enable({ "astro", "bashls", "dockerls", "ruff", "pyright", "lua_ls" })
        end,
    },
}
