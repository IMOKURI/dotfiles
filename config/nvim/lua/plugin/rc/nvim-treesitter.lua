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
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["ab"] = "@block.outer",
                    ["ib"] = "@block.inner",
                    ["ac"] = "@call.outer",
                    ["ic"] = "@call.inner",
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                }
            }

        },
    }
end

return M
