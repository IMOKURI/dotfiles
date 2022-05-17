local M = {}

function M.go_task_file()
    local task_file = string.format("roles/%s/tasks/main.y*ml", vim.fn.expand("<cfile>"))
    local found_task_file = vim.fn.split(vim.fn.glob(task_file), "\n")
    if vim.fn.len(found_task_file) == 0 then
        print(string.format('"%s" not found...', task_file))
    else
        vim.api.nvim_cmd({
            cmd = "edit",
            args = { vim.fn.fnameescape(vim.fn.remove(found_task_file, 0)) },
        }, {})
    end
end

return M
