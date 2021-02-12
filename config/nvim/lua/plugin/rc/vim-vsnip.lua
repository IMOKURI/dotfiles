local M = {}

function M.setup()
    vim.g.vsnip_snippet_dirs = {
        '$MYVIMRCDIR/snippet'
    }
end

function M.config()
    vim.api.nvim_set_keymap("i", "<C-k>", "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-k>'", { expr = true, })
    vim.api.nvim_set_keymap("s", "<C-k>", "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-k>'", { expr = true, })
    vim.api.nvim_set_keymap("i", "<C-j>", "vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-j>'",     { expr = true, })
    vim.api.nvim_set_keymap("s", "<C-j>", "vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-j>'",     { expr = true, })
end

return M
