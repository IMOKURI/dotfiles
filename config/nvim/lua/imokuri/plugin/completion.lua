return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "dcampos/cmp-snippy",
            "dcampos/nvim-snippy",
            "honza/vim-snippets",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-emoji",
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
                                emoji = "[Emoji]",
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
                    { name = "emoji" },
                    { name = "cmdline" },
                    { name = "nvim_lua" },
                }, {
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
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        dependencies = {
            "github/copilot.vim",
            "nvim-lua/plenary.nvim",
        },
        event = "VeryLazy",
        config = function()
            local u = require("imokuri.util")
            require("CopilotChat").setup({
                proxy = u.get_proxy(),
                prompts = {
                    Generate = {
                        prompt = "/COPILOT_GENERATE 選択したコードのコメントに従って、新しいコードを生成してください。",
                    },
                    Explain = {
                        prompt = "/COPILOT_EXPLAIN 上記のコードを日本語で説明してください。",
                    },
                    Review = {
                        prompt = "/COPILOT_REVIEW このコードをレビューしてください。",
                    },
                    Fix = {
                        prompt = "/COPILOT_GENERATE このコードには問題があります。バグを修正したコードを表示してください。",
                    },
                    Optimize = {
                        prompt = "/COPILOT_GENERATE 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。",
                    },
                    Docs = {
                        prompt = "/COPILOT_GENERATE 選択したコードのドキュメントコメントを書いてください。",
                    },
                    Tests = {
                        prompt = "/COPILOT_GENERATE 選択したコードの詳細なユニットテストを書いてください。",
                    },
                    FixDiagnostic = {
                        prompt = "コードの診断結果に従って問題を修正してください。",
                        selection = require("CopilotChat.select").diagnostics,
                    },
                    Commit = {
                        prompt = "commitize の規則に従って、変更に対するコミットメッセージを記述してください。 タイトルは最大50文字で、メッセージは72文字で折り返されるようにしてください。 メッセージ全体を gitcommit 言語のコード ブロックでラップしてください。メッセージは日本語でお願いします。",
                        selection = require("CopilotChat.select").gitdiff,
                    },
                    CommitStaged = {
                        prompt = "commitize の規則に従って、変更に対するコミットメッセージを記述してください。 タイトルは最大50文字で、メッセージは72文字で折り返されるようにしてください。 メッセージ全体を gitcommit 言語のコード ブロックでラップしてください。メッセージは日本語でお願いします。",
                        selection = function(source) return require("CopilotChat.select").gitdiff(source, true) end,
                    },
                },
                window = {
                    layout = "horizontal",
                },
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
