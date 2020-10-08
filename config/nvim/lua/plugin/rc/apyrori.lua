local M = {}

function M.config()
    vim.api.nvim_set_keymap(
        "n",
        "<C-i>",
        "<plug>ApyroriInsert",
        {
            silent = true,
        }
    )
end

return M
