local M = {}

function M.config()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {
            'bash',
            'dockerfile',
            'json',
            'lua',
            'make',
            'markdown',
            'python',
            'vim',
            'yaml',
        },
        highlight = {
            enable = true,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<Leader>i",
                node_incremental = "<Leader>n",
                scope_incremental = "<Leader>N",
                node_decremental = "<Leader>p",
            }
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
                    ["ap"] = "@parameter.outer",
                    ["ip"] = "@parameter.inner",
                }
            }
        },
    }
end

return M
