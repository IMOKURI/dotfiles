local M = {}
local h = require('helper')
local telescope = require('telescope')

function M.config()
    h.map("n", "<Leader>f", "<cmd>lua require('telescope.builtin').git_files{}<CR>"                             )
    h.map("n", "<Leader>F", "<cmd>lua require('telescope').extensions.fzf_writer.files()<CR>"                   )
    h.map("n", "<Leader>g", "<cmd>lua require('telescope').extensions.fzf_writer.grep()<CR>"                    )
    h.map("n", "<Leader>o", "<cmd>lua require('telescope').extensions.frecency.frecency()<CR>"                  )
    h.map("n", "<Leader>p", "<cmd>lua require('telescope').extensions.project.project{ change_dir = true }<CR>" )
    h.map("n", "<Leader>b", "<cmd>lua require('telescope.builtin').buffers{}<CR>"                               )
    h.map("n", "<Leader>s", "<cmd>lua require('telescope.builtin').lsp_document_symbols{}<CR>"                  )
    h.map("n", "<Leader>[", "<cmd>lua require('telescope.builtin').lsp_references{}<CR>"                        )
    h.map("n", "<Leader>t", "<cmd>lua require('telescope.builtin').treesitter{}<CR>"                            )

    telescope.setup{
        defaults = {
            layout_strategy = "flex",
        }
    }
    telescope.load_extension('project')
    telescope.load_extension('frecency')
    telescope.load_extension('fzf_writer')
    telescope.load_extension('fzy_native')
end

return M
