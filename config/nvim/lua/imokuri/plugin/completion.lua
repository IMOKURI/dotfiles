return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
            "lukas-reineke/cmp-rg",
            "lukas-reineke/cmp-under-comparator",
            "onsails/lspkind.nvim",
        },
        event = {
            "CmdlineEnter",
            "InsertEnter",
        },
        init = function()
            vim.g.vsnip_snippet_dirs = {
                string.format("%s/snippet", vim.fn.stdpath("config")),
            }
        end,
        config = function()
            local cmp = require("cmp")
            local compare = require("cmp.config.compare")
            local mapping = require("cmp.config.mapping")
            local types = require("cmp.types")

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
                                emoji = "[Emoji]",
                                nvim_lsp = "[LSP]",
                                nvim_lsp_signature_help = "[LSP]",
                                nvim_lua = "[Lua]",
                                path = "[Path]",
                                rg = "[Rg]",
                                vsnip = "[Snip]",
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
                    expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
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
                    ["<C-Space>"] = mapping(mapping.complete(), { "i", "c" }),
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
                        if vim.fn["vsnip#available"]() == 1 then
                            feedkey("<Plug>(vsnip-expand-or-jump)", "")
                        elseif cmp.visible() then
                            feedkey("<CR>", "")
                        else
                            fallback()
                        end
                    end,
                    ["<C-j>"] = function(fallback)
                        if vim.fn["vsnip#available"]() == 1 then
                            feedkey("<Plug>(vsnip-jump-prev)", "")
                        else
                            fallback()
                        end
                    end,
                },

                sources = cmp.config.sources({
                    { name = "vsnip" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "path" },
                    { name = "emoji" },
                    { name = "cmdline" },
                    { name = "nvim_lua" },
                }, {
                    { name = "rg" },
                    { name = "buffer" },
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
        "windwp/nvim-autopairs",
        event = {
            "CmdlineEnter",
            "InsertEnter",
        },
        config = function()
            local npairs = require("nvim-autopairs")
            local Rule = require("nvim-autopairs.rule")

            npairs.setup({
                fast_wrap = {
                    map = "<C-i>",
                },
            })

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
