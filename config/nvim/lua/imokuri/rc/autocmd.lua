local u = require("imokuri.util")
local group_name = "MyACGroup"

vim.api.nvim_create_augroup(group_name, {})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = group_name,
    callback = function()
        vim.highlight.on_yank()
    end,
})
vim.api.nvim_create_autocmd("BufRead", {
    group = group_name,
    command = [[ if line("'\"") > 0 && line ("'\"") <= line("$") | execute "normal! g'\"" | endif ]],
})
vim.api.nvim_create_autocmd("BufEnter", {
    group = group_name,
    command = [[ if empty(&buftype) && line('.') > winheight(0) / 2 | execute 'normal! zz' | endif ]],
})
vim.api.nvim_create_autocmd("BufEnter", {
    group = group_name,
    pattern = "COMMIT_EDITMSG",
    command = "normal! 5G",
})
vim.api.nvim_create_autocmd("BufWritePre", {
    group = group_name,
    callback = function()
        u.auto_mkdir(vim.fn.expand("<afile>:p:h:s?suda://??"), vim.api.nvim_eval("v:cmdbang"))
    end,
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
