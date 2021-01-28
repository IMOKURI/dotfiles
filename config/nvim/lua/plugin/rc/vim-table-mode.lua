local M = {}

function M.setup()
    vim.g.table_mode_always_active = 1

    vim.api.nvim_set_keymap("n", "<Leader><Leader>a", "<cmd>TableModeRealign<CR>", { noremap = true, silent = true, })
end

return M
