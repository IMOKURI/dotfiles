local M = {}

function M.config()
    require('lualine').status({
        options = {
            theme = 'palenight'
        },
        sections = {
            lualine_a = { {'mode', upper = true} },
            lualine_b = { 'filetype' },
            lualine_c = { {'filename', file_status = true} },
            lualine_x = { {'diagnostics', sources = {'nvim_lsp'}} },
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
