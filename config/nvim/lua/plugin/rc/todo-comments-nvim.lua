local M = {}

function M.config()
    require("todo-comments").setup({})

    vim.keymap.set("n", "<Leader>t", "<Cmd>TodoTelescope<CR>")
end

return M
