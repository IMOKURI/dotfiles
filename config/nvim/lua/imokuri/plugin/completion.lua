return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "dcampos/cmp-snippy",
            "dcampos/nvim-snippy",
            "honza/vim-snippets",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "lukas-reineke/cmp-rg",
            "lukas-reineke/cmp-under-comparator",
            "onsails/lspkind.nvim",
        },
        event = {
            "CmdlineEnter",
            "InsertEnter",
        },
        config = function()
            local cmp = require("cmp")
            local compare = require("cmp.config.compare")
            local mapping = require("cmp.config.mapping")
            local types = require("cmp.types")
            local snippy = require("snippy")

            local feedkey = function(key, mode)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
            end

            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                formatting = {
                    format = require("lspkind").cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        before = function(entry, vim_item)
                            local alias = {
                                buffer = "[Buffer]",
                                nvim_lsp = "[LSP]",
                                nvim_lsp_signature_help = "[LSP]",
                                nvim_lua = "[Lua]",
                                path = "[Path]",
                                rg = "[Rg]",
                                snippy = "[Snippet]",
                            }

                            if entry.source.name == "nvim_lsp" then
                                vim_item.menu = entry.source.source.client.name
                            else
                                vim_item.menu = alias[entry.source.name] or entry.source.name
                            end

                            return vim_item
                        end,
                    }),
                },
                snippet = {
                    expand = function(args) snippy.expand_snippet(args.body) end,
                },
                mapping = {
                    ["<C-b>"] = mapping(mapping.scroll_docs(-4), { "i", "c" }),
                    ["<C-f>"] = mapping(mapping.scroll_docs(4), { "i", "c" }),
                    ["<C-p>"] = mapping(
                        mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }),
                        { "i", "c" }
                    ),
                    ["<C-n>"] = mapping(
                        mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }),
                        { "i", "c" }
                    ),
                    ["<C-t>"] = mapping(mapping.complete(), { "i", "c" }),
                    ["<C-e>"] = mapping({
                        i = mapping.abort(),
                        c = mapping.close(),
                    }),
                    ["<CR>"] = mapping.confirm({ select = false }),
                    ["<Tab>"] = mapping({
                        c = function()
                            if cmp.visible() then
                                cmp.select_next_item()
                            else
                                cmp.complete()
                            end
                        end,
                    }),
                    ["<S-Tab>"] = mapping({
                        c = function()
                            if cmp.visible() then
                                cmp.select_prev_item()
                            else
                                cmp.complete()
                            end
                        end,
                    }),
                    ["<C-k>"] = function(fallback)
                        if snippy.can_expand_or_advance() then
                            snippy.expand_or_advance()
                        elseif cmp.visible() then
                            feedkey("<CR>", "")
                        else
                            fallback()
                        end
                    end,
                    ["<C-j>"] = function(fallback)
                        if snippy.can_jump(-1) then
                            snippy.previous()
                        else
                            fallback()
                        end
                    end,
                },
                sources = cmp.config.sources({
                    { name = "snippy" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "path" },
                    { name = "nvim_lua" },
                }, {
                    { name = "cmdline" },
                    { name = "buffer" },
                    { name = "rg" },
                }),
                sorting = {
                    comparators = {
                        compare.offset,
                        compare.exact,
                        compare.score,
                        require("cmp-under-comparator").under,
                        compare.recently_used,
                        compare.locality,
                        compare.kind,
                        compare.sort_text,
                        compare.length,
                        compare.order,
                    },
                },
                performance = {
                    debounce = 1, -- default is 60ms
                    throttle = 1, -- default is 30ms
                },
            })

            -- Use buffer source for `/`.
            cmp.setup.cmdline("/", {
                sources = cmp.config.sources({
                    { name = "nvim_lsp_document_symbol" },
                }, {
                    { name = "buffer" },
                }),
            })

            -- Use cmdline & path source for ':'.
            cmp.setup.cmdline(":", {
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })
        end,
    },

    {
        "github/copilot.vim",
        event = {
            "CmdlineEnter",
            "InsertEnter",
        },
        init = function()
            if os.getenv("http_proxy") ~= nil then
                local u = require("imokuri.util")
                local proxy_url = u.get_proxy() --[[@as string]]
                proxy_url = string.gsub(proxy_url, "^[^:]+://", "")
                proxy_url = string.gsub(proxy_url, "/$", "")

                vim.g.copilot_proxy = proxy_url
            end

            vim.g.copilot_no_tab_map = true
        end,
        config = function()
            vim.keymap.set("i", "<C-\\>", 'copilot#Accept("<CR>")', { expr = true, replace_keycodes = false })
        end,
    },

    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        event = "VeryLazy",
        keys = {
            { "<Leader>a", "<Cmd>CodeCompanionActions<CR>", mode = "n" },
            { "<Leader>a", "<Cmd>CodeCompanionChat Add<CR>", mode = "x" },
            { "<Leader>h", "<Cmd>CodeCompanionChat Toggle<CR>", mode = "n" },
        },
        opts = {
            opts = {
                language = "Japanese",
            },
            strategies = {
                chat = {
                    tools = {
                        ["mcp"] = {
                            callback = function() return require("mcphub.extensions.codecompanion") end,
                            description = "Call tools and resources from the MCP Servers",
                        },
                    },
                },
            },
            display = {
                chat = {
                    window = {
                        layout = "float",
                        height = 0.8,
                        width = 0.8,
                    },
                    intro_message = "( ･ ´｀(●) .oO( Press ? for options, Zzz... )",
                },
            },
        },
    },

    {
        "ravitemer/mcphub.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = "VeryLazy",
        opts = {
            auto_approve = true,
            extensions = {
                codecompanion = {
                    show_result_in_chat = true,
                    make_vars = true,
                    make_slash_commands = true,
                },
            },
        },
    },

    {
        "windwp/nvim-autopairs",
        event = {
            "CmdlineEnter",
            "InsertEnter",
        },
        config = function()
            local npairs = require("nvim-autopairs")
            local Rule = require("nvim-autopairs.rule")

            npairs.setup()

            -- Jinja2
            npairs.add_rules({
                Rule("%", "%"):with_pair(function(opts)
                    local pair = opts.line:sub(opts.col - 1, opts.col)
                    return vim.tbl_contains({ "{}" }, pair)
                end),
                Rule(" ", " "):with_pair(function(opts)
                    local pair = opts.line:sub(opts.col - 2, opts.col + 1)
                    return vim.tbl_contains({ "{%%}" }, pair)
                end),
            })

            npairs.add_rules({
                Rule(" ", " "):with_pair(function(opts)
                    local pair = opts.line:sub(opts.col - 1, opts.col)
                    return vim.tbl_contains({ "()", "[]", "{}" }, pair)
                end),
                Rule("( ", " )")
                    :with_pair(function() return false end)
                    :with_move(function(opts) return opts.prev_char:match(".%)") ~= nil end)
                    :use_key(")"),
                Rule("{ ", " }")
                    :with_pair(function() return false end)
                    :with_move(function(opts) return opts.prev_char:match(".%}") ~= nil end)
                    :use_key("}"),
                Rule("[ ", " ]")
                    :with_pair(function() return false end)
                    :with_move(function(opts) return opts.prev_char:match(".%]") ~= nil end)
                    :use_key("]"),
            })
        end,
    },
}
