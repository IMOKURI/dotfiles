local M = {}
local cmp = require('cmp')

function M.config()
    cmp.setup {
        -- completion = {
        --     completeopt = 'menu,menuone,noinsert',
        -- },

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
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
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

        sources = {
            { name = 'cmdline' },
            { name = 'emoji' },
            { name = 'look' },
            { name = 'nvim_lsp' },
            { name = 'nvim_lua' },
            { name = 'path' },
            { name = 'rg' },
            { name = 'spell' },
            { name = 'treesitter' },
            { name = 'vsnip' },
        },
    }
end

return M
