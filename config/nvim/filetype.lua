vim.filetype.add({
    extension = {
        ["mdx"] = "markdown",
    },
    filename = {
        ["install"] = "sh",
    },
    pattern = {
        [".*Dockerfile.*"] = "dockerfile",
        [".*git/config.*"] = "gitconfig",
        [".*.make"] = "make",
    },
})
