local M = {}
local h = require('helper')

function M.setup()
    vim.g.table_mode_always_active = 1

    h.map("n", "<Leader><Leader>a", "<cmd>TableModeRealign<CR>")
end

return M
