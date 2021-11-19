local M = {}
local h = require('helper')
local telescope = require('telescope')
local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')

function M.config()
    h.map("n", "<Leader>f", "<cmd>lua require('plugin.rc.telescope-nvim').project_files{}<CR>")
    h.map("n", "<Leader>g", "<cmd>lua require('telescope.builtin').live_grep{}<CR>")
    h.map("n", "<Leader>b", "<cmd>lua require('telescope.builtin').buffers{}<CR>")
    h.map("n", "<Leader>e", "<cmd>lua require('telescope.builtin').symbols{ sources = {'emoji', 'gitmoji'} }<CR>")
    h.map("n", "<Leader>[", "<cmd>lua require('telescope.builtin').lsp_references{}<CR>")
    h.map("n", "<Leader>t", "<cmd>lua require('telescope.builtin').treesitter{}<CR>")

    telescope.setup{
        defaults = {
            layout_strategy = "flex",
            mappings = {
                i = {
                    ["<Esc>"] = actions.close,
                    ["<C-i>"] = action_layout.toggle_preview,
                }
            }
        }
    }
end

function M.project_files()
    local opts = {}
    local ok = pcall(require('telescope.builtin').git_files, opts)
    if not ok then
        require('telescope.builtin').find_files(opts)
    end
end

function M.frecency()
    h.map("n", "<Leader>o", "<cmd>lua require('telescope').extensions.frecency.frecency()<CR>")

    telescope.load_extension('frecency')
end

-- function M.fzf_writer()
--     h.map("n", "<Leader>F", "<cmd>lua require('telescope').extensions.fzf_writer.files()<CR>")
--     h.map("n", "<Leader>g", "<cmd>lua require('telescope').extensions.fzf_writer.grep()<CR>")

--     telescope.load_extension('fzf_writer')
-- end

function M.fzy_native()
    telescope.load_extension('fzy_native')
end

function M.sonictemplate()
    h.map("n", "<Leader>s", "<cmd>lua require('telescope').extensions.sonictemplate.templates{}<CR>")

    telescope.load_extension('sonictemplate')
end

return M
