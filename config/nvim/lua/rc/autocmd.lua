local u = require("util")
local group_name = "MyACGroup"

vim.api.nvim_create_augroup(group_name, {})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = group_name,
    callback = function()
        vim.highlight.on_yank()
    end,
})
vim.api.nvim_create_autocmd("BufReadPost", {
    group = group_name,
    command = [[ if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif ]],
})
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = group_name,
    command = [[ if empty(&buftype) && line('.') > winheight(0) / 2 | execute 'normal! zz' | endif ]],
})
vim.api.nvim_create_autocmd("BufWritePre", {
    group = group_name,
    callback = function()
        u.auto_mkdir(vim.fn.expand("<afile>:p:h:s?suda://??"), vim.api.nvim_eval("v:cmdbang"))
    end,
})
vim.api.nvim_create_autocmd("BufWritePost", {
    group = group_name,
    pattern = "all.lua",
    command = "source <afile> | PackerCompile",
})
vim.api.nvim_create_autocmd("FileType", {
    group = group_name,
    pattern = "gitcommit",
    command = "normal! 5G",
})
