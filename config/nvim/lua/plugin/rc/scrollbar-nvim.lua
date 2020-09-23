local M = {}

function M.config()
    vim.api.nvim_command('augroup MyAutoCmd')
    vim.api.nvim_command("autocmd WinEnter,FocusGained,CursorMoved,VimResized * silent! lua require('scrollbar').show()")
    vim.api.nvim_command("autocmd WinLeave,FocusLost * silent! lua require('scrollbar').clear()")
    vim.api.nvim_command('augroup END')
end

return M
