return {
    -- Color scheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        build = function() require("catppuccin").compile() end,
        config = function()
            local catppuccin = require("catppuccin")
            local colors = require("catppuccin.palettes").get_palette()

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
                custom_highlights = {
                    WinBar = { fg = colors.yellow },
                    WinBarNC = { fg = colors.subtext0 },
                },
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
            "kyazdani42/nvim-web-devicons",
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
                routes = {
                    {
                        -- 20行以上の出力は split 画面で表示する
                        view = "split",
                        filter = { event = "msg_show", min_height = 20 },
                    },
                    {
                        -- マクロ記録開始を表示する
                        view = "notify",
                        filter = { event = "msg_showmode" },
                    },
                    {
                        view = "mini",
                        filter = {
                            event = "msg_show",
                            kind = "",
                            any = {
                                { find = "fewer lines" }, -- 複数行削除
                                { find = "more lines" }, -- 複数行追加
                                { find = "written" }, -- ファイル保存
                                { find = "yanked" }, -- コピー
                            },
                        },
                    },
                },
                lsp = {
                    hover = {
                        opts = {
                            border = "single",
                        },
                    },
                    signature = {
                        opts = {
                            border = "single",
                        },
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
