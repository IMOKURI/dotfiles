local M = {}

function M.reset()
    package.loaded["playground"] = nil
    vim.notify("Playground is reset.", vim.log.levels.INFO)
end

function M.echo(msg)
    vim.api.nvim_cmd({
        cmd = "!",
        args = { "echo", msg },
    }, {})
end

function M.notify()
    vim.notify("This is an error message.", vim.log.levels.ERROR)
    vim.notify("This is a warning message.", vim.log.levels.WARN)
    vim.notify("This is an infomation message.", vim.log.levels.INFO)
    vim.notify("This is a debug message.", vim.log.levels.DEBUG)
end

function M.metatable()
    Class = {}
    Class.seed = 440 -- クラス変数

    -- クラスメソッド
    function Class.get_seed() return Class.seed end

    function Class.set_seed(new_seed) Class.seed = new_seed end

    -- メソッド
    -- コロンでメソッドを呼び出すと、オブジェクトの値が第一引数 self に渡される
    function Class:get_a() return self.a end

    function Class:set_a(x) self.a = x end

    function Class.new(a)
        local obj = { a = a } -- インスタンス変数
        return setmetatable(obj, {
            __index = Class, -- オブジェクトに存在しない値・メソッドが参照されたとき Class を参照する
        })
    end

    -- Test: インスタンス変数
    local instance = Class.new(10)
    vim.notify("Initial instance value, a: " .. instance:get_a())

    instance:set_a(1003)
    vim.notify("Updated instance value, a: " .. instance:get_a())

    -- Test: クラス変数
    vim.notify("Initial class value, seed: " .. Class.get_seed())

    Class.set_seed(42)
    vim.notify("Updated class value, seed: " .. Class.get_seed())
end

function M.plenary_job()
    local Job = require("plenary.job")

    local results = {}
    local job = Job:new({
        command = "rg",
        args = { "--vimgrep", "-w", "IMOKURI", "." },
        on_stdout = function(_, data) table.insert(results, data) end,
    })

    P(job:sync())
end

local function echo_hello() vim.notify("Hello") end

vim.api.nvim_create_user_command("Playground", echo_hello, { desc = "echo Hello" })

return M
