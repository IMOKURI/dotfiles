local M = {}

local servers = {
    -- "ansiblels",
    "bashls",
    "diagnosticls",
    "dockerls",
    "jsonls",
    "pylsp",
    -- "pyright",
    "sumneko_lua",
    "terraformls",
    "vimls",
    "yamlls",
}

function M.config()
    local lsp_status = require("lsp-status")
    lsp_status.register_progress()

    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities = lsp_status.capabilities
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

    local on_attach_vim = function(client)
        lsp_status.on_attach(client)

        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = {
                source = true,
            },
            underline = true,
            signs = true,
            update_in_insert = true,
            severity_sort = true,
        })
    end

    local lsp_installer = require("nvim-lsp-installer")

    for _, name in pairs(servers) do
        local ok, server = lsp_installer.get_server(name)
        -- Check that the server is supported in nvim-lsp-installer
        if ok then
            if not server:is_installed() then
                print("Installing " .. name)
                server:install()
            end
        end
    end

    lsp_installer.on_server_ready(function(server)
        local opts = {}

        opts.capabilities = capabilities
        opts.on_attach = on_attach_vim

        if server.name == "diagnosticls" then
            opts.filetypes = {
                "sh",
                "lua",
            }
            opts.init_options = {
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
                },
                formatFiletypes = {
                    sh = "shfmt",
                    lua = "stylua",
                },
            }
        end

        if server.name == "sumneko_lua" then
            opts.settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                        path = vim.split(package.path, ";"),
                    },
                    diagnostics = {
                        enable = true,
                        globals = vim.list_extend({
                            "use",
                            "vim",
                        }, {}),
                    },
                },
            }
        end

        if server.name == "pylsp" then
            opts.settings = {
                -- https://github.com/williamboman/nvim-lsp-installer/blob/main/lua/nvim-lsp-installer/servers/pylsp/README.md
                -- Require setup command: PylspInstall pyls-isort python-lsp-black pylsp-mypy
                pylsp = {
                    plugins = {
                        pycodestyle = {
                            enabled = true,
                            maxLineLength = 120,
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
                            enabled = true,
                            live_mode = false,
                            dmypy = true,
                            strict = false,
                        }
                    },
                },
            }
        end

        -- if server.name == "pyright" then
        --     opts.settings = {
        --         -- https://github.com/microsoft/pyright/blob/master/docs/settings.md
        --         pyright = {},
        --         python = {
        --             pythonPath = vim.fn.exepath("python"),
        --             analysis = {
        --                 autoImportCompletions = true,
        --                 autoSearchPaths = true,
        --                 diagnosticMode = "workspace",
        --                 typeCheckingMode = "basic",
        --                 useLibraryCodeForTypes = true,
        --             },
        --         },
        --     }
        -- end

        if server.name == "yamlls" then
            opts.settings = {
                yaml = {
                    format = {
                        enable = true,
                        printWidth = 120,
                    },
                    validate = true,
                    hover = true,
                    completion = true,
                    -- schemas = {
                    --     kubernetes = "/*",
                    --     require('schemastore').json.schemas{
                    --         select = {
                    --             "Ansible Role",
                    --             "Ansible Playbook",
                    --             "Ansible Inventory",
                    --             "Ansible Collection Galaxy",
                    --         }
                    --     }
                    -- }
                },
            }
        end

        -- This setup() function is exactly the same as lspconfig's setup function.
        -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/ADVANCED_README.md
        server:setup(opts)
    end)
end

return M
