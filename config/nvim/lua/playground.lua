local M = {}

function M.echo(msg)
    vim.api.nvim_cmd({
        cmd = "!",
        args = { "echo", msg },
    }, {})
end

function M.notify()
    vim.notify("This is an error message.", vim.log.levels.ERROR)
    vim.notify("This is a warning message.", vim.log.levels.WARN)
    vim.notify("This is an infomation message.", vim.log.levels.INFO)
    vim.notify("This is a debug message.", vim.log.levels.DEBUG)
end

return M
