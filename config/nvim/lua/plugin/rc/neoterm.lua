local M = {}
local h = require('helper')

function M.setup()
    vim.g.neoterm_autoscroll = 1
    vim.g.neoterm_default_mod = 'botright'
    vim.g.neoterm_repl_python = 'python'

    h.map("n", "<C-t>", "<cmd>Ttoggle<CR>")
    h.map("t", "<C-t>", "<C-\\><C-n><cmd>Ttoggle<CR>")

    h.map("n", "<C-g>", "<cmd>Topen<CR><C-w>bi")
    h.map("t", "<C-g>", "<C-\\><C-n><C-w>p")
end

return M
