local M = {}

function M.config()
    vim.api.nvim_set_keymap("n", "<Leader>m", "<Plug>(quickhl-manual-this)",  { silent = true, })
    vim.api.nvim_set_keymap("x", "<Leader>m", "<Plug>(quickhl-manual-this)",  { silent = true, })
    vim.api.nvim_set_keymap("n", "<Leader>M", "<Plug>(quickhl-manual-reset)", { silent = true, })
end

return M
