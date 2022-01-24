local M = {}

function M.config()
    vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(operator-replace)")
end

return M
