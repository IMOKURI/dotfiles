local M = {}

function M.config()
    require("gitsigns").setup({
        word_diff = true,
        keymaps = {},
    })
end

return M
