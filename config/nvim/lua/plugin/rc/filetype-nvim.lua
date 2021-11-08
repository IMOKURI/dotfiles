local M = {}

function M.config()
    require('filetype').setup({
        overrides = {
            complex = {
                ["Dockerfile.*"] = "dockerfile"
            }
        }
    })
end

return M
