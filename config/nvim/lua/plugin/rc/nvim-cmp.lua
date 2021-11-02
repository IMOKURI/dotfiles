local M = {}
local cmp = require('cmp')

function M.config()
    cmp.setup {
        documentation = {
            border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
            winhighlight = "FloatBorder:FloatBorder",
        },

        formatting = {
            format = function(entry, vim_item)
                vim_item.kind = require('lspkind').presets.default[vim_item.kind]
                    .. " "
                    .. vim_item.kind
                vim_item.menu = ({
                    buffer = "[Buffer]",
                    emoji = "[Emoji]",
                    nvim_lsp = "[LSP]",
                    nvim_lua = "[Lua]",
                    path = "[Path]",
                    rg = "[Rg]",
                    treesitter = "[TS]",
                    vsnip = "[Snip]",
                })[entry.source.name]
                return vim_item
            end
        },

        snippet = {
            expand = function(args)
                vim.fn['vsnip#anonymous'](args.body)
            end
        },

        mapping = {
            ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
            ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<C-e>'] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            }),

            ['<C-k>'] = function(fallback)
                if cmp.visible() then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, true, true))
                elseif vim.fn['vsnip#available']() == 1 then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '')
                else
                    fallback()
                end
            end,
        },

        sources = cmp.config.sources({
            { name = 'vsnip' },
            { name = 'nvim_lsp' },
            { name = 'treesitter' },
            { name = 'path' },
            { name = 'emoji' },
            { name = 'cmdline' },
            { name = 'nvim_lua' },
            { name = 'rg' },
            { name = 'buffer' },
            { name = 'spell' },
            { name = 'look' },
        }),

        sorting = {
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.score,
                require "cmp-under-comparator".under,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },
    }
end

function M.cmdline_config()
    -- Use buffer source for `/`.
    cmp.setup.cmdline('/', {
        sources = cmp.config.sources({
            { name = 'nvim_lsp_document_symbol' }
        }, {
            { name = 'buffer' }
        })
    })

    -- Use cmdline & path source for ':'.
    cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })
end

return M
