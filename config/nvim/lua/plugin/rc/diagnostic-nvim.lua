local M = {}

function M.setup()
    vim.g.diagnostic_enable_virtual_text = 1
end

function M.config()
    vim.api.nvim_set_keymap(
        "n",
        "<Leader>D",
        "<cmd>OpenDiagnostic<CR>",
        {
            noremap = true,
            silent = true,
        }
    )
    vim.api.nvim_set_keymap(
        "n",
        "<Leader>n",
        "<cmd>NextDiagnosticCycle<CR>",
        {
            noremap = true,
            silent = true,
        }
    )
    vim.api.nvim_set_keymap(
        "n",
        "<Leader>p",
        "<cmd>PrevDiagnosticCycle<CR>",
        {
            noremap = true,
            silent = true,
        }
    )
end

return M
