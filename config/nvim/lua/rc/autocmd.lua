local u = require("util")
local group_name = "MyACGroup"

-- @param {boolean} clear - optional, defaults to true
-- @param {string} name - autogroup name
vim.api.nvim_create_augroup({ name = group_name, clear = true })

-- @param {string} name - augroup name
-- @param {string | table} event - event or events to match against
-- @param {string | table} pattern - pattern or patterns to match against
-- @param {string | function} callback - function or string to execute on autocmd
-- @param {string} command - optional, vimscript command Eg. command = "let g:value_set = v:true"
-- @param {boolean} once - optional, defaults to false
vim.api.nvim_create_autocmd({
    event = "TextYankPost",
    group = group_name,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
    end,
})
vim.api.nvim_create_autocmd({
    event = "BufReadPost",
    group = group_name,
    pattern = "*",
    command = [[ if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif ]],
})
vim.api.nvim_create_autocmd({
    event = "BufWinEnter",
    group = group_name,
    pattern = "*",
    command = [[ if empty(&buftype) && line('.') > winheight(0) / 2 | execute 'normal! zz' | endif ]],
})
vim.api.nvim_create_autocmd({
    event = "BufWritePre",
    group = group_name,
    pattern = "*",
    callback = function()
        u.auto_mkdir(vim.fn.expand("<afile>:p:h:s?suda://??"), vim.api.nvim_eval("v:cmdbang"))
    end,
})
vim.api.nvim_create_autocmd({
    event = "BufWritePost",
    group = group_name,
    pattern = "plugin.all.lua",
    command = "source <afile> | PackerCompile",
})
