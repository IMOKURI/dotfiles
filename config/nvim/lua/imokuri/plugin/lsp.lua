return {
    {
        "ejrichards/mise.nvim",
        otps = {},
    },
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
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
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
                    vim.keymap.set("n", "<Leader>j", vim.diagnostic.goto_next)
                    vim.keymap.set("n", "<Leader>k", vim.diagnostic.goto_prev)
                    vim.keymap.set("n", "<Leader>r", ":IncRename ", opts)
                    vim.keymap.set("n", "<Leader>x", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<Leader>z", function() vim.lsp.buf.format({ async = true }) end, opts)

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

            require("inc_rename").setup()
            require("symbol-usage").setup({ vt_position = "end_of_line" })
            require("trld").setup()

            local null_ls = require("null-ls")
            null_ls.setup()

            null_ls.register(null_ls.builtins.formatting.prettier)
            null_ls.register(null_ls.builtins.formatting.shfmt.with({ extra_args = { "-i", vim.bo.softtabstop } }))
            null_ls.register(null_ls.builtins.formatting.stylua)

            local lsp_config = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lsp_config.ruff.setup({
                capabilities = capabilities,
                init_options = {
                    settings = {
                        lineLength = 120,
                    },
                },
            })

            lsp_config.pyright.setup({
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

            lsp_config.lua_ls.setup({
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
    },
}
