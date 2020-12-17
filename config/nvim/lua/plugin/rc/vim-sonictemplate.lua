local M = {}

function M.config()
    vim.g.sonictemplate_vim_template_dir = {'$MYVIMRCDIR/template'}

    -- Postfix completion does not work.
end

return M
