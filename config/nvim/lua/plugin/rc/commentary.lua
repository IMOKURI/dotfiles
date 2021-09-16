local M = {}
local h = require('helper')

function M.setup()
    h.map("n", "<Leader>c", ":Commentary<CR>")
    h.map("x", "<Leader>c", ":Commentary<CR>")
end

return M
