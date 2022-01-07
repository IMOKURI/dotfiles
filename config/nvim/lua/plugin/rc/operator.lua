local M = {}

function M.config()
    vim.keymap.set("", "S", "<Plug>(operator-replace)")
end

return M
