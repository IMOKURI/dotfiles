local M = {}

function M.config()
    local opts = {
        log_level = 'error',
        auto_session_enabled = false,
    }

    require('auto-session').setup(opts)
end

return M
