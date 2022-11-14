local icon_ok, icons = pcall(require, "nvim-web-devicons")

local M = {}

function M.winbar()
    local filename = vim.fn.expand("%:t")
    local extension = vim.fn.expand("%:e")
    local icon

    if icon_ok then
        icon = icons.get_icon(filename, extension)
    end

    local fname
    if vim.api.nvim_eval_statusline("%f", {})["str"] == "[No Name]" then
        fname = "[No Name]"
    else
        fname = vim.fn.expand("%f")
    end

    if icon then
        return "%=" .. icon .. " " .. fname .. " %m%r%="
    end
    return "%=" .. fname .. " %m%r%="
end

function M.auto_mkdir(dir, force)
    if vim.fn.isdirectory(dir) == 0 then
        if force == 1 then
            vim.fn.mkdir(dir, "p")
        else
            local is_create = vim.fn.input(string.format('"%s" does not exist. Create? [y/N]', dir))
            if string.match(is_create, "^[Yy]") ~= nil then
                vim.fn.mkdir(dir, "p")
            end
        end
    end
end

function M.close_fold()
    if vim.fn.foldlevel(".") == 0 then
        vim.api.nvim_cmd({
            cmd = "normal",
            args = { "zM" },
            bang = true,
        }, {})
        return
    end

    local foldc_lnum = vim.fn.foldclosed(".")
    vim.api.nvim_cmd({
        cmd = "normal",
        args = { "zc" },
        bang = true,
    }, {})
    if foldc_lnum == -1 then
        return
    end

    if vim.fn.foldclosed(".") ~= foldc_lnum then
        return
    end
    vim.api.nvim_cmd({
        cmd = "normal",
        args = { "zM" },
        bang = true,
    }, {})
end

function M.move_win(key)
    local curwin = vim.fn.winnr() or 0
    vim.api.nvim_cmd({
        cmd = "wincmd",
        args = { key },
    }, {})

    if curwin == (vim.fn.winnr() or 0) then
        if string.match("jk", key) ~= nil then
            vim.api.nvim_cmd({
                cmd = "wincmd",
                args = { "s" },
            }, {})
        else
            vim.api.nvim_cmd({
                cmd = "wincmd",
                args = { "v" },
            }, {})
        end
        vim.api.nvim_cmd({
            cmd = "wincmd",
            args = { key },
        }, {})
    end
end

return M
