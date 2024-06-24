return {
    -- Color scheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        build = function() require("catppuccin").compile() end,
        dependencies = {
            "IMOKURI/line-number-interval.nvim",
            "nvim-lualine/lualine.nvim",
            "nvim-tree/nvim-web-devicons",
        },
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
                        CursorLineNr = { fg = colors.red },
                        Folded = { bg = colors.base },
                        HighlightedLineNr = { fg = colors.lavender },
                        HighlightedLineNr1 = { fg = colors.peach },
                        HighlightedLineNr2 = { fg = colors.yellow },
                        DimLineNr = { fg = colors.surface1 },
                        WinBar = { fg = colors.yellow },
                        WinBarNC = { fg = colors.subtext0 },
                    }
                end,
            })

            vim.api.nvim_cmd({
                cmd = "colorscheme",
                args = { "catppuccin" },
            }, {})

            vim.g.line_number_interval_enable_at_startup = 1
            vim.g["line_number_interval#use_custom"] = 1
            vim.g["line_number_interval#custom_interval"] = { 1, 2, 10, 20, 30, 40, 50, 60, 70, 80, 90 }

            vim.api.nvim_cmd({
                cmd = "LineNumberIntervalEnable",
            }, {})

            vim.opt.fillchars = {
                stl = "─",
                stlnc = "─",
            }

            local C = require("catppuccin.palettes").get_palette(vim.g.catppuccin_flavour)
            local O = require("catppuccin").options
            local transparent_bg = O.transparent_background and "NONE" or C.base

            require("lualine").setup({
                options = {
                    theme = {
                        normal = {
                            a = { bg = transparent_bg, fg = C.blue, gui = "bold" },
                            b = { bg = transparent_bg, fg = C.text },
                            c = { bg = transparent_bg, fg = C.blue },
                        },
                        insert = {
                            a = { bg = transparent_bg, fg = C.green, gui = "bold" },
                            b = { bg = transparent_bg, fg = C.text },
                            c = { bg = transparent_bg, fg = C.green },
                        },
                        terminal = {
                            a = { bg = transparent_bg, fg = C.green, gui = "bold" },
                            b = { bg = transparent_bg, fg = C.text },
                            c = { bg = transparent_bg, fg = C.green },
                        },
                        command = {
                            a = { bg = transparent_bg, fg = C.peach, gui = "bold" },
                            b = { bg = transparent_bg, fg = C.text },
                            c = { bg = transparent_bg, fg = C.peach },
                        },
                        visual = {
                            a = { bg = transparent_bg, fg = C.mauve, gui = "bold" },
                            b = { bg = transparent_bg, fg = C.text },
                            c = { bg = transparent_bg, fg = C.mauve },
                        },
                        replace = {
                            a = { bg = transparent_bg, fg = C.red, gui = "bold" },
                            b = { bg = transparent_bg, fg = C.text },
                            c = { bg = transparent_bg, fg = C.red },
                        },
                        inactive = {
                            a = { bg = transparent_bg, fg = C.blue },
                            b = { bg = transparent_bg, fg = C.surface1, gui = "bold" },
                            c = { bg = transparent_bg, fg = C.overlay0 },
                        },
                    },
                    globalstatus = true,
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = { { "branch", icon = " " } },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = { { "diagnostics", sources = { "nvim_lsp" } } },
                    lualine_z = { "location", "filetype" },
                },
            })
        end,
    },

    {
        "rachartier/tiny-devicons-auto-colors.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        event = "VeryLazy",
        config = function() require("tiny-devicons-auto-colors").setup() end,
    },

    -- UI
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        event = "VeryLazy",
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
            local hooks = require("ibl.hooks")

            hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)

            require("ibl").setup({
                indent = {
                    char = "|",
                },
                exclude = {
                    buftypes = { "terminal" },
                },
            })
        end,
    },

    -- Smart color column
    {
        "m4xshen/smartcolumn.nvim",
        event = "BufRead",
        config = function()
            require("smartcolumn").setup({
                colorcolumn = "120",
            })
        end,
    },

    -- Quick Highlight
    {
        "t9md/vim-quickhl",
        keys = {
            { "<Leader>m", "<Plug>(quickhl-manual-this)", mode = { "n", "x" } },
            { "<Leader>M", "<Plug>(quickhl-manual-reset)", mode = { "n", "x" } },
        },
    },
}
