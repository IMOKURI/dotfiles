local M = {}
local h = require('helper')

function M.config()
    h.map("n", "<Leader>m", "<Plug>(quickhl-manual-this)",  {noremap = false})
    h.map("x", "<Leader>m", "<Plug>(quickhl-manual-this)",  {noremap = false})
    h.map("n", "<Leader>M", "<Plug>(quickhl-manual-reset)", {noremap = false})
end

return M
