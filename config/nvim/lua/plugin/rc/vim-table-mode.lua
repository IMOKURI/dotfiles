local M = {}

function M.setup()
    vim.g.table_mode_always_active = 1

    vim.keymap.set("n", "<Leader><Leader>a", "<Cmd>TableModeRealign<CR>")
end

return M
