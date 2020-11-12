local M = {}

function M.setup()
    vim.api.nvim_set_keymap("x", "<Leader>l", ":Linediff<CR>", { noremap = true, silent = true, })
end

return M
