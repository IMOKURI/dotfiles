local M = {}

function M.config()
    vim.api.nvim_set_keymap(
        "",
        "S",
        "<Plug>(operator-replace)",
        {
            silent = true,
        }
    )
end

return M
