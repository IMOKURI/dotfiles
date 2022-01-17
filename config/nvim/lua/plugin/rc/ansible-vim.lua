local M = {}

function M.setup()
    vim.g.ansible_unindent_after_newline = 1
    vim.g.ansible_extra_keywords_highlight = 1
    vim.g.ansible_template_syntaxes = { ["*.yaml.j2"] = "yaml", ["*.yml.j2"] = "yaml" }
end

return M
