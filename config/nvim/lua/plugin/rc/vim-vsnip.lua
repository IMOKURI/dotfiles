local M = {}

function M.setup()
    -- vim.g.vsnip_snippet_dir = '$MYVIMRCDIR/snippet'
end

function M.config()
    vim.api.nvim_command("imap <expr> <C-k> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-k>'")
    vim.api.nvim_command("smap <expr> <C-k> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-k>'")
    vim.api.nvim_command("imap <expr> <C-j> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-j>'")
    vim.api.nvim_command("smap <expr> <C-j> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-j>'")
end

return M
