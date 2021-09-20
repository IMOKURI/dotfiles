local M = {}
local h = require('helper')

function M.setup()
    h.map("n", "<Leader>a", ":EasyAlign<CR>", {noremap = false})
    h.map("x", "<Leader>a", ":EasyAlign<CR>", {noremap = false})
end

return M
