local M = {}

function M.config()
    vim.keymap.set({"n", "x"}, "<Leader>m", "<Plug>(quickhl-manual-this)")
    vim.keymap.set("n", "<Leader>M", "<Plug>(quickhl-manual-reset)")
end

return M
