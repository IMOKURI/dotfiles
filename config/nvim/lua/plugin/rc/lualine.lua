local M = {}

function M.config()
    require("lualine").setup({
        options = {
            theme = "palenight",
            -- theme = 'onenord',
            globalstatus = true,
        },
        sections = {
            lualine_a = { { "mode", fmt = string.upper } },
            lualine_b = { "filetype" },
            lualine_c = { { "filename", file_status = true, path = 1 } },
            lualine_x = { { "diagnostics", sources = { "nvim_lsp" } } },
            lualine_y = { "branch" },
            lualine_z = {},
        },
        -- inactive_sections = {
        --     lualine_a = {},
        --     lualine_b = { "filetype" },
        --     lualine_c = { "filename" },
        --     lualine_x = {},
        --     lualine_y = {},
        --     lualine_z = {},
        -- },
    })
end

return M
