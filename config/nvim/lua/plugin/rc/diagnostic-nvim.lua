local M = {}

function M.setup()
    vim.g.diagnostic_enable_virtual_text = 1
end

function M.config()
    vim.api.nvim_command('nnoremap <silent> <Leader>D <cmd>OpenDiagnostic<CR>')
    vim.api.nvim_command('nnoremap <silent> <Leader>n <cmd>NextDiagnosticCycle<CR>')
    vim.api.nvim_command('nnoremap <silent> <Leader>p <cmd>PrevDiagnosticCycle<CR>')
end

return M
