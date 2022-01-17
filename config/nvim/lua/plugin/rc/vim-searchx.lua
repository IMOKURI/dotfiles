local M = {}

function M.setup()
    vim.cmd([[
        let g:searchx = {}
        let g:searchx.auto_accept = v:true
        let g:searchx.scrolloff = &scrolloff
        let g:searchx.scrolltime = 500
        let g:searchx.markers = split('ABCDEFGHIJKLMNOPQRSTUVWXYZ', '.\zs')

        function g:searchx.convert(input) abort
            if a:input !~# '\k'
                return '\V' .. a:input
            endif
            return join(split(a:input, ' '), '.\{-}')
        endfunction
    ]])
end

function M.config()
    vim.keymap.set({ "n", "x" }, "?", "<Cmd>call searchx#start({ 'dir': 0 })<CR>")
    vim.keymap.set({ "n", "x" }, "/", "<Cmd>call searchx#start({ 'dir': 1 })<CR>")

    -- vim.keymap.set({"n", "x"}, "N", "<Cmd>call searchx#prev_dir()<CR>")
    -- vim.keymap.set({"n", "x"}, "n", "<Cmd>call searchx#next_dir()<CR>")

    -- vim.keymap.set({"n", "x", "c"}, "<C-k>", "<Cmd>call searchx#prev()<CR>")
    -- vim.keymap.set({"n", "x", "c"}, "<C-j>", "<Cmd>call searchx#next()<CR>")

    -- vim.keymap.set("c", ";", "<Cmd>call searchx#select()<CR>")
    -- vim.keymap.set("n", "<C-l>", "<Cmd>call searchx#clear()<CR>")
end

return M
