local M = {}

function M.config()
    require "completion_buffers".add_sources()
end

return M
