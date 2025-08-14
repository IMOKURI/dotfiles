local u = require("imokuri.util")
local group_name = "UserRuntimeConfig"

vim.api.nvim_create_augroup(group_name, {})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = group_name,
    callback = function() vim.highlight.on_yank() end,
})
vim.api.nvim_create_autocmd("BufReadPost", {
    group = group_name,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})
vim.api.nvim_create_autocmd("BufEnter", {
    group = group_name,
    pattern = "COMMIT_EDITMSG",
    command = "normal! 5G",
})
vim.api.nvim_create_autocmd("BufWritePre", {
    group = group_name,
    callback = function() u.auto_mkdir(vim.fn.expand("<afile>:p:h:s?suda://??"), vim.api.nvim_eval("v:cmdbang")) end,
})
vim.api.nvim_create_autocmd("BufWritePost", {
    group = group_name,
    pattern = "catppuccin.lua",
    callback = function()
        vim.api.nvim_cmd({
            cmd = "CatppuccinCompile",
        }, {})
    end,
})
vim.api.nvim_create_autocmd("TermOpen", {
    group = group_name,
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = u.treesitter_filetypes,
    callback = function()
        vim.treesitter.start()
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
})
