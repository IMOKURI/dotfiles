local M = {}

function M.config()
    require("neogen").setup({
        enabled = true,
        languages = {
            python = {
                template = {
                    annotation_convention = "google_docstrings",
                },
            },
        },
    })
end

return M
