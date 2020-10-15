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

    -- TODO:
    -- Error detected while processing CursorHold Autocommands for "<buffer=1>":
    -- server doesn't support textDocument/documentSymbol
    -- nvim_lsp.bashls.setup{
    --     capabilities = lsp_status.capabilities,
    --     on_attach=on_attach_vim,
    -- }
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

    vim.api.nvim_set_keymap(
        "n",
        "<Leader>]",
        "<cmd>lua vim.lsp.buf.definition()<CR>",
        {
            noremap = true,
            silent = true,
        }
    )
    vim.api.nvim_set_keymap(
        "n",
        "<Leader>z",
        "<cmd>lua vim.lsp.buf.formatting()<CR>",
        {
            noremap = true,
            silent = true,
        }
    )
    vim.api.nvim_set_keymap(
        "x",
        "<Leader>z",
        "<cmd>lua vim.lsp.buf.formatting()<CR>",
        {
            noremap = true,
            silent = true,
        }
    )
    vim.api.nvim_set_keymap(
        "n",
        "<Leader>r",
        "<cmd>lua vim.lsp.buf.rename()<CR>",
        {
            noremap = true,
            silent = true,
        }
    )
    vim.api.nvim_set_keymap(
        "n",
        "<Leader>d",
        "<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>",
        {
            noremap = true,
            silent = true,
        }
    )
end

return M
