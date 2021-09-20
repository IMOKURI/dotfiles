local M = {}
local h = require('helper')

function M.config()
    h.map("", "S", "<Plug>(operator-replace)", {noremap = false})
end

return M
