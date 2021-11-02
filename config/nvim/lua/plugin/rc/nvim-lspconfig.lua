local M = {}
local h = require("helper")

function M.config()
    local lsp_status = require("lsp-status")
    lsp_status.register_progress()

    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities = lsp_status.capabilities
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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

    h.map("n", "<Leader>]", "<cmd>lua vim.lsp.buf.definition()<CR>")
    h.map("n", "<Leader>z", "<cmd>lua vim.lsp.buf.formatting()<CR>")
    h.map("x", "<Leader>z", "<cmd>lua vim.lsp.buf.formatting()<CR>")
    h.map("n", "<Leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>")
    h.map("n", "<Leader>d", "<cmd>lua vim.diagnostic.open_float(0, {scope='line'})<CR>")
    h.map("n", "<Leader>D", "<cmd>lua vim.diagnostic.setloclist()<CR>")
    h.map("n", "<Leader>j", "<cmd>lua vim.diagnostic.goto_next()<CR>")
    h.map("n", "<Leader>k", "<cmd>lua vim.diagnostic.goto_prev()<CR>")

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
