local M = {}

function M.config()
    require("lualine").setup({
        options = {
            theme = "catppuccin",
            globalstatus = true,
        },
        sections = {
            lualine_a = { { "mode", fmt = string.upper } },
            lualine_b = { "filetype" },
            lualine_c = { { "diagnostics", sources = { "nvim_lsp" } } },
            lualine_x = {},
            lualine_y = { "branch" },
            lualine_z = {},
        },
    })
end

return M
