local M = {}
local h = require('helper')

function M.setup()
    vim.g.vsnip_snippet_dirs = {
        '$MYVIMRCDIR/snippet'
    }
end

function M.config()
    -- h.map("i", "<C-k>", "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-k>'", { expr = true, noremap = false})
    -- h.map("s", "<C-k>", "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-k>'", { expr = true, noremap = false})
    h.map("i", "<C-j>", "vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-j>'",     { expr = true, noremap = false})
    h.map("s", "<C-j>", "vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-j>'",     { expr = true, noremap = false})
end

return M
