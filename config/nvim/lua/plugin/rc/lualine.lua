local M = {}

function M.config()
    require('lualine').setup({
        options = {
            theme = 'palenight'
        },
        sections = {
            lualine_a = { {'mode', upper = true} },
            lualine_b = { 'filetype' },
            lualine_c = { {'filename', file_status = true} },
            lualine_x = { {'diagnostics',
                sources = {'nvim_lsp'},
                color_error = "#ff5458",
                color_warn = "#ffb378",
                color_info = "#91ddff",
                color_hint = "#B2B2B2"
            } },
            lualine_y = { 'branch' },
            lualine_z = {  }
        },
        inactive_sections = {
            lualine_a = {  },
            lualine_b = { 'filetype' },
            lualine_c = { 'filename' },
            lualine_x = {  },
            lualine_y = {  },
            lualine_z = {  }
        }
    })
end

return M
