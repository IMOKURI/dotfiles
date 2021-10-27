local M = {}
local h = require('helper')

function M.config()
    require('Comment').setup()

    h.map("n", "<Leader>c", "gcc", {noremap = false})
    h.map("x", "<Leader>c", "gc", {noremap = false})
end

return M
