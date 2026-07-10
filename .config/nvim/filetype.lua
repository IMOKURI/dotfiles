vim.filetype.add({
    extension = {
        ["mdx"] = "markdown",
    },
    filename = {
        ["install"] = "bash",
    },
    pattern = {
        [".*Dockerfile.*"] = "dockerfile",
        [".*git/config.*"] = "gitconfig",
        [".*git/ignore.*"] = "gitignore",
        [".*.make"] = "make",
    },
})
