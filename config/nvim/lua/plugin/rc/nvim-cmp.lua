local M = {}
local cmp = require("cmp")
local compare = require("cmp.config.compare")
local mapping = require("cmp.config.mapping")
local types = require("cmp.types")

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

function M.config()
    cmp.setup({
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },

        formatting = {
            format = function(entry, vim_item)
                vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

                local alias = {
                    buffer = "[buffer]",
                    emoji = "[emoji]",
                    look = "[look]",
                    nvim_lsp = "[lsp]",
                    nvim_lsp_signature_help = "[lsp]",
                    nvim_lua = "[lua]",
                    path = "[path]",
                    rg = "[rg]",
                    treesitter = "[ts]",
                    vsnip = "[snip]",
                }

                if entry.source.name == "nvim_lsp" then
                    vim_item.menu = entry.source.source.client.name
                else
                    vim_item.menu = alias[entry.source.name] or entry.source.name
                end

                return vim_item
            end,
        },

        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end,
        },

        mapping = {
            ["<C-b>"] = mapping(mapping.scroll_docs(-4), { "i", "c" }),
            ["<C-f>"] = mapping(mapping.scroll_docs(4), { "i", "c" }),
            ["<C-p>"] = mapping(mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }), { "i", "c" }),
            ["<C-n>"] = mapping(mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }), { "i", "c" }),
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
        },

        sources = cmp.config.sources({
            { name = "vsnip" },
            { name = "nvim_lsp" },
            { name = "nvim_lsp_signature_help" },
            { name = "treesitter" },
            { name = "path" },
            { name = "emoji" },
            { name = "cmdline" },
            { name = "nvim_lua" },
        }, {
            { name = "rg" },
            { name = "buffer" },
            { name = "look" },
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
end

function M.cmdline_config()
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
end

return M
