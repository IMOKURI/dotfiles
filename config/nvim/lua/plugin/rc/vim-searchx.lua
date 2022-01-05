local M = {}
local h = require('helper')

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
    h.map("n", "?", "<Cmd>call searchx#start({ 'dir': 0 })<CR>")
    h.map("n", "/", "<Cmd>call searchx#start({ 'dir': 1 })<CR>")
    h.map("x", "?", "<Cmd>call searchx#start({ 'dir': 0 })<CR>")
    h.map("x", "/", "<Cmd>call searchx#start({ 'dir': 1 })<CR>")
    h.map("c", ";", "<Cmd>call searchx#select()<CR>")

    -- h.map("n", "N", "<Cmd>call searchx#prev_dir()<CR>")
    -- h.map("n", "n", "<Cmd>call searchx#next_dir()<CR>")
    h.map("x", "N", "<Cmd>call searchx#prev_dir()<CR>")
    h.map("x", "n", "<Cmd>call searchx#next_dir()<CR>")

    h.map("n", "<C-k>", "<Cmd>call searchx#prev()<CR>")
    h.map("n", "<C-j>", "<Cmd>call searchx#next()<CR>")
    h.map("x", "<C-k>", "<Cmd>call searchx#prev()<CR>")
    h.map("x", "<C-j>", "<Cmd>call searchx#next()<CR>")
    h.map("c", "<C-k>", "<Cmd>call searchx#prev()<CR>")
    h.map("c", "<C-j>", "<Cmd>call searchx#next()<CR>")

    h.map("n", "<C-l>", "<Cmd>call searchx#clear()<CR>")
end

return M
