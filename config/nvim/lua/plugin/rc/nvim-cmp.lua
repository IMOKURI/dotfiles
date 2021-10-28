local M = {}
local cmp = require('cmp')

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

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

            -- ["<C-n>"] = cmp.mapping(function(fallback)
            --     if cmp.visible() then
            --         cmp.select_next_item()
            --     elseif vim.fn["vsnip#available"](1) == 1 then
            --         feedkey("<Plug>(vsnip-expand-or-jump)", "")
            --     elseif has_words_before() then
            --         cmp.complete()
            --     else
            --         fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            --     end
            -- end, { "i", "s" }),

            -- ["<C-p>"] = cmp.mapping(function()
            --     if cmp.visible() then
            --         cmp.select_prev_item()
            --     elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            --         feedkey("<Plug>(vsnip-jump-prev)", "")
            --     end
            -- end, { "i", "s" }),

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
            { name = 'buffer' },
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
