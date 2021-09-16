local M = {}

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

function M.config()
end

return M
