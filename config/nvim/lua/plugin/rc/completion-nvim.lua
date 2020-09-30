local M = {}

function M.setup()
    vim.g.completion_enable_snippet = 'vim-vsnip'
    vim.g.completion_matching_ignore_case = 1
    vim.g.completion_auto_change_source = 1

    vim.g.completion_chain_complete_list = {
        default = {
            default = {
                {complete_items = {'lsp', 'snippet', 'buffers', 'path'}},
                {mode = '<c-p>'},
                {mode = '<c-n>'}
            }
        },
        bash = {
            {complete_items = {'ts', 'lsp', 'snippet', 'buffers', 'path'}},
            {mode = '<c-p>'},
            {mode = '<c-n>'}
        },
        json = {
            {complete_items = {'ts', 'lsp', 'snippet', 'buffers', 'path'}},
            {mode = '<c-p>'},
            {mode = '<c-n>'}
        },
        lua = {
            {complete_items = {'ts', 'lsp', 'snippet', 'buffers', 'path'}},
            {mode = '<c-p>'},
            {mode = '<c-n>'}
        }
    }
end

function M.config()
    vim.api.nvim_command('augroup MyAutoCmd')
    vim.api.nvim_command("autocmd BufEnter * lua require'completion'.on_attach()")
    vim.api.nvim_command('augroup END')
end

return M
