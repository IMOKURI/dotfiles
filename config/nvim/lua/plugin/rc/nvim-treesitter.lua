local M = {}

function M.config()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {
            'json',
            'lua',
        },
        highlight = {
            enable = true,
        },
        refactor = {
            highlight_definitions = {
                enable = true
            },
            highlight_current_scope = {
                enable = true
            },
        },
    }
end

return M
