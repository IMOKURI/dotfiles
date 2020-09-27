local M = {}

function M.setup()
    vim.g.terraform_align = 1
    vim.g.terraform_fmt_on_save = 1
    vim.g.terraform_fold_sections = 1
end

return M
