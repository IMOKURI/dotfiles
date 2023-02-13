return {
    -- Color scheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        build = function() require("catppuccin").compile() end,
        config = function()
            local catppuccin = require("catppuccin")

            vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

            catppuccin.setup({
                integrations = {
                    indent_blankline = {
                        enabled = true,
                        colored_indent_levels = false,
                    },
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors = {},
                            hints = {},
                            warnings = {},
                            information = {},
                        },
                        underlines = {
                            errors = { "underline" },
                            hints = { "underline" },
                            warnings = { "underline" },
                            information = { "underline" },
                        },
                    },
                    ts_rainbow = true,
                },
                custom_highlights = function(colors)
                    return {
                        WinBar = { fg = colors.yellow },
                        WinBarNC = { fg = colors.subtext0 },
                    }
                end,
            })

            vim.api.nvim_cmd({
                cmd = "colorscheme",
                args = { "catppuccin" },
            }, {})
        end,
    },

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
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
                    lualine_y = {},
                    lualine_z = {},
                },
            })
        end,
    },

    -- UI
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        event = "VimEnter",
        config = function()
            require("noice").setup({
                presets = {
                    long_message_to_split = true,
                    inc_rename = true,
                    lsp_doc_border = true,
                },
                routes = {
                    {
                        view = "notify",
                        filter = { event = "msg_showmode" },
                    },
                },
            })
        end,
    },

    -- Indent Guide
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        config = function()
            require("indent_blankline").setup({
                char = "|",
                buftype_exclude = { "terminal" },
                show_first_indent_level = false,
            })
        end,
    },
}
