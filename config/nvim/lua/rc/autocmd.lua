local au = require('au')
local u = require('util')


-- # Simple autocmd with one event: au.<event> = string | fn | { pattern: string, action: string | fn }

-- 1. If you want aucmd to fire on every buffer, you can use the style below
au.TextYankPost = function()
    vim.highlight.on_yank()
end

au.BufWritePre = function()
    u.auto_mkdir(vim.fn.expand('<afile>:p:h:s?suda://??'), vim.api.nvim_eval('v:cmdbang'))
end

-- au.InsertLeave = function()
--     vim.go.paste = false
-- end

au.BufReadPost = [[ if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif ]]


-- # Autocmd with multiple event: au(events: table, cmd: string | fn | {pattern: string, action: string | fn})

-- For this you can just call the required module just like a function
au({ 'CursorMoved', 'CursorMovedI', 'WinLeave' },
    function()
        vim.wo.cursorline = false
    end
)
au({ 'CursorHold', 'CursorHoldI', 'WinEnter' },
    function()
        vim.wo.cursorline = true
    end
)

au({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' },
    function()
        vim.wo.relativenumber = true
    end
)
au({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' },
    function()
        vim.wo.relativenumber = false
    end
)

au({ 'BufNewFile', 'BufRead' }, {
    '*.csv',
    function()
        vim.bo.filetype = 'csv'
    end,
})

au({ 'BufNewFile', 'BufRead' }, {
    'Dockerfile.*',
    function()
        vim.bo.filetype = 'dockerfile'
    end,
})


-- # Autocmd group: au.group(group: string, cmds: fn(au) | {event: string, pattern: string, action: string | fn})

-- 1. Where action is a ex-cmd
au.group('PackerGroup', {
    { 'BufWritePost', 'plugin.all', 'source <afile> | PackerCompile' },
})
