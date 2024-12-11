return {
    name = "docker ps",
    builder = function()
        return {
            name = "docker ps",
            cmd = { "docker" },
            args = { "ps" },
        }
    end,
}
