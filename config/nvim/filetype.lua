local g = vim.g

g.do_filetype_lua = 1
g.did_load_filetypes = 0

vim.filetype.add({
    filename = {
        ["Dockerfile.*"] = "dockerfile",
        ["install"] = "bash",
    },
})
