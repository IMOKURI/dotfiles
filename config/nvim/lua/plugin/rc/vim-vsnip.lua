local M = {}

function M.setup()
    vim.g.vsnip_snippet_dirs = {
        string.format("%s/snippet", vim.fn.stdpath("config"))
    }
end

function M.config()
    -- vim.keymap.set({"i", "s"}, "<C-k>", "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-k>'", { expr = true, remap = true})
    vim.keymap.set({"i", "s"}, "<C-j>", "vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-j>'", { expr = true, remap = true})
end

return M
