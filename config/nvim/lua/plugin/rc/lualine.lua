local M = {}

function M.config()
    require('lualine').setup({
        options = {
            theme = 'palenight',
        },
        sections = {
            lualine_a = { {'mode', fmt = string.upper} },
            lualine_b = { 'filetype' },
            lualine_c = { {'filename', file_status = true} },
            lualine_x = { {'diagnostics',
                sources = {'nvim_lsp'},
                diagnostics_color = {
                    error = {fg = "#ff5458"},
                    warn = {fg = "#ffb378"},
                    info = {fg = "#91ddff"},
                    hint = {fg = "#B2B2B2"}
                },
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
