local M = {}

function M.config()
    require("gitsigns").setup({
        word_diff = false,
        keymaps = {},
    })
end

return M
