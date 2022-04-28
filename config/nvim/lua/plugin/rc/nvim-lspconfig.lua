local M = {}

function M.config()
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    vim.keymap.set("n", "<Leader>]", "<Cmd>lua vim.lsp.buf.definition()<CR>")
    vim.keymap.set("n", "<Leader>z", "<Cmd>lua vim.lsp.buf.formatting()<CR>")
    vim.keymap.set("x", "<Leader>z", "<Cmd>lua vim.lsp.buf.range_formatting()<CR>")
    vim.keymap.set("n", "<Leader>r", "<Cmd>lua vim.lsp.buf.rename()<CR>")
    vim.keymap.set("n", "<Leader>d", "<Cmd>lua vim.diagnostic.open_float(0, {scope='line'})<CR>")
    vim.keymap.set("n", "<Leader>D", "<Cmd>lua vim.diagnostic.setloclist()<CR>")
    vim.keymap.set("n", "<Leader>j", "<Cmd>lua vim.diagnostic.goto_next()<CR>")
    vim.keymap.set("n", "<Leader>k", "<Cmd>lua vim.diagnostic.goto_prev()<CR>")

    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end

return M
