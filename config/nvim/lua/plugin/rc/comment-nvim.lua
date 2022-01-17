local M = {}

function M.config()
    require("Comment").setup()

    vim.keymap.set("n", "<Leader>c", "gcc", { remap = true })
    vim.keymap.set("x", "<Leader>c", "gc", { remap = true })
end

return M
