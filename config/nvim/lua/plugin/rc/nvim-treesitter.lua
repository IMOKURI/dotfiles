local M = {}

function M.config()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {
            'bash',
            'json',
            'lua',
            'python',
        },
        highlight = {
            enable = true,
        },
        indent = {
            enable = false,
        },
        refactor = {
            highlight_definitions = {
                enable = true
            },
            highlight_current_scope = {
                enable = false
            },
        },
        rainbow = {
            enable = true,
            disable = {'bash'}
        },
    }
end

return M
