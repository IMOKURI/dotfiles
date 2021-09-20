local M = {}
local h = require('helper')

function M.config()
    h.map('n', '<Leader>h', '<cmd>lua require("hop").hint_words()<cr>')
    h.map('n', '<Leader>/', '<cmd>lua require("hop").hint_patterns()<cr>')
end

return M
