local M = {}

function M.auto_mkdir(dir, force)
    if vim.fn.isdirectory(dir) == 0 then
        if force == 1 then
            vim.fn.mkdir(dir, 'p')
        else
            local is_create = vim.fn.input(string.format('"%s" does not exist. Create? [y/N]', dir))
            if string.match(is_create, "^[Yy]") ~= nil then
                vim.fn.mkdir(dir, 'p')
            end
        end
    end
end

function M.close_fold()
    if vim.fn.foldlevel(".") == 0 then
        vim.cmd("norm! zM")
        return
    end

    local foldc_lnum = vim.fn.foldclosed(".")
    vim.cmd("norm! zc")
    if foldc_lnum == -1 then
        return
    end

    if vim.fn.foldclosed(".") ~= foldc_lnum then
        return
    end
    vim.cmd("norm! zM")
end

function M.move_win(key)
    local curwin = vim.fn.winnr() or 0
    vim.api.nvim_command('wincmd ' .. key)

    if curwin == (vim.fn.winnr() or 0) then
        if string.match('jk', key) ~= nil then
            vim.api.nvim_command('wincmd s')
        else
            vim.api.nvim_command('wincmd v')
        end
        vim.api.nvim_command('wincmd ' .. key)
    end
end

return M
