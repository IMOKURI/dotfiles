local M = {}

function M.config()
    vim.keymap.set("n", "<Leader>]", "<Cmd>lua vim.lsp.buf.definition()<CR>")
    vim.keymap.set({ "n", "x" }, "<Leader>z", "<Cmd>lua vim.lsp.buf.formatting()<CR>")
    vim.keymap.set("n", "<Leader>r", "<Cmd>lua vim.lsp.buf.rename()<CR>")
    vim.keymap.set("n", "<Leader>d", "<Cmd>lua vim.diagnostic.open_float(0, {scope='line'})<CR>")
    vim.keymap.set("n", "<Leader>D", "<Cmd>lua vim.diagnostic.setloclist()<CR>")
    vim.keymap.set("n", "<Leader>j", "<Cmd>lua vim.diagnostic.goto_next()<CR>")
    vim.keymap.set("n", "<Leader>k", "<Cmd>lua vim.diagnostic.goto_prev()<CR>")

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
