local M = {}

function M.config()
    vim.keymap.set("n", "p", require("pasta.mappings").p)
    vim.keymap.set("n", "P", require("pasta.mappings").P)

    require("pasta").setup({})
end

return M
