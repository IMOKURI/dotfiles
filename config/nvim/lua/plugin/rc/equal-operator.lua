local M = {}

function M.config()
    vim.g.equal_operator_default_mappings = 0

    vim.api.nvim_set_keymap("o", "ik", "<Plug>(operator-lhs)", { silent = true, })
    vim.api.nvim_set_keymap("o", "ak", "<Plug>(operator-Lhs)", { silent = true, })
    vim.api.nvim_set_keymap("o", "iv", "<Plug>(operator-rhs)", { silent = true, })
    vim.api.nvim_set_keymap("o", "av", "<Plug>(operator-Rhs)", { silent = true, })

    vim.api.nvim_set_keymap("x", "ik", "<Plug>(visual-lhs)", { silent = true, })
    vim.api.nvim_set_keymap("x", "ak", "<Plug>(visual-Lhs)", { silent = true, })
    vim.api.nvim_set_keymap("x", "iv", "<Plug>(visual-rhs)", { silent = true, })
    vim.api.nvim_set_keymap("x", "av", "<Plug>(visual-Rhs)", { silent = true, })
end

return M
