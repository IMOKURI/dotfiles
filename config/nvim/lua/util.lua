local M = {}

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
